class_name DeviceBattery
extends Device
## Constant power supply source in The Stall.

@export var is_charged: bool = true

var output_pin: LogicPin = null

func _setup_device() -> void:
	device_name = "Battery"
	role = DeviceRole.INPUT
	output_pin = add_device_output("POWER", is_charged)

func tick_read_input() -> void:
	if output_pin:
		output_pin.state = is_charged
		output_pin.propagate()
