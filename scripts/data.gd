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

	print(stud.name)
	print(get_student('test').name)

func get_student(id: String) -> Student:
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

func set_student(student: Student):
	DirAccess.make_dir_absolute("user://students/")
	var file = FileAccess.open("user://students/" + student.id, FileAccess.WRITE)
	
	if file == null:
		print('Cannot create file for student')
		return null
	
	file.store_string(var_to_str(student))


# func get_
