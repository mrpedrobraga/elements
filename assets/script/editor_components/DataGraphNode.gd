extends GraphNode
class_name DataGraphNode

#   DataGraphNode
#
#		A simple graph node that holds a single
#		datum, which can be shared amongst other graph nodes.

@export var value_count := 1
@export var value_defaults := []
var values : Array[DataRef] = []
var out_nodes : Array[DataGraphNode] = []

@export_group("Editor")

@export var resize_H = true
@export var resize_V = true

func _ready():
	if value_defaults.is_empty():
		for i in value_count:
			values.push_back(DataRef.new())
			values[i].value_changed.connect(_on_value_changed.bind(i))
	else:
		for i in value_defaults:
			var d = DataRef.new()
			d.value = i
			d.type_tags.append(typeof(d.value))
			values.push_back(d)
	
# Protects against infinite loops.
var _was_set_this_frame = false

func _on_value_changed(_value:float, index:int = 0):
	if _was_set_this_frame:
		return
	_was_set_this_frame = true
	values[index].value = _value
	_was_set_this_frame = false

func get_value(idx:int):
	return values[idx]

func ref_connect(value:DataRef, slot:int):
	print("Connecting \"", value, "\" to slot ", slot, ".")
	values[slot] = value

func cascade_changes():
	pass

func _on_resize_request(new_minsize):
	if resize_H:
		size.x = new_minsize.x
	if resize_V:
		size.y = new_minsize.y
