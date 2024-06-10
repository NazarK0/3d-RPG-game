extends Node3D

@export var camera_v_max :int = 75
@export var camera_v_min :int = -55

var h_sensitivity :float = 0.01
var v_sensitivity :float = 0.01
var h_acceleration :float = 10.0
var v_acceleration :float = 10.0
var camroot_h :float = 0.0
var camroot_v :float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camroot_h += -event.get('relative').x * h_sensitivity
		camroot_v +=event.get('relative').y * v_sensitivity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	camroot_v = clamp(camroot_v, deg_to_rad(camera_v_min), deg_to_rad(camera_v_max))
	
	var horizontal_rotation: Vector3 = $Horizontal.get("rotation")
	if horizontal_rotation != null:
		$Horizontal["rotation"].y = (
				lerpf(horizontal_rotation.y, camroot_h, delta * h_acceleration))
		
	var vertical_rotation: Vector3 = $Horizontal/Vertical.get("rotation")
	if vertical_rotation != null:
		$Horizontal/Vertical["rotation"].x = (
				lerpf(vertical_rotation.x, camroot_v, delta * v_acceleration))
