extends Control

var lesson_item = load('res://scenes/ui/teacher/lesson_item.tscn')
var student_score_item = load('res://scenes/ui/teacher/student_passcheck.tscn')

func setup():
	var topics = Data.get_topics()

	for topic in topics:
		var b = Button.new()
		b.text = topic
		b.pressed.connect(show_lessons.bind(topic))
		%Topics.add_child(b)

func show_lessons(topic: String):
	# Clear lessons
	for child in %Lessons.get_children():
		%Lessons.remove_child(child)
		child.queue_free()

	var lessons = Data.get_lessons(topic)

	for lesson in lessons:
		var lesson_text = Data.get_lesson(topic, lesson)
		var li = lesson_item.instantiate()
		li.set_data(lesson, lesson_text, true)
		li.selected.connect(show_lesson.bind(topic, lesson))
		%Lessons.add_child(li)

func exit():
	$/root/Main.set_scene($/root/Main.load_scene('ui/admin/login'))

func show_lesson(topic: String, lesson: String):
	# Clear student completion
	for child in %StudentScores.get_children():
		%StudentScores.remove_child(child)
		child.queue_free()
	
	var students = Data.get_students()

	for s in students:
		var score = Data.get_highscore(s, topic, lesson)
		var score_item = student_score_item.instantiate()
		score_item.set_data(s, score)
		%StudentScores.add_child(score_item)


#func student_pass():
#	var students = Data.get_studentpass(studentID)
#		for student in students:
#			var chk = student_passcheck.instantiate()
#			chk.set_data(studentID, true, true)
#			%StudentPassPanel.add_child(chk)
