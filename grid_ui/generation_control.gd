class_name GenerationControl
extends HBoxContainer


signal value_changed(generation_index: int)

@export var spin_box: SpinBox
@export var h_slider: HSlider


func _ready() -> void:
	spin_box.value_changed.connect(_on_spin_box_value_changed)
	h_slider.value_changed.connect(_on_h_slider_value_changed)


func set_up(min_index: int, max_index: int) -> void:
	spin_box.min_value = min_index
	spin_box.max_value = max_index
	
	h_slider.min_value = min_index
	h_slider.max_value = max_index
	
	spin_box.suffix = "/" + str(max_index)


func update_no_signal(value: int) -> void:
	h_slider.set_value_no_signal(value)
	spin_box.set_value_no_signal(value)


func _on_spin_box_value_changed(value: float) -> void:
	h_slider.set_value_no_signal(value)
	value_changed.emit(int(value))
	
	
func _on_h_slider_value_changed(value: float) -> void:
	spin_box.set_value_no_signal(value)
	value_changed.emit(int(value))
