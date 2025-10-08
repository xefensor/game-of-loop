class_name GridControl
extends VBoxContainer


@export var gen_zero: Generation
@export var cell_grid_display: CellGridDisplay
@export var generation_timer: Timer
@export var play_pause_button: Button
@export var generation_control: GenerationControl


var generation_index: int = 0:
	set(new_val):
		generation_index = clamp(new_val, 0, max_generation) 
		
		generation_control.update_no_signal(generation_index)
		
		if generations.is_empty():
			return
		draw_generation(generations[generation_index])
var max_generation: int = 30
		
var generations: Array


func _ready() -> void:
	generation_timer.timeout.connect(_on_generation_timer_timeout)
	play_pause_button.toggled.connect(_on_play_pause_toggled)
	generation_control.value_changed.connect(_on_generation_value_changed)
		
	cell_grid_display.create_cells(5, 5)

	var sim: Simulation = Simulation.new()
	generations = sim.calculate_generations(10, gen_zero)
	max_generation = generations.size()-1
	
	cell_grid_display.draw_generation(gen_zero)
	generation_control.set_up(0, max_generation)


func draw_generation(generation: Generation):	
	cell_grid_display.draw_generation(generation)


func _on_generation_timer_timeout() -> void:
	generation_index += 1
	
	if generation_index == max_generation:
		generation_timer.stop()
		play_pause_button.button_pressed = false


func _on_play_pause_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		generation_timer.stop()
		return
		
	if generation_index == max_generation:
		generation_index = 0

	generation_timer.start()


func _on_generation_value_changed(_generation_index: int) -> void:
	self.generation_index = _generation_index
