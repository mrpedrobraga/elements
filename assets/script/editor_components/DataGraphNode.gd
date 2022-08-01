extends GraphNode
class_name DataGraphNode

#   DataGraphNode
#
#       A simple graph node that holds a single
#       datum, which can be shared amongst other graph nodes.

@export var value_count := 1
var values : Array[DataRef] = []
var out_nodes : Array[DataGraphNode] = []

func _ready():
	for i in value_count:
		values.push_back(DataRef.new())
		values[i].value_changed.connect(_on_value_changed.bind(i))

# Protects against infinite loops.
var _was_set_this_frame = false

func _on_value_changed(_value:float, index:int = 0):
	if _was_set_this_frame:
		return
	_was_set_this_frame = true
	values[index].value = _value
	print(values)
	_was_set_this_frame = false

func cascade_changes():
	pass
