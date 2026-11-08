extends CharacterBody2D

signal request_player_one_load(location : Vector2)

@export var SPEED : float = 30.0
@export var MAX_SPEED : float = 1000.0
@export var FRICTION : float = 10.0
@export var JUMP_VELOCITY : float = -800.0

var loadedInCannon : bool = false

func _process(_delta: float) -> void:
	if Input.get_joy_axis(1, JOY_AXIS_LEFT_X) < -0.2:
		$Sprite2D.flip_h = true
	elif Input.get_joy_axis(1, JOY_AXIS_LEFT_X) > 0.2:
		$Sprite2D.flip_h = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not (is_on_floor() or loadedInCannon):
		velocity += get_gravity() * delta

	# Handle bubble ability
	if Input.get_joy_axis(1, JOY_AXIS_TRIGGER_RIGHT) != 0:
		print("boom bubble ability pressed")
		$Bubble.ability_one()

	# Handle loading into cannon
	if Input.get_joy_axis(1, JOY_AXIS_TRIGGER_LEFT) != 0:
		print("pow load ability pressed")
		request_player_one_load.emit(global_position)

	# Handle jump
	if Input.is_joy_button_pressed(1, JOY_BUTTON_RIGHT_SHOULDER) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_joy_axis(1, JOY_AXIS_LEFT_X)
	if direction < -0.2 or direction > 0.2:
		velocity.x += direction * SPEED
	
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

	move_and_slide()


func _on_player_1_launch_player_two(angle: float, launchPower: int) -> void:
	print("launch player 2 signal sucessful")
	loadedInCannon = false
	velocity += (Vector2.from_angle(angle + PI) * launchPower)
	print(velocity)


func _on_player_1_player_two_loaded(answer: bool) -> void:
	print("player 2 loaded: " + str(answer))
	loadedInCannon = answer
