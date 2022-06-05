extends GraphEdit

func _ready():
	add_valid_connection_type(0, 0)
	add_valid_connection_type(1, 1)


func _on_graph_edit_connection_request(from, from_slot, to, to_slot):
	connect_node(from, from_slot, to, to_slot)
