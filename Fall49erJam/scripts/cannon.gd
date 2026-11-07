extends CharacterBody2D

signal blast(angle)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(_delta: float) -> void:
	var cursorPosition = global_position + Vector2(Input.get_axis("LeftR", "RightR"), Input.get_axis("UpR", "DownR"))
	$Sprite2D.look_at(cursorPosition)
	if Input.is_action_pressed("Ability1"):
		print("LeftRight: %f    UpDown: %f" % [Input.get_axis("LeftR", "RightR"), Input.get_axis("UpR", "DownR")])
		if cursorPosition - global_position != Vector2.ZERO:
			blast.emit(get_angle_to(cursorPosition) + PI)
