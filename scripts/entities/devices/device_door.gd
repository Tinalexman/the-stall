class_name DeviceDoor
extends Device
## Actuator door in the field that opens when receiving a HIGH signal.

signal door_state_changed(is_open: bool)

@export var open_when_powered: bool = true
@export var collision_shape: CollisionShape2D = null

var input_pin: LogicPin = null
var is_open: bool = false

func _setup_device() -> void:
	device_name = "Door"
	role = DeviceRole.OUTPUT
	input_pin = add_device_input("OPEN")

func _ready() -> void:
	super._ready()
	if collision_shape == null:
		collision_shape = get_node_or_null("CollisionShape2D")
	_apply_door_state()

func tick_apply_output() -> void:
	var powered = input_pin.state if input_pin else false
	var target_open = powered if open_when_powered else not powered
	if is_open != target_open:
		is_open = target_open
		_apply_door_state()
		door_state_changed.emit(is_open)

func _apply_door_state() -> void:
	if collision_shape:
		# When open, door is passable (collision disabled)
		collision_shape.set_deferred("disabled", is_open)
