extends SubViewportContainer

signal success
signal fail

func _process(delta: float):
	pass

func correct():
	success.emit()

func incorrect():
	fail.emit()

func life_changed(lives,max_lives,delta):
	pass

func game_win():
	pass

func game_lose():
	pass