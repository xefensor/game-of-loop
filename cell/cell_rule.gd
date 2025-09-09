class_name CellRule
extends Resource


@export var neighbour: int
@export var neighbour_count: Array[bool] = [
	false, false, false, false, false, false, false, false]
@export var result_cell: int
#@export var transition


func check_amount(neighbour_amount: int) -> bool:
	for i in neighbour_count.size():
		if neighbour_count[i]:
			if i+1 == neighbour_amount:
				return true
			
	return false
