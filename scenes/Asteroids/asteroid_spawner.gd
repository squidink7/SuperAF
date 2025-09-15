extends Node2D

var asteroid = preload("res://objects/asteroids/asteroid0.tscn")
var spawn_position: Vector2
#@onready var viewport: SubViewport = get_node()
@onready var viewport: SubViewport = $'../../../'
@onready var viewport_x: int = viewport.size.x


func spawn_asteroid():
	var current_asteroid = asteroid.instantiate()
	add_child(current_asteroid)

	%spawn_position.progress_ratio = randf_range(0.1, 0.9)
	current_asteroid.configure_position(%spawn_position.global_position)
	
func destroy_asteroid():
	var child_asteroid = self.get_child(0)
	child_asteroid.queue_free()
	#await get_tree().create_timer(0.1).timeout
	call_deferred("spawn_asteroid")

func typing_incorrect():
	#TODO: FIX
	var child_asteroid = self.get_child(0)
	child_asteroid.speed_up()
