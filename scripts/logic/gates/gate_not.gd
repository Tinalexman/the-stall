class_name GateNot
extends LogicComponent
## 1-Input Primitive NOT Gate (Inverter / Flipper).

func _init(id: String = "") -> void:
	super(id, "NOT")

func _setup_pins() -> void:
	add_input_pin("IN")
	add_output_pin("OUT")

func evaluate() -> void:
	var in_val = get_input(0)
	set_output(0, not in_val)
