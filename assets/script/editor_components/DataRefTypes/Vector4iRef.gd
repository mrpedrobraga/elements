extends DataRef
class_name Vector4iRef

func cast_value(_value : Variant) -> bool:
    if _value.value is float or _value.value is int:
        value = Vector4i(_value.value)

    print("(!) Invalid Cast!")
    return false