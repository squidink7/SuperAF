extends Control

func exit():
	get_tree().quit()

func set_data(studentID,lessonscore):
	%StudentID.text = studentID
	# %QuizComplete.text = 'complete' if quizcomplete else 'incomplete'
	%LessonComplete.text = str(lessonscore)