class_name GridControl
extends VBoxContainer


@export var grid_size: Vector2i = Vector2i(5, 5)
@export var gen_zero: Generation
@export var cell_grid_display: CellGridDisplay
@export var generation_timer: Timer
@export var play_pause_button: Button
@export var generation_control: GenerationControl
@export var edit_button: Button
@export var reset_button: Button
@export var loop_button: Button

var generation_index: int = 0:
	set(new_val):
		var clamped: int = clamp(new_val, 0, max_generations)
		if generation_index == clamped:
			return
		
		generation_index = clamped
		
		generation_control.update_no_signal(generation_index)
		
		if generations.is_empty():
			draw_generation(gen_zero)
			return
		draw_generation(generations[generation_index])
var max_generations: int = 10
var generations: Array


func _ready() -> void:
	generation_timer.timeout.connect(_on_generation_timer_timeout)
	play_pause_button.toggled.connect(_on_play_pause_toggled)
	generation_control.value_changed.connect(_on_generation_value_changed)
	edit_button.toggled.connect(_on_edit_button_toggled)
	reset_button.pressed.connect(_on_reset_button_pressed)

	cell_grid_display.create_cells(grid_size.x, grid_size.y)
	
	cell_grid_display.draw_generation(gen_zero)
	generation_control.set_up(0, max_generations)


func _input(event: InputEvent) -> void:
	if event.is_action_released("next_generation"):
		play_pause_button.button_pressed = false
		if generations.is_empty():
			calculate_generations(max_generations, gen_zero)
		generation_index += 1
		
	if event.is_action_released("previous_generation"):
		play_pause_button.button_pressed = false
		generation_index -= 1


func switch_to_edit_mode() -> void:
	generations = []
	edit_button.disabled = true
	play_pause_button.button_pressed = false
	generation_index = 0


func calculate_generations(num_of_gen: int, _gen_zero: Generation) -> void:
	var sim: Simulation = Simulation.new()
	generations = sim.calculate_generations(num_of_gen, _gen_zero)
	
	edit_button.disabled = false
	edit_button.button_pressed = false


func draw_generation(generation: Generation) -> void:
	cell_grid_display.draw_generation(generation)


func _on_generation_timer_timeout() -> void:
	if loop_button.button_pressed and generation_index == max_generations:
		generation_index = 0
		return
	
	generation_index += 1
	
	if not loop_button.button_pressed and generation_index == max_generations:
		play_pause_button.button_pressed = false


func _on_play_pause_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		play_pause_button.text = "▶"
		generation_timer.stop()
		return
	
	if generations.is_empty():
		calculate_generations(max_generations, gen_zero)
	
	if generation_index == max_generations:
		generation_index = 0

	play_pause_button.text = "⏸"
	generation_timer.start()


func _on_generation_value_changed(_generation_index: int) -> void:
	if generations.is_empty():
		calculate_generations(max_generations, gen_zero)
	
	play_pause_button.button_pressed = false
	self.generation_index = _generation_index


func _on_edit_button_toggled(toggled_on: bool) -> void:
	if not toggled_on:
		return
	switch_to_edit_mode()


func _on_reset_button_pressed() -> void:
	#gen_zero.cells = []
	switch_to_edit_mode()
