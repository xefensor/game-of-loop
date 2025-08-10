class_name ControlCellGrid
extends GridContainer


@onready var center_container: CenterContainer = get_parent()


func _ready() -> void:
	center_container.resized.connect(resize_cell_minimum_size)

	
func resize_cell_minimum_size() -> void:
	var grid_size: Vector2i = Vector2i(columns, get_child_count()/columns)
	var cell_lenght: float = 0
		
	if grid_size.x > grid_size.y:
		cell_lenght = (center_container.size.x - get_theme_constant("v_separation") * grid_size.x) / grid_size.x
		
	else:
		cell_lenght = (center_container.size.y - get_theme_constant("h_separation") * grid_size.y) / grid_size.y
		
	for cell in get_children():
		cell.custom_minimum_size = Vector2i(cell_lenght, cell_lenght)
