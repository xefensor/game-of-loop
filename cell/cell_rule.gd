class_name CellRule
extends Resource


@export var neighbour: int
@export var neighbour_count: Array[bool] = [
	false, false, false, false, false, false, false, false]
@export var result_cell: int
#@export var transition


func check_amount(neighbour_amount: int) -> bool:
	var neihbour_number: PackedInt32Array
	
	for i in neighbour_count.size():
		if neighbour_count[i]:
			neihbour_number.append(i)
	
	for i in neihbour_number:
		if neighbour_amount == i:
			return true
	
	return false
