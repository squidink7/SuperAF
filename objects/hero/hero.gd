extends Node2D

const SPEED = 2

func _physics_process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	
	look_at(mouse_pos)

	position = position.move_toward(mouse_pos, SPEED)