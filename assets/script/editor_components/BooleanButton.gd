extends Button

func _on_toggled(button_pressed):
	if button_pressed:
		text = "True"
	else:
		text = "False"
