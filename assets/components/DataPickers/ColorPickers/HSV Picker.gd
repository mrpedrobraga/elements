@tool
extends Control

signal color_picked(color)

var color := Color.from_hsv(1, 1, 1)
var h := 0.0; var s := 0.0; var v := 0.0; var a := 0.0;

var l_mouse_down
var r_mouse_down

@onready var square_SV := get_node("HSV/SV Square")
@onready var slider_H := get_node("HSV/H Slider")
@onready var slider_A := get_node("A Slider")

func _on_h_slider_gui_input(event):
	if not slider_H.has_focus():
		return
	common_event(event)
	if event is InputEventMouse and (l_mouse_down or r_mouse_down):
		var pos = event.position / slider_H.size
		h = clamp(pos.y, 0.0, 1.0)
		
		update_color()
		
		slider_A.color = color
		square_SV.material.set_shader_param("hue", h)

func _on_a_slider_gui_input(event):
	if not slider_A.has_focus():
		return
	common_event(event)
	if event is InputEventMouse and (l_mouse_down or r_mouse_down):
		var pos = event.position / slider_A.size
		a = clamp(pos.x, 0.0, 1.0)
		
		update_color()
		
		color.a = a

func _on_sv_square_gui_input(event):
	if not square_SV.has_focus():
		return
	common_event(event)
	if event is InputEventMouse and (l_mouse_down or r_mouse_down):
		var pos = event.position / square_SV.size
		s = clamp(pos.x, 0.0, 1.0)
		v = clamp(1.0 - pos.y, 0.0, 1.0)
		color.s = s
		color.v = v
		
		update_color()
		
		slider_A.color = color

func common_event(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			l_mouse_down = event.pressed
		if event.button_index == 2:
			r_mouse_down = event.pressed
		if not event.pressed:
			color_picked.emit(color)
			if get_parent() is ColorPickerControl:
				pass
				get_parent().color_picked.emit(color, get_parent().current_color_slot)
		update_color()

func initialize(_color):
	color = _color
	h = _color.h
	s = _color.s
	v = _color.v
	a = _color.a
	square_SV.material.set_shader_param("hue", h)
	slider_A.color = _color
	update_color()

func update_color():
	if get_parent() is ColorPickerControl:
		color = Color.from_hsv(h, s, v, a)
		get_parent().update_color(color)
		update()

func _draw():
	var sv_position = Vector2(
		s * square_SV.size.x, (1.0-v) * square_SV.size.y
	)
	
	draw_circle(sv_position, 8.0, Color.WHITE)
	draw_circle(sv_position, 7.0, color)
	
	draw_line(
		Vector2(slider_H.position.x, h * slider_H.size.y),
		Vector2(slider_H.position.x + slider_H.size.x, h * slider_H.size.y),
		Color("#222222"), 3.0
	)
	
	var pos_a = Vector2(a * slider_A.size.x, slider_A.position.y)
	var pos_b = Vector2(a * slider_A.size.x, slider_A.position.y + slider_A.size.y)
	
	draw_rect(
		Rect2(
			pos_a.x - 4,
			pos_a.y - 4,
			pos_b.x - pos_a.x + 8,
			pos_b.y - pos_a.y + 8
		),
		Color("#222222"),
		3.0
	)
	
	draw_rect(
		Rect2(
			pos_a.x - 3,
			pos_a.y - 3,
			pos_b.x - pos_a.x + 6,
			pos_b.y - pos_a.y + 6
		),
		Color(color.r, color.g, color.b, 1.0),
		3.0
	)
