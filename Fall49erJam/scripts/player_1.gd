extends RigidBody2D

signal launch_player_two(angle : float, launchPower : int)
signal player_two_loaded(answer : bool)

@export var airSpeed : int = 5
@export var selfLaunchPower : int = 500
@export var otherLaunchPower : int = 1000
@export var playerTwoLoadRange : float = 10

var playerTwoLoaded : bool = false

func _process(_delta: float) -> void:
	if Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) < -0.2:
		$Sprite2D.flip_h = true
	elif Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) > 0.2:
		$Sprite2D.flip_h = false

func _physics_process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		constant_force = Vector2.ZERO
		return
	
	if Input.get_joy_axis(0, JOY_AXIS_LEFT_X) > 0.2 or Input.get_joy_axis(0, JOY_AXIS_LEFT_X) < -0.2:
		var moveAxis = (Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), 0)) * airSpeed * delta
		apply_central_impulse(moveAxis)

func _on_cannon_blast(angle: Variant, playerTwoLoadedInCannon: bool) -> void:
	if !playerTwoLoadedInCannon:
		set_axis_velocity(Vector2.from_angle(angle) * selfLaunchPower)
		return
	
	$Cannon.playerTwoLoaded = false
	playerTwoLoaded = false
	launch_player_two.emit(angle, otherLaunchPower)


func _on_player_2_request_player_one_load(location: Vector2) -> void:
	if global_position.distance_to(location) > playerTwoLoadRange:
		print("player 2 load request failed")
		player_two_loaded.emit(false)
		return
	
	print("player 2 load request successful")
	$Cannon.load_player_two()
	playerTwoLoaded = true
	player_two_loaded.emit(true)
