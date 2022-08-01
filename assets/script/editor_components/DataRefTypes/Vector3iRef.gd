extends DataRef
class_name Vector3iRef

func cast_value(_value : Variant) -> bool:
    if _value.value is float or _value.value is int:
        value = Vector3i(_value.value)

    print("(!) Invalid Cast!")
    return false