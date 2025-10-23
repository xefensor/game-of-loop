extends Node


@export var cells: Dictionary[int, Cell]
@export var priority: Array[int]


func _init() -> void:
	var settings: CellsSetting = load("res://cell/cells.tres")
	cells = settings.cells
	priority = settings.priority
