@tool
extends Control
class_name ColorPickerControl

@export_node_path var sprite_editor_path
@onready var sprite_editor = get_node(sprite_editor_path)

signal color_picked(color, slot)

func _ready():
	color_picked.connect(_on_color_picked)
	initialize.call_deferred()

func initialize():
	get_node("HSV Picker").initialize(sprite_editor.current_primary_data_point)
	primary_color_view.color = sprite_editor.current_primary_data_point
	secondary_color_view.color = sprite_editor.current_secondary_data_point

func _on_color_picked(color, slot):
	update_color(color)

func update_color(color):
	if current_color_slot == 0:
		primary_color_view.color = color
	if current_color_slot == 1:
		secondary_color_view.color = color

# Whether to pick the primary or secondary color
var current_color_slot := 0
@onready var primary_color_view := get_node("H/ColorPrimary")
@onready var secondary_color_view := get_node("H/ColorSecondary")

func _on_primary_data_point_changed(datum):
	if not datum is Color:
		print_debug("(!) Datum Passed to Color Picker isn't of type Color.")
		return
	
	primary_color_view.color = datum

func _on_secondary_data_point_changed(datum):
	if not datum is Color:
		print_debug("(!) Datum Passed to Color Picker isn't of type Color.")
		return
	
	secondary_color_view.color = datum

func _on_tertiary_data_point_changed(datum):
	if not datum is Color:
		print_debug("(!) Datum Passed to Color Picker isn't of type Color.")
		return
	
	secondary_color_view.color = datum

######## Color Slot Selector

func _on_color_primary_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			current_color_slot = 0
			get_node("HSV Picker").initialize(sprite_editor.current_primary_data_point)

func _on_color_secondary_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			current_color_slot = 1
			get_node("HSV Picker").initialize(sprite_editor.current_secondary_data_point)
