extends Area2D

var speed = 70	
var spelling_failure = false
# Called when the node enters the scene tree for the first time.
func configure_position(spawn_position: Vector2):
	self.global_position = spawn_position

	%asteroid_animation.play("rotate")
	%asteroid_animation.speed_scale = randf_range(-1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance_to_move = speed * delta
	self.global_position.y += distance_to_move

func speed_up():
	spelling_failure = true
	speed = 2000
