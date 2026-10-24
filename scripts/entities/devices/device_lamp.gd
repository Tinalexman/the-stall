class_name DeviceLamp
extends Device
## Visual field indicator/light that turns on when receiving a HIGH signal.

signal lamp_state_changed(is_lit: bool)

var input_pin: LogicPin = null
var is_lit: bool = false

func _setup_device() -> void:
	device_name = "Lamp"
	role = DeviceRole.OUTPUT
	input_pin = add_device_input("IN")

func tick_apply_output() -> void:
	var state = input_pin.state if input_pin else false
	if is_lit != state:
		is_lit = state
		lamp_state_changed.emit(is_lit)
