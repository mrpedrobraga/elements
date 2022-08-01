extends DataRef
class_name Vector4Ref

func cast_value(_value : Variant) -> bool:
    if _value.value is float or _value.value is int:
        value = Vector4(_value.value)

    print("(!) Invalid Cast!")
    return false