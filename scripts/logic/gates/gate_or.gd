class_name GateOr
extends LogicComponent
## 2-Input Primitive OR Gate.

func _init(id: String = "") -> void:
	super(id, "OR")

func _setup_pins() -> void:
	add_input_pin("A")
	add_input_pin("B")
	add_output_pin("OUT")

func evaluate() -> void:
	var a = get_input(0)
	var b = get_input(1)
	set_output(0, a or b)
