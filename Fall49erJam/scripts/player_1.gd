extends RigidBody2D

signal launch_player_two(angle : float, launchPower : int)
signal player_two_loaded(answer : bool)

@export var airSpeed : int = 5
@export var launchPower : int = 500
@export var playerTwoLoadRange : float = 10

var playerTwoLoaded : bool = false

func _physics_process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		constant_force = Vector2.ZERO
		return
	var moveAxis = (Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), 0)) * airSpeed * delta
	apply_central_impulse(moveAxis)

func _on_cannon_blast(angle: Variant, playerTwoLoadedInCannon: bool) -> void:
	if !playerTwoLoaded:
		set_axis_velocity(Vector2.from_angle(angle) * launchPower)
		return
	
	launch_player_two.emit(angle, launchPower)


func _on_player_2_request_player_one_load(location: Vector2) -> void:
	if global_position.distance_to(location) > playerTwoLoadRange:
		player_two_loaded.emit(false)
		return
	
	$Cannon.load_player_two()
	playerTwoLoaded = true
	player_two_loaded.emit(true)
