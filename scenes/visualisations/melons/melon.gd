extends RigidBody3D

func destroy():
	$Model.visible = false
	$Particles.emitting = true

func _on_particles_finished() -> void:
	queue_free()