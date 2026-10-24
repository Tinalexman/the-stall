extends Node
## Central Lattice / Rule Manager for The Stall.
## Manages global and regional physical rules dictated by Rule Nodes.

# Standard Rule Properties
const PROP_WATER_STATE: StringName = &"water_state"
const PROP_SOLIDITY: StringName = &"solidity"
const PROP_CONDUCTIVITY: StringName = &"conductivity"

# Rule Value Definitions
enum WaterState {
	LIQUID = 0,
	ICE = 1
}

enum SolidityState {
	PASSABLE = 0,
	SOLID = 1
}

enum ConductivityState {
	INSULATING = 0,
	CONDUCTIVE = 1
}

# Current active state of all rules on the Lattice
var _active_rules: Dictionary = {
	PROP_WATER_STATE: WaterState.LIQUID,
	PROP_SOLIDITY: SolidityState.SOLID,
	PROP_CONDUCTIVITY: ConductivityState.INSULATING
}

# Registry of Rule Nodes currently active in the world
var _registered_nodes: Array = []

func _ready() -> void:
	# Broadcast initial default rules
	for prop in _active_rules:
		GameEvents.rule_registered.emit(prop, _active_rules[prop])

## Returns the current value of a rule property.
func get_rule(property_name: StringName, default_value: Variant = null) -> Variant:
	return _active_rules.get(property_name, default_value)

## Sets a rule property on the Lattice.
func set_rule(property_name: StringName, new_value: Variant, source_node: Node = null) -> bool:
	if not _active_rules.has(property_name):
		_active_rules[property_name] = new_value
		GameEvents.rule_registered.emit(property_name, new_value)
		GameEvents.rule_changed.emit(property_name, null, new_value, source_node)
		return true

	var old_value = _active_rules[property_name]
	if old_value != new_value:
		_active_rules[property_name] = new_value
		GameEvents.rule_changed.emit(property_name, old_value, new_value, source_node)
		return true

	return false

## Rule node registration
func register_rule_node(node: Node) -> void:
	if not _registered_nodes.has(node):
		_registered_nodes.append(node)

func unregister_rule_node(node: Node) -> void:
	_registered_nodes.erase(node)

## Helper convenience query methods
func is_water_frozen() -> bool:
	return get_rule(PROP_WATER_STATE, WaterState.LIQUID) == WaterState.ICE

func is_solid(property_name: StringName = PROP_SOLIDITY) -> bool:
	return get_rule(property_name, SolidityState.SOLID) == SolidityState.SOLID

func is_conductive(property_name: StringName = PROP_CONDUCTIVITY) -> bool:
	return get_rule(property_name, ConductivityState.INSULATING) == ConductivityState.CONDUCTIVE
