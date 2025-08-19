@tool

class_name RandomAnimatedTextureRect
extends AnimatedTextureRect


func _init(atlas_texture: AtlasTexture) -> void:
	texture = atlas_texture
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	flip_h = randi_range(0, 1)
	flip_v = randi_range(0, 1)
	
	set_anchors_preset(Control.PRESET_FULL_RECT)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	fps = 1
	animation_looping = true
	auto_start = true


func _ready() -> void:
	super._ready()
	frame = randi_range(0, _number_of_frames-1)
	

	
