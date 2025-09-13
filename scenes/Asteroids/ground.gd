extends Area2D

signal destroy_asteroid


func _on_area_entered(area: Area2D) -> void:
	destroy_asteroid.emit()
