class_name RuleReactiveArea
extends StaticBody2D
## World terrain or barrier that alters collision and appearance based on Lattice rules.

@export var watched_property: StringName = RuleManager.PROP_WATER_STATE
@export var solid_when_value: int = RuleManager.WaterState.LIQUID
@export var collision_shape: CollisionShape2D = null

signal physical_state_changed(is_solid: bool)

var is_solid: bool = true

func _ready() -> void:
	if collision_shape == null:
		collision_shape = get_node_or_null("CollisionShape2D")
	
	GameEvents.rule_changed.connect(_on_rule_changed)
	
	# Initial evaluation based on current rule state
	var current_rule_val = RuleManager.get_rule(watched_property)
	_evaluate_rule_state(current_rule_val)

func _on_rule_changed(property_name: StringName, _old_val: Variant, new_val: Variant, _source: Node) -> void:
	if property_name == watched_property:
		_evaluate_rule_state(new_val)

func _evaluate_rule_state(rule_value: Variant) -> void:
	if rule_value == null:
		return
	
	var should_be_solid = (int(rule_value) == solid_when_value)
	if is_solid != should_be_solid:
		is_solid = should_be_solid
		_update_physical_state()

func _update_physical_state() -> void:
	if collision_shape:
		collision_shape.set_deferred("disabled", not is_solid)
	physical_state_changed.emit(is_solid)
