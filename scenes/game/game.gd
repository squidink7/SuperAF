class_name Game
extends Control


#enum Difficulty {EASY, MEDIUM, HARD}

var game_difficulty = 0 #Can you interact with private enums from external scripts? Surely its too much pain to figure out.


signal life_changed(current_lives: int, max_lives: int, increase: bool)
signal game_win()
signal game_lose()

var score: int = 0
var score_multiplier := 1.0
var time: float = 0

@export var correct_before_life_increase: int
var current_correct_count := 0

@export var mistakes_before_life_loss: int
var current_mistake_count := 0


@export var max_lives: int
@export var lives: int:

	set(value):
		lives = clamp(value,0, max_lives)


func setup(lesson_text: String, game_mode: String, difficulty: int):
	$Terminal.setup(lesson_text)
	
	var visualisation = $/root/Main.load_scene('visualisations/' + game_mode + '/visualisation')

	$Terminal.correct_word_entered.connect(visualisation.correct)
	$Terminal.incorrect_character_entered.connect(visualisation.incorrect)
	life_changed.connect(visualisation.life_changed)
	game_win.connect(visualisation.game_win)
	game_lose.connect(visualisation.game_lose)
	$Visualisation.add_child(visualisation)
	
	match difficulty:
		1:
			correct_before_life_increase = 3
			mistakes_before_life_loss = 3
			max_lives = 6
			lives = 4
		2:
			correct_before_life_increase = 4
			mistakes_before_life_loss = 2
			max_lives = 5
			lives = 3
		3:
			correct_before_life_increase = 5
			mistakes_before_life_loss = 1
			max_lives = 3
			lives = 2
		
		
	

	

func _process(delta: float) -> void:
	time += delta
	$Time.text = 'Time: ' + str("%0.2f" % time,"s")

func correct():
	score_multiplier += 0.5
	score += 1 * score_multiplier
	print("Correct word entered!")
	$Score.text = 'Score: ' + str(score)
	print(score)
	%CorrectSound.play()

func incorrect():
	score_multiplier = 0.0
	score -= 1
	print("Incorrect character pressed!")
	$Score.text = 'Score: ' + str(score)
	%IncorrectSound.play()	

func typing_correct() -> void:
	current_correct_count += 1
	
	if (current_correct_count >= correct_before_life_increase):
		current_correct_count = 0
		lives += 1
		print("Life gained, current " + str(lives))
		life_changed.emit(lives, max_lives, true)
		



func typing_incorrect() -> void:
	current_mistake_count += 1
	if (current_mistake_count >= mistakes_before_life_loss):
		current_mistake_count = 0
		lives -= 1
		print("Life lost, current: " + str(lives))
		life_changed.emit(lives, max_lives, false)
		
		if (lives <= 0): 
			game_lose.emit()
			
func typing_complete():
	game_win.emit()


func exit() -> void:
	$/root/Main.set_scene($/root/Main.load_scene('ui/student/student_page'))
