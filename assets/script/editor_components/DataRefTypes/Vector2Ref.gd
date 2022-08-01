extends DataRef
class_name Vector2Ref

func cast_value(_value : Variant) -> bool:
    if _value.value is float or _value.value is int:
        value = Vector2(_value.value)

    print("(!) Invalid Cast!")
    return false