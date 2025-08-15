class_name Cell
extends Resource

@export var name: StringName = "NAME"
@export var color: Color = Color.GRAY
@export var rules: Array[CellRule]


func transition(neigbours: Dictionary,priority: Array) -> int:
	var rules_by_priority: Array[CellRule] = []
	
	for i in priority:
		for rule in rules:
			if i == rule.neighbour:
				rules_by_priority.append(rule)
				break

	for rule in rules_by_priority:
		if neigbours.has(rule.neighbour):
			if rule.check_amount(neigbours.rule.neighbour):
				return rule.result_cell
	
	return 0
