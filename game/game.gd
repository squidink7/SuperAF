extends Node

var score: int = 0
var score_multiplier := 1.0
var time: float = 0

func _process(delta: float) -> void:
	time += delta
	$Time.text = 'Time: ' + str(time)

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
