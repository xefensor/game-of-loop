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
	var _generations: Array[Generation] = [generation_zero]
	
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
			var old_cell: Cell = CellRegistry.cells[generation.cells[x][y]]
			var neigbours = get_neighbours(generation, Vector2i(x, y))
			var neigbours_count = get_neighbours_count(neigbours)
			var new_cell = old_cell.get_transition_cell(neigbours_count, CellRegistry.priority)
			row.append(new_cell)
		new_generation.cells.append(row)

	return new_generation


func get_neighbours(generation: Generation, position: Vector2i) -> Array:
	var neighbours: Array = []
	var cols = generation.cells.size()
	var rows = generation.cells[0].size()
	
	if position.y > 0:
		if position.x > 0:
			neighbours.append(generation.cells[position.y-1][position.x-1])
		neighbours.append(generation.cells[position.y-1][position.x])
		if position.x < cols - 1:
			neighbours.append(generation.cells[position.y-1][position.x+1])
	if position.x > 0:
		neighbours.append(generation.cells[position.y][position.x-1])
	if position.x < cols - 1:
		neighbours.append(generation.cells[position.y][position.x+1])
	if position.y < rows - 1:
		if position.x > 0:
			neighbours.append(generation.cells[position.y+1][position.x-1])
		neighbours.append(generation.cells[position.y+1][position.x])
		if position.x < cols - 1:
			neighbours.append(generation.cells[position.y+1][position.x+1])

	return neighbours


func get_neighbours_count(neighbours: Array) -> Dictionary:
	var neighbours_count: Dictionary
	
	for neighbour in neighbours:
		if neighbours_count.has(neighbour):
			neighbours_count[neighbour] += 1
		else:
			neighbours_count[neighbour] = 1
	
	return neighbours_count
