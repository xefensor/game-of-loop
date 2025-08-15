class_name CellRule
extends Resource


@export var neighbour: int
@export var neighbour_count: Array[bool] = [
	false, false, false, false, false, false, false, false]
@export var result_cell: int
#@export var transition


func check_amount(neighbour_amount: int) -> bool:
	var neighbour_number: PackedInt32Array
	
	for i in neighbour_count.size():
		if neighbour_count[i]:
			neighbour_number.append(i+1)
	
	for i in neighbour_number:
		if neighbour_amount == i:
			return true
	
	return false
