extends Node

var monster: Monster


func _ready() -> void:
	monster = get_parent().get_parent()
	var animation_tree :AnimationMixer = monster.get_node("AnimationTree")
	
	if monster.Awakening:
		await animation_tree.animation_finished
	
	(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ).travel("Idle")


func _physics_process(_delta: float) -> void:
	if monster:
		monster.velocity.x = 0
		monster.velocity.z = 0
