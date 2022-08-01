extends HBoxContainer

@export_category("Layer Controller")

@export var control_layer : Node

func _on_btn_visible_toggled(button_pressed):
	print(button_pressed)
