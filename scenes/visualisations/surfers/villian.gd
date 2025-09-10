extends CharacterBody2D

@onready var character: CharacterBody2D = %Character

# The default position is the position of the object when the player has max livers
@onready var default_position := self.global_position.x
@onready var character_position = character.global_position.x
@onready var character_target_position: float = self.global_position.x

func get_new_target_position(lives: int, max_lives: int):
	return character_position - (((character_position - default_position) / max_lives) * lives)
	#return ((character_position - default_position) / character.max_lives)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Adjusts the starting position of the object based on however many lives are set by default
	if (character.max_lives != character.lives):
		var life_difference = character.max_lives - character.lives
		character_target_position = get_new_target_position(character.lives, character.max_lives)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.global_position.x = lerp(self.global_position.x, character_target_position, 0.2)


func _on_life_lost(current_lives: int, max_lives: int) -> void:
	
	# Since both character and villian signals run at the same time, 1 has to be removed
	if (character.lives == 0):
		print("Caught")
	else:
		character_target_position = get_new_target_position(current_lives, max_lives)
	
	
	
	#TODO: Animation / change position
	pass # Replace with function body.


func _on_life_gain(current_lives: int, max_lives: int) -> void:
	
	# Since both character and villian signals run at the same time, 1 has to be added
	if (character.lives == character.max_lives):
		
		if (self.global_position.x > default_position):
			character_target_position = get_new_target_position(current_lives, max_lives)
			return

		print("Already at max distance")
		return
		
	else:
		character_target_position = get_new_target_position(current_lives, max_lives)
	#TODO Animation / change position
