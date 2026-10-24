class_name LogicWire
extends Line2D
## Visual and logical wire connection between two pins in the field or bench.

@export var powered_color: Color = Color(0.2, 0.9, 1.0, 1.0) # Bright cyan
@export var unpowered_color: Color = Color(0.3, 0.3, 0.35, 1.0) # Dark muted slate

var source_pin: LogicPin = null
var target_pin: LogicPin = null
var is_powered: bool = false

func _ready() -> void:
	width = 2.0
	default_color = unpowered_color
	# Pixel art friendly cap mode
	round_precision = 2

## Connects two pins and starts observing state changes.
func connect_pins(source: LogicPin, target: LogicPin) -> bool:
	if source == null or target == null:
		return false
	
	source_pin = source
	target_pin = target
	
	var success = source_pin.connect_to(target_pin)
	if success:
		source_pin.state_changed.connect(_on_source_state_changed)
		_on_source_state_changed(source_pin.state)
	return success

func disconnect_pins() -> void:
	if source_pin and target_pin:
		if source_pin.state_changed.is_connected(_on_source_state_changed):
			source_pin.state_changed.disconnect(_on_source_state_changed)
		source_pin.disconnect_from(target_pin)
	source_pin = null
	target_pin = null
	_set_powered(false)

func _on_source_state_changed(new_state: bool) -> void:
	_set_powered(new_state)

func _set_powered(powered: bool) -> void:
	is_powered = powered
	default_color = powered_color if is_powered else unpowered_color

func _exit_tree() -> void:
	disconnect_pins()
