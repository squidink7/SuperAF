extends Node

var clouds = [
	preload("res://objects/Clouds/cloud0.tscn"),
	preload("res://objects/Clouds/cloud1.tscn"),
	preload("res://objects/Clouds/cloud2.tscn"),
	preload("res://objects/Clouds/cloud3.tscn")
	]

var bushes = [
]

var rocks = [
	preload("res://objects/Rocks/rock0.tscn"),
	preload("res://objects/Rocks/rock1.tscn")
]

#Object spawn position ranges:
var background_y_range = [100, 250]
var forground_y_range = [375, 450]
var object_x_position = 1200

var background_speed = 320
var foreground_speed = 800

#Object spawn timers:
var max_time = 3;
var timer = 0

var cloud_spawn_time = 0;
var cloud_spawned = false;

var rock_spawn_time = 0;
var rock_spawned = false

var bush_spawn_time = 0;
var bush_spawned = false



func get_new_spawn_times():
	cloud_spawn_time = randf_range(0.5, max_time)
	rock_spawn_time = randf_range(0.5, max_time)
	bush_spawn_time = randf_range(0.5, max_time) 

	cloud_spawned = false;
	rock_spawned = false;
	bush_spawned = false;

func spawn_cloud():
	var cloud = clouds[randi_range(0, len(clouds) - 1)].instantiate()
	add_child(cloud)
	cloud.configure_object(background_speed, Vector2(object_x_position, randi_range(background_y_range[0], background_y_range[1])), 30)  

func spawn_rock():
	var rock = rocks[randi_range(0, len(rocks) - 1)].instantiate()
	add_child(rock)
	rock.configure_object(foreground_speed, Vector2(object_x_position, randi_range(forground_y_range[0], forground_y_range[1])), 30)

func _ready():
	get_new_spawn_times()

func _process(delta: float):
	timer += delta
	
	if timer > cloud_spawn_time and not cloud_spawned:
		cloud_spawned = true
		spawn_cloud()

	if timer > rock_spawn_time and not rock_spawned:
		rock_spawned = true
		spawn_rock()
	
	if timer > bush_spawn_time and not bush_spawned:
		bush_spawned = true
		pass

	if timer >= max_time:
		timer = 0;
		get_new_spawn_times()
		
