class_name GateXor
extends LogicComponent
## 2-Input Derived XOR Gate.

func _init(id: String = "") -> void:
	super(id, "XOR")

func _setup_pins() -> void:
	add_input_pin("A")
	add_input_pin("B")
	add_output_pin("OUT")

func evaluate() -> void:
	var a = get_input(0)
	var b = get_input(1)
	# XOR: true if inputs differ
	set_output(0, (a and not b) or (not a and b))
