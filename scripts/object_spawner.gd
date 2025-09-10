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

var background_speed = 50
var foreground_speed = 100

#Object spawn timers:
var max_time = 7;
var timer = 0;
var cloud_spawn_time = 0;
var rock_spawn_time = 0;
var bush_spawn_time = 0;



func get_new_spawn_times():
	cloud_spawn_time = randf_range(3, max_time)
	rock_spawn_time = randf_range(3, max_time)
	bush_spawn_time = randf_range(3, max_time) 

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
	
	if (cloud_spawn_time - 0.005) < timer and timer < cloud_spawn_time:
		spawn_cloud()

	if (rock_spawn_time - 0.005) < timer and timer < rock_spawn_time:
		spawn_rock()
	
	if (bush_spawn_time - 0.005) < timer and timer < bush_spawn_time:
		pass

	if timer >= max_time:
		timer = 0;
		get_new_spawn_times()
		
