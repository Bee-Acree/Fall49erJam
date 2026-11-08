extends AnimatableBody2D

const SPEED = 300
const DEVICE = 2

func _physics_process(delta: float) -> void:
	var localCursorPosition = Vector2(Input.get_joy_axis(DEVICE, JOY_AXIS_LEFT_X), Input.get_joy_axis(DEVICE, JOY_AXIS_LEFT_Y)) * SPEED * delta
	
	if (localCursorPosition.x > 0.2 or localCursorPosition.x < -0.2):
		if (localCursorPosition.y > 0.2 or localCursorPosition.y < -0.2):
			global_position += localCursorPosition
		else:
			global_position.x += localCursorPosition.x
	else:
		if (localCursorPosition.y > 0.2 or localCursorPosition.y < -0.2):
			global_position.y += localCursorPosition.y
