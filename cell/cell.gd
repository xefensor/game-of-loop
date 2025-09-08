class_name Cell
extends Resource

@export var name: StringName = "NAME"
@export var texture: Texture = PlaceholderTexture2D.new()
@export var rules: Array[CellRule]


func get_rules_by_priority(priority: Array) -> Array:
	var rules_by_priority: Array[CellRule] = []
	
	for i in priority:
		for rule in rules:
			if i == rule.neighbour:
				rules_by_priority.append(rule)
				break
	
	return rules_by_priority


func get_transition_rule(neighbours_count: Dictionary, rules_by_priority: Array) -> CellRule:
	for rule in rules_by_priority:
		if neighbours_count.has(rule.neighbour):
			if rule.check_amount(neighbours_count[rule.neighbour]):
				return rule
	
	return null


func get_transition_cell(neighbours_count: Dictionary, priority: Array) -> int:
	var rule = get_transition_rule(neighbours_count, get_rules_by_priority(priority))
	
	if rule:
		return rule.result_cell
	else:
		return 0
