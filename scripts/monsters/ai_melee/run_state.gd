extends Node

var monster: Monster
var run : bool

func _ready() -> void:
	monster = get_parent().get_parent()
	var animation_tree :AnimationMixer = monster.get_node("AnimationTree")
	
	if monster.Attacking:
		await animation_tree.animation_finished
	else:
		run = false
		(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ) \
		.travel("Awaken")
		monster.Awakening = true
		await animation_tree.animation_finished
		
	run = true
	monster.Awakening = false
	(animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback ) \
	.travel("Run")


func _physics_process(_delta: float) -> void:
	if monster and run:
		var look_at_direction: Vector3 = (
			monster.global_transform.origin + monster.direction
			)
			
		monster.velocity.x = monster.direction.x * monster.SPEED
		monster.velocity.z = monster.direction.z * monster.SPEED
		monster.look_at(look_at_direction)
