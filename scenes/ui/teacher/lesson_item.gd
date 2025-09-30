extends Control

signal selected()
signal toggle_enabled(enabled: bool)

func set_data(title,description,isactive):
	%Title.text = title 
	%Description.text = description
	%IsActive.button_pressed =  isactive


func on_panel_input(event: InputEvent):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
		selected.emit()


func on_toggle_enabled(toggled_on: bool) -> void:
	toggle_enabled.emit(toggled_on)