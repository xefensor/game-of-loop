class_name Simulation
extends Resource


var cells: Dictionary[StringName, Cell]
var priority: Array[Cell]
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


func transition_cell(cell: Cell, neighbours: Array[Cells]) -> Cell:
	return cell
