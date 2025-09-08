class_name Game
extends Control

var score: int = 0
var score_multiplier := 1.0
var time: float = 0

func setup(lesson_text: String, game_mode: String):
	$Terminal.source_text = lesson_text
	
	var game = $/root/Main.load_scene('visualisations/' + game_mode + '/visualisation')

	$Terminal.correct_word_entered.connect(game.correct)
	$Terminal.incorrect_character_entered.connect(game.incorrect)

	$Visualisation.add_child(game)

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
