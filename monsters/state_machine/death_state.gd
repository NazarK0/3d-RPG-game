extends Node

var monster: CharacterBody3D


func _ready() -> void:
	monster = get_parent().get_parent()
	var animation_tree :AnimationMixer = monster.get_node("AnimationTree")
	
	(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ).travel("Death")


func _physics_process(_delta: float) -> void:
	if monster:
		monster.velocity.x = 0
		monster.velocity.z = 0
