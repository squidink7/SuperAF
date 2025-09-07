class_name Data
extends Node


# savedata structure
# 
# - topics/
#  - quiz.txt
#  - grades.json
#  - lessons/
#   - lesson text.txt
#   - highscores.json
# - students/
#  - student data.json

func _ready():
	var stud = Student.new()
	stud.id = 'test'
	stud.name = 'Jeremy Exampleton'
	set_student(stud)

	print(get_topics())
	print(get_lessons('health'))
	print(get_lesson('health', 'cardio'))

static func get_student(id: String) -> Student:
	var file = FileAccess.open("user://students/" + id, FileAccess.READ)
	
	if file == null:
		print('Cannot find student with id: ' + id )
		return null
	
	var data = str_to_var(file.get_as_text())
	
	if data is Student:
		return data
	else:
		print('Error loading student')
		return null

static func set_student(student: Student):
	DirAccess.make_dir_absolute("user://students/")
	var file = FileAccess.open("user://students/" + student.id, FileAccess.WRITE)
	
	if file == null:
		print('Cannot create file for student')
		return null
	
	file.store_string(var_to_str(student))

static func get_topics() -> PackedStringArray:
	return DirAccess.get_directories_at('res://assets/text/')

static func get_lessons(topic: String) -> PackedStringArray:
	if !DirAccess.dir_exists_absolute('res://assets/text/' + topic):
		return []
	
	var files = DirAccess.get_files_at('res://assets/text/' + topic + '/lessons/')

	var lessons: PackedStringArray = []

	for file in files:
		lessons.append(file.replace('.txt',''))
	
	return lessons

static func get_lesson(topic: String, lesson: String) -> String:
	var path = 'res://assets/text/' + topic + '/lessons/' + lesson + '.txt'
	
	if !FileAccess.file_exists(path):
		return ''
	
	var file = FileAccess.open(path, FileAccess.READ)
	return file.get_as_text()

# func get_
