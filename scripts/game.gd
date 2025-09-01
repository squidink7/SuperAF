extends Node

var burger_scene = load("res://objects/burger/burger.tscn")

func print_msg():
	print("Heya Gamer, ~~UwU~~")
	get_tree().quit()

# func _input(event: InputEvent) -> void:
# 	if event is InputEventKey:
# 		if event.is_pressed():
# 			print_msg()

func spawn_burger() -> void:
	%BurgerSpawner.progress_ratio = randf_range(0,1)

	var burger = burger_scene.instantiate()

	add_child(burger)

	burger.global_position = %BurgerSpawner.global_position

	burger.rotation = deg_to_rad(15)

func game_over():
	$Label.show()
	get_tree().paused = true