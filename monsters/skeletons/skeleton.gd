class_name Skeleton extends Monster

func _ready() -> void:
	state_machine.changeState("Idle")
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin)

	move_and_slide()


func _on_just_hit_timeout() -> void:
	just_hit = false


func _on_chase_zone_body_entered(body: Node3D) -> void:
	#print("chase in")
	if body.is_in_group("players") and not dying:
		state_machine.changeState("Run")

func _on_chase_zone_body_exited(body: Node3D) -> void:
	#print("chase out")
	if body.is_in_group("players") and not dying:
		state_machine.changeState("Idle")


func _on_attack_zone_body_entered(body: Node3D) -> void:
	#print("attack in")
	if body.is_in_group("players") and not dying:
		state_machine.changeState("Attack")
	
	if body.is_in_group("players") and Attacking:
		(body as Player).hitOrKill(_damage)


func _on_attack_zone_body_exited(body: Node3D) -> void:
	#print("attack out")
	if body.is_in_group("players") and not dying:
		state_machine.changeState("Run")


@warning_ignore("unused_parameter")
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	pass
			
func hitOrKill(damage: int) -> void:
	if not just_hit:
		($JustHit as Timer).start()
		health -= damage
		just_hit = true
		
		if health <= 0:
			state_machine.changeState("Death")
			
		# knockback
		var tween: Tween = create_tween()
		tween.tween_property(self, "global_position", global_position - (direction / 1.5), 0.2)


