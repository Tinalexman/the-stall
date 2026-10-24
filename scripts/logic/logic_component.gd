class_name LogicComponent
extends RefCounted
## Base class for logic components (primitives, chips, circuits).

signal evaluated()

var component_id: String = ""
var component_name: String = "LogicComponent"

var inputs: Array[LogicPin] = []
var outputs: Array[LogicPin] = []

func _init(id: String = "", name: String = "LogicComponent") -> void:
	component_id = id if id != "" else str(get_instance_id())
	component_name = name
	_setup_pins()

## Override to define default inputs and outputs in subclasses.
func _setup_pins() -> void:
	pass

func add_input_pin(pin_name: String) -> LogicPin:
	var pin = LogicPin.new(pin_name, LogicPin.PinType.INPUT)
	inputs.append(pin)
	return pin

func add_output_pin(pin_name: String) -> LogicPin:
	var pin = LogicPin.new(pin_name, LogicPin.PinType.OUTPUT)
	outputs.append(pin)
	return pin

func get_input(index: int) -> bool:
	if index >= 0 and index < inputs.size():
		return inputs[index].state
	return false

func set_output(index: int, value: bool) -> void:
	if index >= 0 and index < outputs.size():
		outputs[index].state = value

## Core logic evaluation step - override in derived gates and chips.
func evaluate() -> void:
	pass

## Called during the simulation tick cycle by TickManager.
func tick_evaluate() -> void:
	evaluate()
	for out_pin in outputs:
		out_pin.propagate()
	evaluated.emit()
