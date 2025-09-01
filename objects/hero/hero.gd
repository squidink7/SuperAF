extends Node2D

const SPEED = 2

signal hit()

func _physics_process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	
	look_at(mouse_pos)

	position = position.move_toward(mouse_pos, SPEED)

func on_hit(area:Area2D) -> void:
	if area.name == "BurgerBox":
		emit_signal("hit")
