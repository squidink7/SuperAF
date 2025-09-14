extends Node2D

var asteroid_single = preload("res://objects/asteroids/asteroid_single.tscn")
var spawn_position: Vector2
#@onready var viewport: SubViewport = get_node()
@onready var viewport: SubViewport = $'../../../'
@onready var viewport_x: int = viewport.size.x


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_asteroid():
	var current_asteroid = asteroid_single.instantiate()
	add_child(current_asteroid)
	current_asteroid.configure_position(Vector2(randi_range(-380, viewport_x / 2), -480))
	
func destroy_asteroid():
	var child_asteroid = self.get_child(0)
	child_asteroid.queue_free()
	#await get_tree().create_timer(0.1).timeout
	call_deferred("spawn_asteroid")

func typing_incorrect():
	#TODO: FIX
	var child_asteroid = self.get_child(0)
	child_asteroid.speed_up()
