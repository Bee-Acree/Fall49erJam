extends CharacterBody2D

signal blast(angle, playerTwoLoadedInCannon)

@export var maxCooldown : int = 30

var cooldown : int = 0
var playerTwoLoaded : bool = false

func _process(_delta: float) -> void:
	if Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) < -0.2:
		$Sprite2D.flip_v = true
	elif Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) > 0.2:
		$Sprite2D.flip_v = false
	
	cooldown -= 1
	cooldown = clamp(cooldown, 0, maxCooldown)

func _physics_process(_delta: float) -> void:
	var localCursorPosition = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
	var cursorPosition = global_position + localCursorPosition
	$Sprite2D.look_at(Vector2(cursorPosition.x - $Sprite2D.offset.x, cursorPosition.y - $Sprite2D.offset.y))
	if Input.get_joy_axis(0, JOY_AXIS_TRIGGER_RIGHT) >= .9:
		
		# print("LeftRight: %f    UpDown: %f" % [localCursorPosition.x, localCursorPosition.y])
		
		if cooldown <= 0 and cursorPosition - global_position != Vector2.ZERO and (Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) > 0.2 or Input.get_joy_axis(0, JOY_AXIS_RIGHT_X) < -0.2 or Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y) > 0.2 or Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y) < -0.2):
			print(Input.get_joy_name(0) + "poop")
			print(Input.get_joy_name(1) + "fart")
			blast.emit(get_angle_to(cursorPosition) + PI, playerTwoLoaded)
			cooldown = maxCooldown

func load_player_two() -> void:
	print("Cannon: player 2 loaded")
	playerTwoLoaded = true
