extends Node

# This class handles the signals from terminal and tells the Character and villian classes what to do.

signal life_lost
signal life_gain

# Values are in inspector so they can be changed to whatever we decide on.
@export var correct_before_life_increase: int
var current_correct_count := 0

@export var mistakes_before_life_loss: int
var current_mistake_count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_terminal_incorrect_character_entered() -> void:
	current_mistake_count += 1
	
	if (current_mistake_count >= mistakes_before_life_loss):
		current_mistake_count = 0
		life_lost.emit()
		

func _on_terminal_correct_word_entered() -> void:
	current_correct_count += 1
	
	if (current_correct_count >= correct_before_life_increase):
		current_correct_count += 1
		life_gain.emit()
		




func _on_character_game_over() -> void:
	print("game over")
	#TODO: Display game over screen and go back to start menu
