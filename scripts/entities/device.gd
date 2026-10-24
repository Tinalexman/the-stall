class_name Device
extends Node2D
## Base class for physical interactive devices in the world (switches, lamps, rule nodes, batteries).

signal state_updated()

enum DeviceRole {
	INPUT,   # Switches, sensors, clocks
	OUTPUT,  # Lamps, doors, motors
	HYBRID   # Rule nodes, relays, power converters
}

@export var device_name: String = "Device"
@export var role: DeviceRole = DeviceRole.INPUT

var inputs: Array[LogicPin] = []
var outputs: Array[LogicPin] = []

func _ready() -> void:
	_setup_device()
	_register_with_tick_manager()

func _exit_tree() -> void:
	_unregister_with_tick_manager()

## Override in subclasses to add pins
func _setup_device() -> void:
	pass

func add_device_input(pin_name: String) -> LogicPin:
	var pin = LogicPin.new(pin_name, LogicPin.PinType.INPUT)
	inputs.append(pin)
	return pin

func add_device_output(pin_name: String, initial_state: bool = false) -> LogicPin:
	var pin = LogicPin.new(pin_name, LogicPin.PinType.OUTPUT, initial_state)
	outputs.append(pin)
	return pin

func get_input_pin(index_or_name: Variant) -> LogicPin:
	if index_or_name is int and index_or_name >= 0 and index_or_name < inputs.size():
		return inputs[index_or_name]
	elif index_or_name is String or index_or_name is StringName:
		for pin in inputs:
			if pin.pin_name == str(index_or_name):
				return pin
	return null

func get_output_pin(index_or_name: Variant) -> LogicPin:
	if index_or_name is int and index_or_name >= 0 and index_or_name < outputs.size():
		return outputs[index_or_name]
	elif index_or_name is String or index_or_name is StringName:
		for pin in outputs:
			if pin.pin_name == str(index_or_name):
				return pin
	return null

## Called by TickManager during Phase 1 for INPUT devices
func tick_read_input() -> void:
	pass

## Called by TickManager during Phase 3 for OUTPUT devices
func tick_apply_output() -> void:
	pass

func _register_with_tick_manager() -> void:
	match role:
		DeviceRole.INPUT:
			TickManager.register_input_device(self)
		DeviceRole.OUTPUT:
			TickManager.register_output_device(self)
		DeviceRole.HYBRID:
			TickManager.register_input_device(self)
			TickManager.register_output_device(self)

func _unregister_with_tick_manager() -> void:
	match role:
		DeviceRole.INPUT:
			TickManager.unregister_input_device(self)
		DeviceRole.OUTPUT:
			TickManager.unregister_output_device(self)
		DeviceRole.HYBRID:
			TickManager.unregister_input_device(self)
			TickManager.unregister_output_device(self)
