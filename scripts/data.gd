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
	get_student('test')

func get_student(id: String):
	var stud = Student.new()
	stud.id = 'hello'

# func get_