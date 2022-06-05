extends EditingTool
class_name BrushTool

#
#	Brush Tool
#
#		TODO: Optimize
#

# Whether the mouse cursors are currently being held down
var mouse_l_down := false
var mouse_r_down := false
var mouse_last_position : Vector2i

# The function that is called when placing a data point
# This is useful, because the definition of data point
# changes depending on the current Layer Type.
#
# For example, in raster layers, a datum is a pixel (a Color).
# in tile layers, it is a tile.
var set_datum : Callable

# The temporary buffer that holds the preview data
# before it is copied into the layer's current frame.
var temp_buffer : RefCounted

####### TOOL BEHAVIOUR #######

# When selected, begin a preview
func _on_selected():
	begin_preview()

# When unselected, stop the preview
func _on_unselected():
	end_preview()

# When a layer is changed, set it up.
func _on_layer_changed(old_layer:Layer, new_layer:Layer):
	super._on_layer_changed(old_layer, new_layer)
	
	# If this is a raster Layer
	if new_layer is RasterDataLayer:
		setup_layer_raster(new_layer)

func _on_canvas_input(event:InputEvent, position:Vector2):
	# Mouse Button Click
	if event is InputEventMouseButton:
		# IF LEFT MOUSE IS DOWN
		if event.button_index == 1:
			mouse_l_down = event.pressed
			if event.pressed:
				mouse_last_position = position
				pset(position, set_datum, sprite_editor.current_primary_data_point)
				
		elif event.button_index == 2:
			mouse_r_down = event.pressed
			if event.pressed:
				mouse_last_position = position
				pset(position, set_datum, sprite_editor.current_primary_data_point)
				
		if not event.pressed and not mouse_l_down and not mouse_r_down:
			commit_data()
	
	# When the mouse is moving!
	if event is InputEventMouseMotion:
		if mouse_l_down:
			line(
				mouse_last_position,
				position,
				set_datum,
				sprite_editor.current_tertiary_data_point
				if Input.is_action_pressed("Use Third Datum") else
				sprite_editor.current_primary_data_point 
			)
			mouse_last_position = position
		elif mouse_r_down:
			line(mouse_last_position,position,set_datum,sprite_editor.current_secondary_data_point)
			mouse_last_position = position
		else:
			pass#temp_buffer.fill(Color.TRANSPARENT)
		update_preview(mouse_l_down or mouse_r_down, position)
		

###### Drawing Utility Functions #######

# Sets a single data point in a preview buffer
func pset(point:Vector2, function:Callable, data):
	function.call(point, data)

# Calls pset in a line between two points with
# a data point.
#
# Function signature should be "function (Vector2, Variant)"
func line(p1:Vector2, p2:Vector2, function:Callable, data):
	var line := (p2 - p1)
	var rv := Vector2(0, 0)
	var direction_vector := normalize_square(line)
	var pixel_count := int(max(abs(line.x), abs(line.y)))
	for i in range(pixel_count+1):
		pset(p1 + rv, function, data)
		rv += (direction_vector)

## Begins the preview!!!
func begin_preview():
	return
	temp_buffer.copy_from(edited_layer.get_current_frame())
	var preview = edited_layer.layer_view.get_node("ToolPreview")
	preview.texture.create_from_image(temp_buffer)
	edited_layer.layer_view.self_modulate.a = 0
	edited_layer.layer_view.get_node("ToolPreview").visible = true

## Updates the preview!!!
func update_preview(drawing=false, drawing_pos=Vector2.ZERO):
	var preview = edited_layer.layer_view.get_node("ToolPreview")
	
	if not drawing:
		# If not drawing, continuosly update the preview while
		# showcasing how the brush will look.
		#
		# SUBJECT TO OPTIMIZATION (!)
		temp_buffer.copy_from(edited_layer.get_current_frame())
		pset(drawing_pos, set_datum, sprite_editor.current_primary_data_point)
	
	preview.texture.create_from_image(temp_buffer)

# Ends the preview :(
func end_preview():
	(temp_buffer as Image).fill(Color.TRANSPARENT)
	edited_layer.layer_view.self_modulate.a = 1
	var preview = edited_layer.layer_view.get_node("ToolPreview")
	preview.texture.update(temp_buffer)
	preview.visible = false

# Copies the brush stroke from the preview into the layer's frame.
# Adds a point to the editor's undo-redo manager.
func commit_data():
	if edited_layer is RasterDataLayer:
		edited_layer.set_current_frame(temp_buffer)
		edited_layer.layer_view.texture.update(temp_buffer)

####### Setup for Different Types of Layers #######

func setup_layer_raster(new_layer):
	# Setup a temporary buffer (Image) for drawing to without compromising the underlying data.
	temp_buffer = Image.new()
	var frame = edited_layer.get_current_frame()
	temp_buffer.create(frame.get_width(), frame.get_height(), false, frame.get_format())
	# Define the function used to set a pixel (setting a pixel in the temporary buffer)
	set_datum = func(coord, data): temp_buffer.set_pixelv(coord, data)

####### Util Functions #######

# Normalizes a vector, but instead of it sitting on a unit circle
# it is contained in a unit axis aligned square.
#
# Normalizes a vector so its Chebyshev distance to the origin is 1.
func normalize_square(v:Vector2) -> Vector2:
	var dv = Vector2(0, 0)
	# Square Vector Normalization
	if abs(v.x) > abs(v.y):
		dv.x = v.x/max(abs(v.x), 0.01)
		dv.y = v.y/max(abs(v.x), 0.01)
	else:
		dv.y = v.y/max(abs(v.y), 0.01)
		dv.x = v.x/max(abs(v.y), 0.01)
	return dv
