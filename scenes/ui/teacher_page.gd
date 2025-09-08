extends Control


func _ready():
	var topics = Data.get_topics()

	for topic in topics:
		var b = Button.new()
		b.text = topic
		b.pressed.connect(show_lessons.bind(topic))
		%Topics.add_child(b)

func show_lessons(topic: String):
	var lessons = Data.get_lessons(topic)

	for lesson in lessons:
		var b = Button.new()
		b.text = lesson
		b.pressed.connect(show_lesson.bind(topic, lesson))
		%Lessons.add_child(b)

func show_lesson(topic: String, lesson: String):
	var lesson_text = Data.get_lesson(topic, lesson)

	%LessonText.text = lesson_text

