@tool
extends SubViewport
class_name Layer, "res://assets/images/icons/1x/outline_auto_awesome_motion_white_24dp.png"

# The layer's name, as displayed in the Layer Dock
@export var display_name := "Unkwown Layer"
var current_frame_idx := 0

var group_layer_parent

# Virtual function to be implemented,
# Returns the layer's data
func get_frame(frame):
	pass

func get_current_frame():
	return get_frame(current_frame_idx)

func set_frame(frame:int, value):
	pass

func set_current_frame(value):
	set_frame(current_frame_idx, value)

# Virtual function to be implemented,
# Returns the layer type
func get_type():
	return "Unknown"

# Virtual function to be implemented,
# Returns a type that this layer can be treated as,
# but isn't the layer's actual type.
func get_effective_type():
	return get_type()

func _to_string():
	return "Unknown Layer"

####### Code for editing the layer #######

var layer_control

# Returns the current rendered image
func get_render():
	return get_texture()

# Function to create a new layer on for the editor
func create_controls(editor):
	return
