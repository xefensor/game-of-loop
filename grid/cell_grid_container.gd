class_name CellGridContainer
extends GridContainer


@onready var center_container: CenterContainer = get_parent()


func _ready() -> void:
	center_container.resized.connect(update_grid_size)
	update_grid_size()


func update_grid_size() -> void:
	if get_child_count() == 0:
		custom_minimum_size = Vector2.ZERO
		return

	var cols = columns
	var rows = ceil(float(get_child_count()) / cols)

	var available_width = center_container.size.x - get_theme_constant("v_separation") * (cols - 1)
	var available_height = center_container.size.y - get_theme_constant("h_separation") * (rows - 1)

	var cell_size = min(available_width / cols, available_height / rows)

	var total_width = cols * cell_size + get_theme_constant("v_separation") * (cols - 1)
	var total_height = rows * cell_size + get_theme_constant("h_separation") * (rows - 1)

	custom_minimum_size = Vector2(total_width-1, total_height-1) #Doesn't work without the minus ones
