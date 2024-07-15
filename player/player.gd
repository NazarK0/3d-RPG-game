class_name Player extends CharacterBody3D

const ANIMATION_NODES: Dictionary = {
	"IDLE": "Idle",
	"WALK": "Walk",
	"RUN": "Run",
	"JUMP": "Jump_Long",
	"ATTACK_1H": "1H_Attack",
	"ATTACK_2H": "2H_Attack",
	"DEATH": "Death",	
}

@export var gravity :float = 9.8
@export var jump_force :float = 9.0
@export var walk_speed :float = 3.0
@export var run_speed :float = 10.0

@onready var animation_tree :AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var player_mesh :Node3D = $Mesh
@onready var camera_rotation_h : Node3D = $CameraController/Horizontal

var direction: Vector3
var horizontal_velocity: Vector3
var aim_turn: float
var movement: Vector3 
var vertical_velocity: Vector3
var movement_speed: float
var angular_acceleration: float
var acceleration: float
var just_hit: bool = false

var is_attacking: bool
var is_walking: bool
var is_running: bool
var is_died: bool

func _ready() -> void:
	direction = (Vector3.BACK.rotated(Vector3.UP, camera_rotation_h
			.global_transform.basis.get_euler().y))
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		aim_turn = -event.get("relative").x * 0.015
		
	if event.is_action_pressed("aim"):
		direction = camera_rotation_h.global_transform.basis.z
	
	
func _physics_process(delta: float) -> void:
	var on_floor: bool = is_on_floor()
	
	if not is_died:
		attack1H()
		if not is_on_floor():
			vertical_velocity += Vector3.DOWN * gravity * 2 * delta
		else:
			vertical_velocity = Vector3.DOWN * gravity / 10
			
		angular_acceleration = 10
		movement_speed = 0
		acceleration = 15
		
		var horizontal_rotation: float = (
				camera_rotation_h
				.global_transform
				.basis
				.get_euler()
				.y
			)
		if (Input.is_action_just_pressed("jump") 
		and (not is_attacking) 
		and is_on_floor()):
			vertical_velocity = Vector3.UP * jump_force
			
		is_attacking = ANIMATION_NODES.ATTACK_1H in playback.get_current_node()
		
			
			
		if (Input.is_action_pressed("move_forward") 
		or Input.is_action_pressed("move_backward") 
		or Input.is_action_pressed("move_left") 
		or Input.is_action_pressed("move_right") 
		):
			if Input.is_action_pressed("sprint") and is_walking:
				movement_speed = run_speed
				is_running = true
			else:
				movement_speed = walk_speed
				is_walking = true
				
			direction = Vector3(
				(Input.get_action_strength("move_left") - Input.get_action_strength("move_right")) * movement_speed,
				0,
				(Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")) * movement_speed
				)
				
			direction = (
				direction.rotated(Vector3.UP, horizontal_rotation)
				.normalized()
				)
				
			
		else:
			is_running = false
			is_walking = false
		
		
		if Input.is_action_pressed("aim"):
			player_mesh.rotation.y = lerp_angle(
				player_mesh.rotation.y, 
				camera_rotation_h.rotation.y, 
				delta * angular_acceleration)
		else:
			player_mesh.rotation.y = lerp_angle(
				player_mesh.rotation.y, 
				atan2(direction.x, direction.z) - rotation.y, 
				delta * angular_acceleration)
				
		if is_attacking:
			horizontal_velocity = (horizontal_velocity
			.lerp(direction.normalized() * 0.1, acceleration * delta)
			)
		else:
			horizontal_velocity = (horizontal_velocity
			.lerp(direction.normalized() * movement_speed, acceleration * delta)
			)
		
		
		velocity.x = horizontal_velocity.x + vertical_velocity.x
		velocity.y = vertical_velocity.y
		velocity.z = horizontal_velocity.z + vertical_velocity.z
		
		move_and_slide()

	animation_tree["parameters/conditions/isOnFloor"] = on_floor
	animation_tree["parameters/conditions/isInAir"] = not on_floor
	animation_tree["parameters/conditions/isWalking"] = is_walking
	animation_tree["parameters/conditions/isNotWalking"] = not is_walking
	animation_tree["parameters/conditions/isRunning"] = is_running
	animation_tree["parameters/conditions/isNotRunning"] = not is_running
	animation_tree["parameters/conditions/isDied"] = is_died
	

func _on_damage_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("monsters") and is_attacking:
		(body as Monster).hitOrKill(3)
		
func _on_just_hit_timeout() -> void:
	just_hit = false


func attack1H() -> void:
	if (
		ANIMATION_NODES.IDLE in playback.get_current_node() or
		ANIMATION_NODES.WALK in playback.get_current_node()
	):
		if Input.is_action_just_pressed("attack"):
			if not is_attacking:
				playback.travel(ANIMATION_NODES.ATTACK_1H)
				
				
func hitOrKill(damage: int) -> void:
	if not just_hit:
		($JustHit as Timer).start()
		Game.player_health -= damage
		just_hit = true
		#print(Game.player_health, "health")
		
		if Game.player_health <= 0:
			is_died = true
			playback.travel(ANIMATION_NODES.DEATH)
			($Death as Timer).start()
			 
		# knockback
		var tween: Tween = create_tween()
		tween.tween_property(self, "global_position", global_position - (direction / 1.5), 0.2)








func _on_death_timeout():
	get_tree().change_scene_to_file("res://gui/game_over/game_over.tscn")
	#get_tree().call_deferred("change_scene_to_file","res://gui/game_over/game_over.tscn")
