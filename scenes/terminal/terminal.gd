extends Control

signal correct_word_entered()
signal incorrect_character_entered()
signal typing_complete()
signal key_pressed()

var valid_input_for_sound = false;

var source_text: String = "The quick brown fox jumps over the lazy dog"

const allowed_characters = [
	'A','B','C','D','E','F','G','H','I',
	'J','K','L','M','N','N','O','P','Q',
	'R','S','T','U','V','W','X','Y','Z',
	'.',',',';','?','!'
]

const LOOKAHEAD = 2

var char_index: int = 0
var incorrect_chars: String = ''

func setup(text: String):
	source_text = text
	update_text()
	process_mode = Node.PROCESS_MODE_INHERIT

func update_text():
	var text = source_text.substr(0, char_index)
	
	if incorrect_chars != '':
		text += '[color=#f00]' + incorrect_chars + '[/color]'
	else:
		var prompt_text = get_prompt_text()
		if prompt_text.length() > 0:
			text += '[color=#888][u]' + prompt_text[0] + '[/u]' + prompt_text.substr(1) + '[/color]'
	
	%Label.text = text

# Returns prompt text, including next `LOOKAHEAD` words of the text
func get_prompt_text() -> String:
	var prompt = source_text.substr(char_index).split(' ')
	return ' '.join(prompt.slice(0, LOOKAHEAD+1))

# Adds a character to the typed text
func add_character(chr: String):
	# Checks if the chatacter is correct
	var correct = false
	if source_text.length() > char_index && source_text[char_index].to_upper() == chr && incorrect_chars.length() == 0:
		char_index += 1
		correct = true
	else:
		# Add incorrect character to array
		incorrect_chars += chr.to_lower().replace(' ', '▮')
		incorrect_character_entered.emit()
	
	update_text()

	# Reached end of text
	if correct && char_index == source_text.length():
		typing_complete.emit()
		return

	# Reached end of word
	if correct && source_text[char_index] == ' ':
		correct_word_entered.emit()

func delete_character():
	if incorrect_chars != '':
		incorrect_chars = incorrect_chars.erase(incorrect_chars.length()-1)
	else:
		char_index = max(char_index-1, 0)
	update_text()

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		valid_input_for_sound = true;

		if event.keycode == KEY_BACKSPACE:
			delete_character()
		elif event.keycode == KEY_SPACE:
			add_character(' ')
		elif event.keycode == KEY_PERIOD:
			add_character('.')
		elif event.keycode == KEY_COMMA:
			add_character(',')
		elif event.keycode == KEY_ENTER:
			add_character('\n')
		elif event.keycode == KEY_MINUS:
			add_character('-')
		elif OS.get_keycode_string(event.keycode) in allowed_characters:
			# Pressed key to enter text
			var key = OS.get_keycode_string(event.keycode)
			add_character(key)
		else:
			valid_input_for_sound = false;
			print('Ignoring key press: ' + OS.get_keycode_string(event.keycode))

		if valid_input_for_sound == true:
			key_pressed.emit()

func game_over():
	process_mode = Node.PROCESS_MODE_DISABLED
