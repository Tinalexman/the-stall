extends Node
## Central simulation manager governing discrete ticks in The Stall.
## In the lore, the Master Clock has stopped, freezing all circuits.
## Components register here to evaluate during the simulation cycle.

signal tick(tick_count: int)
signal pre_tick(tick_count: int)
signal post_tick(tick_count: int)
signal clock_toggled(is_running: bool)

@export var is_clock_running: bool = false:
	set(val):
		if is_clock_running != val:
			is_clock_running = val
			clock_toggled.emit(is_clock_running)
			GameEvents.clock_state_changed.emit(is_clock_running, "MasterClock")

@export var ticks_per_second: float = 4.0:
	set(val):
		ticks_per_second = max(0.1, val)
		_timer_interval = 1.0 / ticks_per_second

var tick_count: int = 0
var _timer_accumulator: float = 0.0
var _timer_interval: float = 0.25

# Registered logic components and devices
var _registered_inputs: Array = []
var _registered_logic: Array = []
var _registered_outputs: Array = []

func _ready() -> void:
	_timer_interval = 1.0 / ticks_per_second

func _process(delta: float) -> void:
	if not is_clock_running:
		return
	
	_timer_accumulator += delta
	while _timer_accumulator >= _timer_interval:
		_timer_accumulator -= _timer_interval
		step_tick()

## Triggers a single simulation step.
func step_tick() -> void:
	tick_count += 1
	pre_tick.emit(tick_count)
	
	# Phase 1: Input devices read environment/state (switches, sensors)
	for input_dev in _registered_inputs:
		if is_instance_valid(input_dev) and input_dev.has_method("tick_read_input"):
			input_dev.tick_read_input()
	
	# Phase 2: Logic propagation and evaluation (wires, gates, chips)
	for logic_comp in _registered_logic:
		if is_instance_valid(logic_comp) and logic_comp.has_method("tick_evaluate"):
			logic_comp.tick_evaluate()
	
	# Phase 3: Output devices & Rule nodes receive signals and update world state
	for output_dev in _registered_outputs:
		if is_instance_valid(output_dev) and output_dev.has_method("tick_apply_output"):
			output_dev.tick_apply_output()
	
	tick.emit(tick_count)
	GameEvents.tick_occurred.emit(tick_count)
	post_tick.emit(tick_count)

## Registration methods for simulation cycle
func register_input_device(device: Object) -> void:
	if not _registered_inputs.has(device):
		_registered_inputs.append(device)

func unregister_input_device(device: Object) -> void:
	_registered_inputs.erase(device)

func register_logic_component(component: Object) -> void:
	if not _registered_logic.has(component):
		_registered_logic.append(component)

func unregister_logic_component(component: Object) -> void:
	_registered_logic.erase(component)

func register_output_device(device: Object) -> void:
	if not _registered_outputs.has(device):
		_registered_outputs.append(device)

func unregister_output_device(device: Object) -> void:
	_registered_outputs.erase(device)

## Manual control helpers
func start_clock() -> void:
	is_clock_running = true

func stop_clock() -> void:
	is_clock_running = false

func toggle_clock() -> void:
	is_clock_running = not is_clock_running
