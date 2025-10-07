extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AsteroidSpawner.spawn_asteroid()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Calls when a wrong letter is typed
func on_incorrect():
	%AsteroidSpawner.typing_incorrect()
	
func on_correct():
	%AsteroidSpawner.destroy_asteroid(true)
	
	

func on_life_changed(curret_lives: int, max_lives: int, increase: bool):
	#TODO: Life visualisation
	pass
