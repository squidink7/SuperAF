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

# func set_lesson_completion(student_id: String, topic: String, lesson: String):
# 	var path = 'user://students/' + student_id + '.txt'
	
# 	if !FileAccess.file_exists(path):
# 		# Create student file
# 		FileAccess.open(path, FileAccess.WRITE).close()
	
# 	var file = FileAccess.open(path, FileAccess.WRITE)
# 	var completed_lessons = file.get_as_text().split('\n')
# 	if !topic + '/lessons/' + lesson in completed_lessons:
# 		file.store_string(topic + '/lessons/' + lesson)

static func set_highscore(student_id: String, topic: String, lesson: String, score: int):
	if get_highscore(student_id, topic, lesson) > score:
		return
	
	var path = 'user://students/' + student_id + '.txt'
	
	if !FileAccess.file_exists(path):
		# Create student file
		FileAccess.open(path, FileAccess.WRITE).close()
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	var completed_lessons = file.get_as_text().split('\n')
	if !topic + '/lessons/' + lesson in completed_lessons:
		file.store_string(topic + '/lessons/' + lesson + '=' + str(score))

static func get_highscore(student_id: String, topic: String, lesson: String) -> int:
	var path = 'user://students/' + student_id + '.txt'
	
	if !FileAccess.file_exists(path):
		return -1
	
	var file = FileAccess.open(path, FileAccess.READ)
	var completed_lessons := file.get_as_text().split('\n')
	
	for line in completed_lessons:
		if line.begins_with(topic + '/lessons/' + lesson):
			return int(line.split('=')[1])
	
	return -1

static func get_students() -> PackedStringArray:
	if !DirAccess.dir_exists_absolute('user://students/'):
		return []

	var student_files = DirAccess.get_files_at('user://students/')
	var students = []
	for file in student_files:
		students.append(file.replace('.txt',''))
	return students

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
