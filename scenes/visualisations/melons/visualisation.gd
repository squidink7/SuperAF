extends SubViewportContainer

signal success
signal fail

func _process(delta: float):
	pass

func correct():
	success.emit()

func incorrect():
	fail.emit()
