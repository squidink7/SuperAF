extends Node2D

var move : bool = false
var time_to_live : int = 0
var counter : float = 0
var movement_speed = 0

func configure_object(speed : float, intial_position : Vector2, ttl : int):
	time_to_live = ttl
	movement_speed = speed
	self.global_position = intial_position

	move = true;

func _process(delta: float):
	if move:
		self.global_position = Vector2(self.global_position.x - movement_speed * delta, self.global_position.y)
		counter += delta

		if counter > time_to_live:
			self.queue_free() #Delete?
