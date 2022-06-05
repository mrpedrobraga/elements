extends Panel
class_name SpriteEditor

########## DOCKS ##########

@onready var layer_dock = get_node("%Dock_Layers")

######### RENDER ########

@onready var rh_layers = get_node("%RHLayers")

########## REFERENCES ##########

# Current Data Point
#
# This will be a Color for most of the tools,
# but can be other things in other modes,
# such as UV, tile, block or more.
var current_primary_data_point = Color.WHITE:
	set(datum):
		current_primary_data_point = datum
		var data_pickers = get_node("%Sampler")
		for data_picker in data_pickers.get_children():
			data_picker._on_primary_data_point_changed(datum)
var current_secondary_data_point = Color.TRANSPARENT:
	set(datum):
		current_secondary_data_point = datum
		var data_pickers = get_node("%Sampler")
		for data_picker in data_pickers.get_children():
			data_picker._on_secondary_data_point_changed(datum)
var current_tertiary_data_point = Color.BLUE_VIOLET:
	set(datum):
		current_tertiary_data_point = datum
		var data_pickers = get_node("%Sampler")
		for data_picker in data_pickers.get_children():
			data_picker._on_tertiary_data_point_changed(datum)

enum DataType {COLOR_RGBA, UV, NORMAL, GRAYSCALE, INDEX}
var current_data_type:DataType = DataType.COLOR_RGBA

#var current_layer_idx = 0
#var current_layer : Layer:
#	set(l):
#		var idx = layers.find(l)
#		if not idx == -1:
#			current_layer_idx = idx
#			current_layer = l
#	get:
#		return layers[current_layer_idx]
var layers = []
var layer_views = []

var current_tool : EditingTool

@onready var canvas : TextureRect
@onready var canvas_camera : Camera2D

########## GLOBAL ##########

func _ready():
	canvas = get_node("%Canvas")
	canvas_camera = get_node("%CanvasCamera")
	canvas_camera.position = canvas.position + canvas.size / 2 
	set_current_tool.call_deferred("Brush")
	
	refresh_layers_array.call_deferred()

func _process(delta):
	process_canvas(delta)

func _input(event):
	# Global Input
	
	# TEST
	if event is InputEventKey:
		if event.keycode == KEY_SPACE and event.pressed:
			new_layer("RasterData")

########## CANVAS ##########

@export var canvas_size = Vector2i(32, 32)

#func _on_canvas_gui_input(event):
#	var position = Vector2i(to_world_space(event.position))
#	current_tool._on_canvas_input(event, position)

func process_canvas(delta):
	pass

########## LAYER ##########

func new_layer(type):
	pass

#func select_layer(layer):
#	if current_tool:
#		current_tool._on_layer_changed(current_layer, layer)
#	current_layer = layer

func refresh_layers_array():
	layers = []
	for i in rh_layers.get_children():
		layers.push_back(i)

#######  DOCKS  #######

## Data Pickers
func _on_color_picked(color, slot):
	if slot == 0:
		current_primary_data_point = color
	if slot == 1:
		current_secondary_data_point = color
	if slot == 2:
		current_tertiary_data_point = color
func _on_uv_picked(uv):
	current_primary_data_point = uv

#######  TOOLS  #######

var available_tools = {
	&"Brush": BrushTool.new(),
	&"Eyedropper": EyedropperTool.new()
}

func set_current_tool(tool:String):
	current_tool = available_tools[tool]
	current_tool.sprite_editor = self
	#current_tool._on_layer_changed(current_layer, current_layer)
	current_tool._on_frame_changed(0, 0)
	current_tool._on_selected.call_deferred()

####### Utils #######

var layer_view_scene = preload("res://assets/layouts/LayerView.tscn")

# Transforms a position in the canvas' space to coordinates in image pixels
#func to_world_space(pos):
#	return pos * current_layer.get_current_frame().get_size()/(canvas.size)
