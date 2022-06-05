extends Layer
class_name LayerReferenceLayer

var referenced_layer : Layer
var referenced_layer_type = "RasterData"

func fill(color:Color):
	get_current_frame().fill(color)

func fill_rect(rect:Rect2, color:Color):
	get_current_frame().fill_rect(rect, color)

func set_pixel(point:Vector2i, color:Color):
	get_current_frame().set_pixelv(point, color)

func get_pixel(point:Vector2i):
	return get_current_frame().get_pixelv(point)

func _init():
	referenced_layer_type = referenced_layer.get_type()

func get_frame(frame):
	referenced_layer.get_frame(frame)

func set_frame(frame:int, value):
	referenced_layer.set_frame(frame, value)

func _to_string():
	return "Reference Layer: \n\t" + str(referenced_layer)

func get_type():
	return "Reference"

func get_effective_type():
	return referenced_layer.get_type()

######## Creating Editor Controls #######

func create_controls(editor:SpriteEditor):
	var data = get_current_frame()
	
	layer_view = editor.layer_view_scene.instantiate()
	var texture = ImageTexture.new()
	data.fill(Color.TRANSPARENT)
	texture.create_from_image(data)
	layer_view.texture = texture
	layer_view.material = ShaderMaterial.new()
	layer_view.gui_input.connect(editor._on_canvas_gui_input)
	editor.layer_views.push_back(layer_view)
	editor.canvas.add_child(layer_view)
	
	editor.get_node("%Dock_Layers/Items").add_item(display_name)
