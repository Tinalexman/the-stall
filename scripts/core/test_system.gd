extends Node
## Self-test script to verify digital logic, tick simulation, and Rule Lattice integration.

func _ready() -> void:
	print("--- Running The Stall System Diagnostics ---")
	test_logic_gates()
	test_circuit_and_rule_propagation()
	print("--- All Foundation Systems Passed Diagnostics ---")

func test_logic_gates() -> void:
	# 1. AND Gate
	var and_gate = GateAnd.new()
	and_gate.inputs[0].state = true
	and_gate.inputs[1].state = true
	and_gate.evaluate()
	assert(and_gate.outputs[0].state == true, "AND gate failed 1 AND 1")
	
	and_gate.inputs[1].state = false
	and_gate.evaluate()
	assert(and_gate.outputs[0].state == false, "AND gate failed 1 AND 0")
	print("✔ GateAnd passed")

	# 2. OR Gate
	var or_gate = GateOr.new()
	or_gate.inputs[0].state = false
	or_gate.inputs[1].state = true
	or_gate.evaluate()
	assert(or_gate.outputs[0].state == true, "OR gate failed 0 OR 1")

	or_gate.inputs[1].state = false
	or_gate.evaluate()
	assert(or_gate.outputs[0].state == false, "OR gate failed 0 OR 0")
	print("✔ GateOr passed")

	# 3. NOT Gate
	var not_gate = GateNot.new()
	not_gate.inputs[0].state = false
	not_gate.evaluate()
	assert(not_gate.outputs[0].state == true, "NOT gate failed NOT 0")

	not_gate.inputs[0].state = true
	not_gate.evaluate()
	assert(not_gate.outputs[0].state == false, "NOT gate failed NOT 1")
	print("✔ GateNot passed")

	# 4. XOR Gate
	var xor_gate = GateXor.new()
	xor_gate.inputs[0].state = true
	xor_gate.inputs[1].state = true
	xor_gate.evaluate()
	assert(xor_gate.outputs[0].state == false, "XOR gate failed 1 XOR 1")

	xor_gate.inputs[1].state = false
	xor_gate.evaluate()
	assert(xor_gate.outputs[0].state == true, "XOR gate failed 1 XOR 0")
	print("✔ GateXor passed")

func test_circuit_and_rule_propagation() -> void:
	# Verify default water state
	assert(RuleManager.get_rule(RuleManager.PROP_WATER_STATE) == RuleManager.WaterState.LIQUID, "Initial water state should be LIQUID")
	assert(not RuleManager.is_water_frozen(), "Water should initially not be frozen")

	# Create a Switch, NOT gate, and RuleNode
	var switch_dev = DeviceSwitch.new()
	switch_dev.is_on = false
	add_child(switch_dev)

	var not_gate = GateNot.new()
	# Connect switch output to NOT gate input
	switch_dev.output_pin.connect_to(not_gate.inputs[0])

	var rule_node = RuleNode.new()
	rule_node.rule_property = RuleManager.PROP_WATER_STATE
	rule_node.value_when_high = RuleManager.WaterState.ICE
	rule_node.value_when_low = RuleManager.WaterState.LIQUID
	add_child(rule_node)

	# Connect NOT gate output to RuleNode input
	not_gate.outputs[0].connect_to(rule_node.input_pin)

	# Register logic component with tick manager
	TickManager.register_logic_component(not_gate)

	# Tick simulation: Switch is OFF (false) -> NOT turns into ON (true) -> RuleNode sets water to ICE
	TickManager.step_tick()

	assert(RuleManager.is_water_frozen(), "Water should be frozen when NOT gate outputs TRUE")
	print("✔ Circuit to Rule Node integration passed: Water frozen")

	# Turn switch ON (true) -> NOT gate turns into OFF (false) -> Water unfreezes (LIQUID)
	switch_dev.is_on = true
	TickManager.step_tick()

	assert(not RuleManager.is_water_frozen(), "Water should unfreeze when switch is ON and inverted by NOT")
	print("✔ Circuit unfreeze passed: Water liquid")

	# Clean up test nodes
	TickManager.unregister_logic_component(not_gate)
	switch_dev.queue_free()
	rule_node.queue_free()
