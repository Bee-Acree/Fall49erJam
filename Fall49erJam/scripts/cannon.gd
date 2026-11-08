extends CharacterBody2D

signal blast(angle, playerTwoLoadedInCannon)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var playerTwoLoaded : bool = false

func _physics_process(_delta: float) -> void:
	var localCursorPosition = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
	var cursorPosition = global_position + localCursorPosition
	$Sprite2D.look_at(cursorPosition)
	if Input.get_joy_axis(0, JOY_AXIS_TRIGGER_RIGHT) >= .9:
		
		# print("LeftRight: %f    UpDown: %f" % [localCursorPosition.x, localCursorPosition.y])
		
		if cursorPosition - global_position != Vector2.ZERO:
			print(Input.get_joy_name(0) + "poop")
			print(Input.get_joy_name(1) + "fart")
			blast.emit(get_angle_to(cursorPosition) + PI, playerTwoLoaded)

func load_player_two() -> void:
	playerTwoLoaded = true
