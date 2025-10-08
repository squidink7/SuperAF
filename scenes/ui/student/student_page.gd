extends Control

signal button_clicked()

var current_topic: String
var current_lesson: String

var current_student_id := ''

func _ready():
	$/root/Main.play_music()
	

func setup(student_id: String):
	var topics = Data.get_topics()

	current_student_id = student_id
	%StudentID.text = student_id

	for topic in topics:
		var b = Button.new()
		b.text = topic
		b.pressed.connect(show_lessons.bind(topic))
		b.add_theme_color_override("font_color", Color.BLACK)
		b.add_theme_stylebox_override("normal", load("res://assets/styles/button_default.tres"))
		b.add_theme_stylebox_override("hover", load("res://assets/styles/button_hover.tres"))
		b.add_theme_stylebox_override("hover_pressed", load("res://assets/styles/button_pressed.tres"))
		b.add_theme_stylebox_override("pressed", load("res://assets/styles/button_pressed.tres"))
		%Topics.add_child(b)

func show_lessons(topic: String):
	var lessons = Data.get_lessons(topic)
	
	# Clear lessons
	for child in %Lessons.get_children():
		%Lessons.remove_child(child)
		child.queue_free()

	for lesson in lessons:
		if !Data.get_lesson_enabled(topic, lesson):
			continue
		
		var b = Button.new()
		b.text = lesson
		b.pressed.connect(set_lesson.bind(topic, lesson))
		b.add_theme_color_override("font_color", Color.BLACK)
		b.add_theme_stylebox_override("normal", load("res://assets/styles/button_default.tres"))
		b.add_theme_stylebox_override("hover", load("res://assets/styles/button_hover.tres"))
		b.add_theme_stylebox_override("hover_pressed", load("res://assets/styles/button_pressed.tres"))
		b.add_theme_stylebox_override("pressed", load("res://assets/styles/button_pressed.tres"))
		%Lessons.add_child(b)
		button_clicked.emit()

func set_lesson(topic: String, lesson: String):
	button_clicked.emit()
	var lesson_text = Data.get_lesson(topic, lesson)

	current_topic = topic
	current_lesson = lesson

	%LessonText.text = lesson_text

	%GoButton.disabled = false

func get_lesson_settings():
	var game_mode = ""
	var game_difficulty = 0

	if %SubwaySurfersMode.button_pressed:
		game_mode = "surfers"
	elif %MeteorDefenseMode.button_pressed:
		game_mode = "asteroids"
	elif %RandomGameMode.button_pressed:
		game_mode = "asteroids" if randi_range(0, 1) else "surfers"

	if %Difficulty1.button_pressed:
		game_difficulty = 1
	elif %Difficulty2.button_pressed:
		game_difficulty = 2
	elif %Difficulty3.button_pressed:
		game_difficulty = 3

	return [game_mode, game_difficulty]

func start_lesson():
	var game_settings = get_lesson_settings()

	var game = $/root/Main.load_scene('game/game')
	
		
	$/root/Main.add_child(game)
	game.setup(current_student_id, current_topic, current_lesson, game_settings[0], game_settings[1])
	$/root/Main.remove_child(self)

func exit() -> void:
	$/root/Main.set_scene($/root/Main.load_scene('ui/admin/login'))
