class_name Simulation
extends Resource


var cells: Dictionary[StringName, Cell]
var priority: Array[StringName]
var generations: Array[Generation]


func setup(_cells: Dictionary, _priority: Array, generation_zero: Generation) -> void:
	cells = _cells
	priority = _priority
	generations.clear()
	generations[0] = generation_zero.duplicate()


func calculate_generations(number_of_generations: int, generation_zero: Generation) -> Array:
	var _generations: Array[Generation] = [generation_zero.duplicate()]
	
	for i in number_of_generations-1:
		_generations.append(next_generation(_generations[i]))
	
	return _generations
	
	
func next_generation(generation: Generation) -> Generation:
	var new_generation: Generation = Generation.new()
	var cols = generation.cells.size()
	var rows = generation.cells[0].size()
	
	for y in rows:
		var row: Array = []
		for x in cols:
			var old_cell: Cell = CellRegistry.cells[generation.cells[y][x]]
			var neighbours = get_neighbours(generation, Vector2i(y, x))
			var neigbours_count = get_neighbours_count(neighbours)
			var new_cell = old_cell.get_transition_cell(neigbours_count, CellRegistry.priority)
			row.append(new_cell)
			
		new_generation.cells.append(row)

	return new_generation


func get_neighbours(generation: Generation, position: Vector2i) -> Array:
	var neighbours: Array = []
	var cols = generation.cells.size()
	var rows = generation.cells[0].size()

	for dy in range(-1, 2):  # -1, 0, 1
		for dx in range(-1, 2):
			if dx == 0 and dy == 0:
				continue
			var nx = position.x + dx
			var ny = position.y + dy
			if nx >= 0 and nx < cols and ny >= 0 and ny < rows:
				neighbours.append(generation.cells[nx][ny])

	return neighbours
	

func get_neighbours_count(neighbours: Array) -> Dictionary:
	var neighbours_count: Dictionary
	
	for neighbour in neighbours:
		if neighbours_count.has(neighbour):
			neighbours_count[neighbour] += 1
		else:
			neighbours_count[neighbour] = 1
	
	return neighbours_count
