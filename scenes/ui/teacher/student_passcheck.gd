extends Control


func set_data(studentID,quizcomplete,lessoncomplete):
    %StudentID.text = studentID
    %QuizComplete.text = 'complete' if quizcomplete else 'incomplete'
    %LessonComplete.text = 'complete' if lessoncomplete else 'incomplete'