extends DataRef
class_name StringRef

func cast_value(_value : Variant) -> bool:
    value = str(_value)
    return true