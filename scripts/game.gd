extends Node

func print_msg():
	print("Heya Gamer, ~~UwU~~")
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed():
			print_msg()