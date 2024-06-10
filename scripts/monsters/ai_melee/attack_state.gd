extends Node

var monster: Monster


func _ready() -> void:
	monster = get_parent().get_parent()
	var animation_tree :AnimationMixer = monster.get_node("AnimationTree")
	
	if monster.Awakening:
		await animation_tree.animation_finished
	
	monster.Attacking = true
	(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ).travel("2H_Attack")
	var look_at_direction: Vector3 = monster.global_transform.origin + monster.direction
	monster.look_at(look_at_direction)


func _physics_process(_delta: float) -> void:
	if monster:
		monster.velocity.x = 0
		monster.velocity.z = 0
