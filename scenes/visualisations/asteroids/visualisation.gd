extends SubViewportContainer

func _process(delta: float):
	# Scale content to fit, keeping aspect ratio
	var zoom_scale = (%Viewport.size as Vector2) / Vector2(1152,648)
	var max_zoom_axis = max(zoom_scale.x, zoom_scale.y)

func correct():
	%Asteroids.on_correct()

func incorrect():
	%Asteroids.on_incorrect()
	
	
func life_changed(current_lives: int, max_lives: int, increase: bool):
	%Asteroids.on_life_changed(current_lives, max_lives, increase)

func game_win():
	%Asteroids.process_mode = Node.PROCESS_MODE_DISABLED
	$win_screen.show()

func game_lose():
	%Asteroids.process_mode = Node.PROCESS_MODE_DISABLED
	$lose_screen.show()
	
	
	
