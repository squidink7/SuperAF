extends Panel

signal next
signal restart
signal back

func next_button_pressed():
	next.emit()

func restart_button_pressed():
	restart.emit()

func back_button_pressed():
	back.emit()
