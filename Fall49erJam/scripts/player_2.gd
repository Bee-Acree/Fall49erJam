extends CharacterBody2D

signal request_player_one_load(location : Vector2)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var loadedInCannon := false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not (is_on_floor() && loadedInCannon):
		velocity += get_gravity() * delta

	# Handle bubble ability
	if Input.get_joy_axis(1, JOY_AXIS_TRIGGER_RIGHT) >= .9:
		$Bubble.ability_one()

	# Handle loading into cannon
	if Input.get_joy_axis(1, JOY_AXIS_TRIGGER_LEFT):
		request_player_one_load.emit(global_position)

	# Handle jump
	if Input.is_joy_button_pressed(1, JOY_BUTTON_RIGHT_SHOULDER) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_player_1_launch_player_two(angle: float, launchPower: int) -> void:
	velocity += (Vector2.from_angle(angle) * launchPower)


func _on_player_1_player_two_loaded(answer: bool) -> void:
	loadedInCannon = answer
