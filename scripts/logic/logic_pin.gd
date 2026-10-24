class_name LogicPin
extends RefCounted
## Represents an input or output terminal on a logic gate, chip, or device.

signal state_changed(new_state: bool)

enum PinType {
	INPUT,
	OUTPUT
}

var pin_name: String = "pin"
var pin_type: PinType = PinType.INPUT
var state: bool = false:
	set(val):
		if state != val:
			state = val
			state_changed.emit(state)

# Wire/Connection tracking:
# If this is an OUTPUT, it can drive multiple connected INPUT pins.
# If this is an INPUT, it is driven by one source OUTPUT pin (or wire).
var connections: Array[LogicPin] = []
var source_pin: LogicPin = null

func _init(p_name: String = "pin", p_type: PinType = PinType.INPUT, p_initial_state: bool = false) -> void:
	pin_name = p_name
	pin_type = p_type
	state = p_initial_state

## Connect this pin to a target pin.
## This pin should be an OUTPUT and target should be an INPUT.
func connect_to(target_pin: LogicPin) -> bool:
	if pin_type != PinType.OUTPUT or target_pin.pin_type != PinType.INPUT:
		push_warning("Invalid pin connection: Can only connect OUTPUT to INPUT.")
		return false
	
	if not connections.has(target_pin):
		connections.append(target_pin)
		target_pin.source_pin = self
		# Immediately sync state
		target_pin.state = state
		return true
	return false

## Disconnect from a target pin.
func disconnect_from(target_pin: LogicPin) -> void:
	if connections.has(target_pin):
		connections.erase(target_pin)
		if target_pin.source_pin == self:
			target_pin.source_pin = null
			target_pin.state = false

## Pushes output state across all connected input pins.
func propagate() -> void:
	if pin_type != PinType.OUTPUT:
		return
	for connected in connections:
		if is_instance_valid(connected):
			connected.state = state
