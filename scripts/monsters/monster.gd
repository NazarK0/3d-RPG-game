class_name Monster extends CharacterBody3D

@export var SPEED: float = 1.0
@export var player: CharacterBody3D
@export var ANIMATIONS: Dictionary
@onready var state_machine: StateMachine = $StateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var direction: Vector3
var Awakening: bool = false
var Attacking: bool = false
var dying: bool = false
var just_hit: bool = false
var health: int = 4
@warning_ignore("unused_private_class_variable")
var _damage: int = 2

@warning_ignore("unused_parameter")
func hitOrKill(damage: int) -> void:
	pass
