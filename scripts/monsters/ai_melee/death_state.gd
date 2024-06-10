extends Node

var ai_controller: CharacterBody3D


func _ready() -> void:
	ai_controller = get_parent().get_parent()
	var animation_tree :AnimationMixer = ai_controller.get_node("AnimationTree")
	
	(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ).travel("Death")


func _physics_process(_delta: float) -> void:
	if ai_controller:
		ai_controller.velocity.x = 0
		ai_controller.velocity.z = 0
