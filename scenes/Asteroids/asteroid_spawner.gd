extends Node2D

var asteroid = preload("res://objects/asteroids/asteroid0.tscn")

var spawn_position: Vector2
#@onready var viewport: SubViewport = get_node()
@onready var viewport: SubViewport = $'../../../'
@onready var viewport_x: int = viewport.size.x


func show_lazers(asteroid_pos : Vector2):	
	var l := %lazer0
	l.points[0] = l.to_local(%character.global_position) + Vector2(0, -50)
	l.points[1] = l.to_local(asteroid_pos)
	l.show()

func spawn_asteroid():
	var current_asteroid = asteroid.instantiate()
	add_child(current_asteroid)

	%spawn_position.progress_ratio = randf_range(0.1, 0.9)
	current_asteroid.configure_position(%spawn_position.global_position)
	
func destroy_asteroid(showLazer: bool):

	if (self.get_child(0) == null):
		return
	
	var child_asteroid = self.get_child(0)
	%AsteroidParticles.global_position = child_asteroid.global_position
	child_asteroid.queue_free()
	
	%AsteroidParticles.emitting = true
	
	if (showLazer):
		%laser_sound.play();
		show_lazers(child_asteroid.global_position)
		await get_tree().create_timer(.1).timeout
		%lazer0.hide()
	
	call_deferred("spawn_asteroid")

func typing_incorrect():
	var child_asteroid = self.get_child(0)
	child_asteroid.speed_up()
