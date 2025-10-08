class_name CellGridDisplay
extends GridContainer


var ui_cells: Array[Array] = []

@onready var parent_control: Control = get_parent()


func _ready() -> void:
	parent_control.resized.connect(update_grid_size)
	update_grid_size()
	
	
func update_grid_size() -> void:
	if get_child_count() == 0:
		custom_minimum_size = Vector2.ZERO
		return

	var cols = columns
	var rows = ceil(float(get_child_count()) / cols)

	var available_width = parent_control.size.x - get_theme_constant("v_separation") * (cols - 1)
	var available_height = parent_control.size.y - get_theme_constant("h_separation") * (rows - 1)

	var cell_size = min(available_width / cols, available_height / rows)

	var total_width = cols * cell_size + get_theme_constant("v_separation") * (cols - 1)
	var total_height = rows * cell_size + get_theme_constant("h_separation") * (rows - 1)

	custom_minimum_size = Vector2(total_width-cols, total_height-rows)


func create_cells(cols: int, rows: int):
	if get_child_count():
		for child in get_children():
			queue_free()
	ui_cells = []
			
	columns = cols
	
	for y in range(rows):
		var row: Array = []
		for x in range(cols):
			var cell = CellColorRect.new(Vector2i(y, x), Color.html("2e222f"))
			row.append(cell)
			add_child(cell)
		ui_cells.append(row)


func draw_generation(generation: Generation):
	var cols = generation.cells.size()
	var rows = generation.cells[0].size()
	
	for y in rows:
		for x in cols:
			var texture = CellRegistry.cells[generation.cells[y][x]].texture
			var animated_texture = RandomAnimatedTextureRect.new(texture)
			if ui_cells[y][x].get_children():
				for child in ui_cells[y][x].get_children():
					child.queue_free()
			
			if generation.cells[y][x] != 0:
				ui_cells[y][x].add_child(animated_texture)
