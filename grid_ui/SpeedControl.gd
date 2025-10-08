class_name SpeedControl
extends HBoxContainer

signal value_changed(generation_index: int)

@export var spin_box: SpinBox
@export var h_slider: HSlider
@export var timer: Timer


func _ready() -> void:
	spin_box.value_changed.connect(_on_spin_box_value_changed)
	h_slider.value_changed.connect(_on_h_slider_value_changed)
	
	update_no_signal(timer.wait_time)


func set_up(min_index: float, max_index: float):
	spin_box.min_value = min_index
	spin_box.max_value = max_index
	
	h_slider.min_value = min_index
	h_slider.max_value = max_index


func update_no_signal(value: float):
	spin_box.set_value_no_signal(value)
	h_slider.set_value_no_signal(value)


func _on_spin_box_value_changed(value: float) -> void:
	h_slider.set_value_no_signal(value)
	timer.wait_time = value
	value_changed.emit(int(value))
	
	
func _on_h_slider_value_changed(value: float) -> void:
	spin_box.set_value_no_signal(value)
	timer.wait_time = value
	value_changed.emit(int(value))
