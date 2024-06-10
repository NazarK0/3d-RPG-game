class_name SkeletonWarrior extends Skeleton

func _ready() -> void:
	super._ready()
	
	ANIMATIONS = {
	"AWAKEN": "Skeletons_Awaken_Standing",
	"ATTACK": "2H_Melee_Attack_Slice",
	"DEATH": "Death_C_Skeletons",
}

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		ANIMATIONS.AWAKEN:
			Awakening = false
		ANIMATIONS.ATTACK:
			if player in ($AttackZone as Area3D).get_overlapping_bodies():
				state_machine.changeState("Attack")
		ANIMATIONS.DEATH:
			self.queue_free()

