class_name Interactable
extends Area2D
## Base class for objects the player can inspect, flip, toggle or wire in The Stall.

signal focused(actor: Node2D)
signal unfocused(actor: Node2D)
signal interacted(actor: Node2D)

@export var prompt_text: String = "Interact"
@export var is_interactive: bool = true

var _current_actor: Node2D = null

func _ready() -> void:
	# Interaction area setup (default monitoring)
	monitoring = true
	monitorable = true
	# Dedicated collision layer/mask can be configured as needed
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func can_interact(_actor: Node2D) -> bool:
	return is_interactive

func interact(actor: Node2D) -> void:
	if not can_interact(actor):
		return
	interacted.emit(actor)
	GameEvents.interact_requested.emit(self)
	_on_interacted(actor)

## Virtual method to override in subclasses
func _on_interacted(_actor: Node2D) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		_current_actor = body
		focused.emit(body)

func _on_body_exited(body: Node2D) -> void:
	if body == _current_actor:
		_current_actor = null
		unfocused.emit(body)
