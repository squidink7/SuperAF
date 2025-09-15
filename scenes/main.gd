extends Node

@export var default_scene: PackedScene

# Start game
func _ready() -> void:
	# Show initial scene unless one already provided
	if !OS.is_debug_build() || get_child_count() == 0:
		set_scene(default_scene.instantiate())

# Load a new scene
func load_scene(scene: String):
	var new_scene = load('res://scenes/' + scene + '.tscn')
	if new_scene == null:
		print("Scene path is invalid")
	return new_scene.instantiate()

# Update the currently running scene
func set_scene(scene: Node):
	clear_scene()
	add_child(scene)

# Clear any existing scene
func clear_scene():
	for scene in get_children():
		remove_child(scene)
		scene.queue_free()
