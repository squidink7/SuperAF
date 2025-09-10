extends CharacterBody2D


@export var max_lives: int
@export var lives: int:


	set(value):
		lives = clamp(value,0, max_lives)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

func _on_game_logic_manager_life_lost() -> void:
		lives -= 1
		print("Life lost, current: " + str(lives))
		
		#TODO: Play animation


func _on_game_logic_manager_life_gain() -> void:
	lives += 1
	print("Life gained, current " + str(lives))
	#TODO: Play animation
