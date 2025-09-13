extends Area2D

var speed = 70	
# Called when the node enters the scene tree for the first time.
func configure_position(spawn_position: Vector2):
	self.global_position = spawn_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var distance_to_move = speed * delta
	self.global_position.y += distance_to_move

func speed_up():
	speed = 2000
