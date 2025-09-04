extends Control

signal correct_word_entered()
signal incorrect_character_entered()
signal typing_complete()

var current_text: String = "The quick brown fox jumps over the lazy dog"

const allowed_characters = [
	'A','B','C','D','E','F','G','H','I',
	'J','K','L','M','N','N','O','P','Q',
	'R','S','T','U','V','W','X','Y','Z',
	'.',',',';','?','!'
]

const LOOKAHEAD = 2

var current_word: int = 0
var typed_text: String = ""
var prompt_text: String = ""

func _ready():
	update_prompt()

func update_text():
	$InputLabel.text = typed_text

func update_prompt():
	var new_prompt = current_text.split(" ").slice(0, current_word+LOOKAHEAD)
	prompt_text = " ".join(new_prompt)
	$PromptLabel.text = prompt_text

func add_character(chr: String):	
	var correct = false
	if current_text.length() > typed_text.length() && current_text[typed_text.length()].to_upper() == chr:
		chr = current_text[typed_text.length()]
		correct = true
	else:
		incorrect_character_entered.emit()
	
	typed_text += chr
	
	update_text()

	if correct && chr == ' ':
		current_word += 1
		update_prompt()
		correct_word_entered.emit()
	
	if typed_text.length() == current_text.length():
		typing_complete.emit()

func delete_character():
	if typed_text.length() > 0:
		typed_text = typed_text.substr(0, typed_text.length()-1)
	
	update_text()

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			delete_character()
		elif event.keycode == KEY_SPACE:
			add_character(' ')
		elif event.keycode == KEY_PERIOD:
			add_character('.')
		elif event.keycode == KEY_COMMA:
			add_character(',')
		elif OS.get_keycode_string(event.keycode) in allowed_characters:
			# Pressed key to enter text
			var key = OS.get_keycode_string(event.keycode)
			add_character(key)
		else:
			print('Ignoring key press: ' + OS.get_keycode_string(event.keycode))
