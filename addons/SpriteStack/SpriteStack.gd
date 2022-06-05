@tool
extends MultiMeshInstance3D
class_name SpriteStackModel

@export var stack_sheet : Texture = null:
	set(param1):
		stack_sheet = param1
		_ready()
@export var cols : int = 1:
	set(param1):
		cols = param1
		_ready()
@export var rows : int = 1:
	set(param1):
		rows = param1
		_ready()

@export var layers_per_row : int = 1:
	set(param1):
		layers_per_row = param1
		_ready()

# Size of a "Pixel" in 3D Space
var px = 0.025

func _ready():
	if not stack_sheet:
		print('Could not render ', get_name(), '. stack_sheet is null.')
		return
		
	
	# Create a new mesh the size of a sprite.
	var uv_width = (stack_sheet.get_size().x as float / cols) * px
	var uv_height = (stack_sheet.get_size().y as float / rows) * px
	var surface_tool = SurfaceTool.new();
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	# Top left.
	surface_tool.set_color(Color.TRANSPARENT);
	surface_tool.set_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(-uv_width, 0, uv_height));
	
	# Bottom left
	surface_tool.set_color(Color.TRANSPARENT);
	surface_tool.set_uv(Vector2(0, 1))
	surface_tool.add_vertex(Vector3(-uv_width, 0, -uv_height));
	
	# Bottom right.
	surface_tool.set_color(Color.TRANSPARENT);
	surface_tool.set_uv(Vector2(1, 1))
	surface_tool.add_vertex(Vector3(uv_width, 0, -uv_height));
	
	# Top right.
	surface_tool.set_color(Color.TRANSPARENT);
	surface_tool.set_uv(Vector2(1, 0))
	surface_tool.add_vertex(Vector3(uv_width, 0, uv_height));

	# Add the indices to the surface tool.
	# Because a face is made of up two triangles, we'll need to add six indices.
	# First triangle
	surface_tool.add_index(0);
	surface_tool.add_index(1);
	surface_tool.add_index(2);
	# Second triangle
	surface_tool.add_index(0);
	surface_tool.add_index(2);
	surface_tool.add_index(3);

	# Get the resulting mesh from the surface tool, and apply it to the MeshInstance.
	multimesh = MultiMesh.new()
	multimesh.use_colors = true
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = surface_tool.commit();
	material_override = material_override.duplicate()
	material_override.set_shader_param('stack_sheet', stack_sheet)
	
	# Need to move up 2x pixels or the stack looks squished
	var up_unit = px + px
	
	multimesh.instance_count = rows * layers_per_row
	for i in rows:
		for j in layers_per_row:
			var instance_idx = i * layers_per_row + j
			
			multimesh.set_instance_transform(
				instance_idx, Transform3D(Basis(), Vector3(0, i * up_unit + j*up_unit/layers_per_row, 0))
			)
			multimesh.set_instance_color(
				instance_idx, 
				Color(
					# Sprite width in UV
					1.0, 
					# Sprite height in UV
					1.0 / rows, 
					# Layer index this instance should render
					rows - i - 1))

func _process(delta):
	rotate_y(TAU/4 * delta)
