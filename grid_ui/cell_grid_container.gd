class_name CellGridContainer
extends GridContainer


var cells: Array[Array] = []

@onready var center_container: CenterContainer = get_parent()
@export var gen_zero: Generation

func _ready() -> void:
	center_container.resized.connect(update_grid_size)
	create_cells(10, 10)
	
	update_grid_size()
	
	
	print(gen_zero.cells)
	var sim: Simulation = Simulation.new()
	sim.calculate_generations(5, gen_zero)
	


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

	custom_minimum_size = Vector2(total_width-cols, total_height-rows)


func create_cells(cols: int, rows: int):
	if get_child_count():
		for child in get_children():
			queue_free()
	cells = []
			
	columns = cols
	
	for y in range(rows):
		var row: Array = []
		for x in range(cols):
			var cell = CellColorRect.new(Vector2i(x, y), Color.html("2e222f"))
			row.append(cell)
			add_child(cell)
		cells.append(row)
