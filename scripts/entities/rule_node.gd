class_name RuleNode
extends Device
## Ancient stone-and-metal pylon connecting digital logic to the physical world's Lattice.

signal rule_state_updated(new_value: Variant)

@export var rule_property: StringName = RuleManager.PROP_WATER_STATE
@export var value_when_high: int = RuleManager.WaterState.ICE
@export var value_when_low: int = RuleManager.WaterState.LIQUID
@export var pylon_label: String = "Water Rule Node"

var input_pin: LogicPin = null
var current_value: Variant = null

func _setup_device() -> void:
	device_name = pylon_label
	role = DeviceRole.OUTPUT
	input_pin = add_device_input("LATTICE_IN")
	current_value = value_when_low

func _ready() -> void:
	super._ready()
	RuleManager.register_rule_node(self)
	# Apply initial baseline rule
	_apply_current_rule()

func _exit_tree() -> void:
	super._exit_tree()
	RuleManager.unregister_rule_node(self)

func tick_apply_output() -> void:
	var is_high = input_pin.state if input_pin else false
	var target_value = value_when_high if is_high else value_when_low
	
	if current_value != target_value:
		current_value = target_value
		_apply_current_rule()
		rule_state_updated.emit(current_value)

func _apply_current_rule() -> void:
	RuleManager.set_rule(rule_property, current_value, self)
