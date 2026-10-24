class_name DeviceSwitch
extends Device
## Interactive physical switch / lever in the field.

signal switch_toggled(is_on: bool)

@export var is_on: bool = false:
	set(val):
		is_on = val
		if output_pin:
			output_pin.state = is_on
		switch_toggled.emit(is_on)

var output_pin: LogicPin = null

func _setup_device() -> void:
	device_name = "Switch"
	role = DeviceRole.INPUT
	output_pin = add_device_output("OUT", is_on)

func toggle() -> void:
	is_on = not is_on

func tick_read_input() -> void:
	if output_pin:
		output_pin.state = is_on
		output_pin.propagate()
