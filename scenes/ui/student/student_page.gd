extends Control

var current_topic: String
var current_lesson: String

func _ready():
	var topics = Data.get_topics()

	for topic in topics:
		var b = Button.new()
		b.text = topic
		b.pressed.connect(show_lessons.bind(topic))
		%Topics.add_child(b)

func show_lessons(topic: String):
	var lessons = Data.get_lessons(topic)
	
	# Clear lessons
	for child in %Lessons.get_children():
		%Lessons.remove_child(child)
		child.queue_free()

	for lesson in lessons:
		var b = Button.new()
		b.text = lesson
		b.pressed.connect(set_lesson.bind(topic, lesson))
		%Lessons.add_child(b)

func set_lesson(topic: String, lesson: String):
	var lesson_text = Data.get_lesson(topic, lesson)

	current_topic = topic
	current_lesson = lesson

	%LessonText.text = lesson_text

func start_lesson():
	var lesson_text = Data.get_lesson(current_topic, current_lesson)
	
	var game = $/root/Main.load_scene('game/game')
	game.setup(lesson_text)
	$/root/Main.set_scene(game)
