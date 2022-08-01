extends SubViewportContainer

########## CANVAS VIEW MANIPULATION ##########

@export var canvas_camera : Camera2D
var mouse_over := false
var lmouse_down := false
var scroll_down := false
var old_mouse_pos : Vector2 = Vector2.ZERO
var old_camera_pos : Vector2 = Vector2.ZERO

func _on_dock_document_mouse_entered():
	mouse_over = true

func _on_dock_document_mouse_exited():
	mouse_over = false

func _on_dock_document_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 3:
			scroll_down = event.pressed
			if event.pressed:
				old_mouse_pos = event.position
				old_camera_pos = canvas_camera.position
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				canvas_camera.zoom *= 2.
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				canvas_camera.zoom *= 0.5
	if event is InputEventMouseMotion:
		if scroll_down:
			canvas_camera.position = old_camera_pos + (old_mouse_pos - event.position) / canvas_camera.zoom

func _input(event):
	# Canvas Zoom
	if Input.is_action_just_pressed(&"Zoom In", true):
		canvas_camera.zoom *= 2.
	if Input.is_action_just_pressed(&"Zoom Out", true):
		canvas_camera.zoom *= 0.5
	if Input.is_action_just_pressed(&"Zoom Reset", true):
		canvas_camera.zoom = Vector2.ONE
