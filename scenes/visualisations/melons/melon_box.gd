extends Node3D

var melon_scene := load('res://scenes/visualisations/melons/melon.tscn')

var melons = []

func spawn_melon():
	var melon = melon_scene.instantiate()

	%MelonSpawner.add_child(melon)
	melons.append(melon)

	melon.apply_central_impulse(Vector3(randf_range(-1,1), 0, randf_range(-1,1)))

func destroy_melon():
	if melons.size() == 0: return

	var rand_melon := randi_range(0, melons.size()-1)

	var melon = melons[rand_melon]

	melon.destroy()
	melons.erase(melon)
