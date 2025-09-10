extends Node

# This class handles the signals from terminal and tells the Character and villian classes what to do.


# Values are in inspector so they can be changed to whatever we decide on.
@export var correct_before_life_increase: int
var current_correct_count := 0

@export var mistakes_before_life_loss: int
var current_mistake_count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Hero Animation".play("hero_walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_life_changed(current_lives: int, max_lives: int, increase: bool):
	if (increase):
		%Villian._on_life_gain(current_lives, max_lives)
	else:
		%Villian._on_life_lost(current_lives, max_lives)
		
