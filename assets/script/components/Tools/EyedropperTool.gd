extends EditingTool
class_name EyedropperTool

func _on_canvas_input(event, position):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				sprite_editor.current_primary_data_point = edited_layer.get_pixel(position)
			if event.button_index == 2:
				sprite_editor.current_secondary_data_point = edited_layer.get_pixel(position)
