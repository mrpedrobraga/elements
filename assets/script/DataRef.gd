extends RefCounted
class_name DataRef

#   DataRef
#
#	   This class encapsulates data,
#	   which can be referred and passed around
#	   while being kept at only one!

var type_tags : Array[StringName]
var value : Variant:
	set(v):
		value = v
		value_changed.emit(v)
		
		if is_casting:
			pass


var is_casting : bool = false
var casting_to : DataRef

signal value_changed(to)

func has_type_tag(type_tag : StringName) -> bool :
	return type_tags.has(type_tag)

# To be overriden in implementations of DataRef
func cast_value(_value : Variant) -> bool:
	value = _value
	return true

func _to_string():
	return "Data Reference :: " + str(value)
