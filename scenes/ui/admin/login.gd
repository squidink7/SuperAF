extends Control

var mode := 'student'
const TEACHER_PASSWORD := '1234'

func student_button_pressed():
	mode = 'student'
	%IDPanel.show()

func teacher_button_pressed() -> void:
	mode = 'teacher'
	%IDPanel.show()

func login():
	var id = %IDBox.text

	# TODO: show nice error message
	# Ensure student ID provided
	if id.is_empty():
		return
	
	# Check teacher password
	if mode == 'teacher' && id != TEACHER_PASSWORD:
		return

	var page = $'/root/Main'.load_scene('ui/' + mode + '/' + mode + '_page')

	if mode == 'student':
		page.setup(id)

	$/root/Main.set_scene(page)


func id_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			%IDPanel.hide()
