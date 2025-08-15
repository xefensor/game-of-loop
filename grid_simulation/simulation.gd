class_name Simulation
extends Resource


var cells: Dictionary[StringName, Cell]
var priority: Array[StringName]
var generations: Array[SimulationState]


func setup(_cells: Dictionary, _priority: Array, generation_zero: SimulationState) -> void:
	cells = _cells
	priority = _priority
	generations.clear()
	generations[0] = generation_zero.duplicate()


func calculate_generations(number_of_generations: int, generation_zero: SimulationState) -> Array:
	var _generations: Array[SimulationState] = [generation_zero]
	
	for i in number_of_generations-1:
		generations
	
	
	
	return generation_zero.cells


func transition_cell(cell: StringName, neighbours: Array[StringName]) -> StringName:
	return cell


func get_neighbours(generation: SimulationState, position: Vector2i) -> Array:
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
