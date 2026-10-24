extends Node
## Central Event Bus for decoupled communication across systems in The Stall.

# Simulation & Time Signals
signal tick_occurred(tick_index: int)
signal clock_state_changed(is_running: bool, clock_name: String)

# Rule Lattice Signals
signal rule_changed(property_name: StringName, old_value: Variant, new_value: Variant, source_node: Node)
signal rule_registered(property_name: StringName, initial_value: Variant)

# Logic Circuit Signals
signal logic_state_changed(component_id: String, pin_name: String, new_state: bool)
signal circuit_evaluated()

# Interaction & Game Mode Signals
signal interact_requested(interactable: Node)
signal game_mode_changed(mode_name: String) # "field", "bench", "dialogue"
