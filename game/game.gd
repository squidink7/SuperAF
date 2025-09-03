extends Node

var score: int = 0
var time: float = 0

func _process(delta: float) -> void:
	time += delta
	$Time.text = 'Time: ' + str(time)

func correct():
	score += 1
	print("Correct word entered!")
	$Score.text = 'Score: ' + str(score)

func incorrect():
	score -= 1
	print("Incorrect character pressed!")
	$Score.text = 'Score: ' + str(score)