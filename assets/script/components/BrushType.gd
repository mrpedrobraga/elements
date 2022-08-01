extends Resource
class_name BrushPreset

enum BlendMode {
	NORMAL, ERASE, ADD, MULTIPLY
}

@export_category("Brush Preset")

@export_group("General")

@export var name : String = "New Brush"

@export_group("Brush")

@export var texture : Texture
@export var does_modulate : bool = true
@export_enum("Smear", "Grid; Align to World", "Grid; Align to Stroke Origin") var copy_mode
@export var blend_mode : BlendMode = BlendMode.NORMAL

@export_group("Pen Settings")

@export var size_reacts_to_pressure : bool
@export var opacity_reacts_to_pressure : bool

@export_group("...")
