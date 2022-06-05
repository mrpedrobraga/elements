extends Control
class_name UVPickerControl

signal uv_picked(uv)

var mouse_down
func _on_uv_square_gui_input(event):
	if event is InputEventMouse:
		var uv = event.position / $Background/UVSquare.size
		if event is InputEventMouseButton and event.button_index == 1:
			mouse_down = event.is_pressed()
			if not event.is_pressed():
				uv_picked.emit(Color(uv.x, uv.y, 0.0))

func _on_primary_data_point_changed(datum):
	pass

func _on_secondary_data_point_changed(datum):
	pass
