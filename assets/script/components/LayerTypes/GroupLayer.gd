extends Layer
class_name GroupLayer

@export var layer_paths:Array[NodePath] = []
var layers : Array[Layer] = []

func _ready():
	for lpth in layer_paths:
		var l : Layer = get_node(lpth)
		l.group_layer_parent = self
		layers.push_back(l)
	recreate_layer_views()

func recreate_layer_views():
	for i in get_children():
		if i is TextureRect:
			i.queue_free()
	for l in layers:
		var tr = TextureRect.new()
		tr.size = size
		tr.name = "LV: " + l.display_name
		tr.texture = l.get_render()
		tr.stretch_mode = TextureRect.STRETCH_SCALE
		tr.ignore_texture_size = true
		add_child(tr, true)

func _to_string():
	return "Group Layer"

func get_type():
	return "Reference"
