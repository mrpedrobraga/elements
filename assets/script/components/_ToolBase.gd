@tool
extends Node
class_name EditingTool

# A reference to the current sprite editor!
var sprite_editor : SpriteEditor

# Information about the currently edited layer
var edited_layer
var edited_layer_type = "RasterData"

# Function for when this tool is selected
func _on_selected():
	sprite_editor.current_tool = self

# Function for when this tool is unselected
func _on_unselected():
	pass

# Virtual Function for input on the canvas.
func _on_canvas_input(event:InputEvent, position:Vector2):
	pass

# Virtual Function for when the current layer changes
func _on_layer_changed(old_layer:Layer, new_layer:Layer):
	edited_layer = new_layer
	edited_layer_type = new_layer.get_type()

# Virtual Function for when the current frame changes
func _on_frame_changed(old_frame, new_frame):
	pass
