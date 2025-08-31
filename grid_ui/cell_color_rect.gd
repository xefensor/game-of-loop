class_name CellColorRect
extends ColorRect


var grid_position: Vector2i
var animated_texture: RandomAnimatedTextureRect


func _init(_grid_position: Vector2i, _color: Color = Color.DIM_GRAY) -> void:
	grid_position = _grid_position
	color = _color
	
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL

	animated_texture = RandomAnimatedTextureRect.new(preload("res://cells/life/life_sprite.tres"))
	add_child(animated_texture)
