extends Layer
class_name RasterDataLayer

var img_frames : Dictionary
var img_format := Image.FORMAT_RGBA8

var texture_render : TextureRect

####### IMAGE EDITING UTIL FUNCTIONS ######

func fill(color:Color):
	get_current_frame().fill(color)

func fill_rect(rect:Rect2, color:Color):
	get_current_frame().fill_rect(rect, color)

func set_pixel(point:Vector2i, color:Color):
	get_current_frame().set_pixelv(point, color)

func get_pixel(point:Vector2i):
	return get_current_frame().get_pixelv(point)

func _init():
	var img = Image.new()
	img.create(32, 32, false, img_format)
	img.set_pixel(4, 6, Color.RED)
	img_frames[0] = img
	
	texture_render = TextureRect.new()
	texture_render.name = "Texture Render"
	texture_render.texture = ImageTexture.new()
	add_child(texture_render)
	texture_render.size = size
	texture_render.stretch_mode = TextureRect.STRETCH_KEEP
	update_texture()

func update_texture():
	texture_render.texture.create_from_image(get_current_frame())

func get_frame(frame):
	return img_frames[frame]

func set_frame(frame:int, value):
	(get_current_frame() as Image).blit_rect(value, Rect2(Vector2.ZERO, value.get_size()), Vector2.ZERO)

func _to_string():
	return "Raster Layer: " + str(img_frames)

func get_type():
	return "RasterData"

######## Creating Editor Controls #######

func create_controls(editor:SpriteEditor):
	var img = get_current_frame()
	
	var texture = ImageTexture.new()
	img.fill(Color.TRANSPARENT)
	texture.create_from_image(img)
	
	editor.get_node("%Dock_Layers/Items").add_item(display_name)
