extends SubViewportContainer

signal success
signal fail
signal restart

func _process(delta: float):
	# Scale content to fit, keeping aspect ratio
	var zoom_scale = (%Viewport.size as Vector2) / Vector2(1152,648)
	var max_zoom_axis = max(zoom_scale.x, zoom_scale.y)
	%Camera.zoom = Vector2(max_zoom_axis, max_zoom_axis)

func correct():
	success.emit()

func incorrect():
	fail.emit()
	
func life_changed(current_lives: int, max_lives: int, increase: bool):
	%Stage.on_life_changed(current_lives, max_lives, increase)

func game_win():
	%Stage.process_mode = Node.PROCESS_MODE_DISABLED
	$win_screen.show()

func game_lose():
	%Stage.process_mode = Node.PROCESS_MODE_DISABLED
	$lose_screen.show()

func restart_game():
	restart.emit()

func back():
	var student_page = $/root/Main.load_scene('ui/student/student_page')
	$/root/Main.set_scene(student_page)