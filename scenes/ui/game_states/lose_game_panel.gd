extends Panel


func  restart_buton_pressed():
   get_tree().reload_current_scene()

func quit_button_pressed():
    get_tree().quit()


