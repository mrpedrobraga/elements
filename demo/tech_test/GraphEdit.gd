extends GraphEdit

func _ready():
	setup_type_connections()

func _on_graph_edit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)
	var a = get_node(from)
	var b = get_node(to)
	
	# Connects the DataRef to the TO graph node!
	b.ref_connect(a.get_value(from_slot), to_slot)

func _on_disconnection_request(from, from_slot, to, to_slot):
	disconnect_node(from, from_slot, to, to_slot)

func setup_type_connections() -> void:
	# Connect types to themselves

	for i in engine_types:
		add_valid_connection_type(i, i)
	for i in DataTypes.values():
		add_valid_connection_type(i, i)
	
	# Adding some special connections (values that can be casted)

	# Anything can be cast into a String
	for i in engine_types:
		add_valid_connection_type(i, TYPE_STRING)
	for i in DataTypes.values():
		add_valid_connection_type(i, TYPE_STRING)

	# Floats can be cast into vector types!
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR2)
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR3)
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR4)
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR2I)
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR3I)
	add_valid_connection_type(TYPE_FLOAT, TYPE_VECTOR4I)

	# Integers can be cast into vector types also!
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR2)
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR3)
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR4)
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR2I)
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR3I)
	add_valid_connection_type(TYPE_INT, TYPE_VECTOR4I)

	# Int vectors can be cast into floats
	add_valid_connection_type(TYPE_INT, TYPE_FLOAT)
	add_valid_connection_type(TYPE_VECTOR2I, TYPE_VECTOR2)
	add_valid_connection_type(TYPE_VECTOR3I, TYPE_VECTOR3)
	add_valid_connection_type(TYPE_VECTOR4I, TYPE_VECTOR4)
	
	# Float vectors can be cast into a Color
	add_valid_connection_type(TYPE_FLOAT, TYPE_COLOR)
	add_valid_connection_type(TYPE_VECTOR2I, TYPE_COLOR)
	add_valid_connection_type(TYPE_VECTOR3I, TYPE_COLOR)
	add_valid_connection_type(TYPE_VECTOR4I, TYPE_COLOR)

	# Colors can be cast as textures!
	add_valid_connection_type(TYPE_COLOR, DataTypes.TYPE_TEXTURE)


var engine_types = [
	TYPE_BOOL, TYPE_INT, TYPE_FLOAT,
	TYPE_STRING, TYPE_VECTOR2, TYPE_VECTOR2I,
	TYPE_RECT2, TYPE_RECT2I, TYPE_VECTOR3, TYPE_VECTOR3I,
	TYPE_TRANSFORM2D, TYPE_VECTOR4, TYPE_VECTOR4I,
	TYPE_PLANE, TYPE_QUATERNION, TYPE_AABB, TYPE_BASIS,
	TYPE_TRANSFORM3D, TYPE_PROJECTION,
	TYPE_COLOR, TYPE_STRING_NAME, TYPE_NODE_PATH,
	TYPE_RID, TYPE_OBJECT, TYPE_CALLABLE, TYPE_SIGNAL,
	TYPE_DICTIONARY, TYPE_ARRAY, TYPE_PACKED_BYTE_ARRAY,
	TYPE_PACKED_INT32_ARRAY, TYPE_PACKED_INT64_ARRAY,
	TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT64_ARRAY,
	TYPE_PACKED_STRING_ARRAY, TYPE_PACKED_VECTOR2_ARRAY,
	TYPE_PACKED_VECTOR3_ARRAY, TYPE_PACKED_COLOR_ARRAY
]

enum DataTypes {
	TYPE_LAYER = TYPE_MAX,
	TYPE_TEXTURE
}
