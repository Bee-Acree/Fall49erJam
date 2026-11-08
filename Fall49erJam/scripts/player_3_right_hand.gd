extends AnimatableBody2D

const SPEED = 300
const DEVICE = 2
const MAX_COOLDOWN = 180
const BULLET_SPEED = 1500

var bulletScene = preload("res://scenes/right_hand_bullet.tscn")
var cooldown = 0


func _physics_process(delta: float) -> void:
	var localCursorPosition = Vector2(Input.get_joy_axis(DEVICE, JOY_AXIS_RIGHT_X), Input.get_joy_axis(DEVICE, JOY_AXIS_RIGHT_Y)) * SPEED * delta
	
	if Input.is_joy_button_pressed(DEVICE, JOY_BUTTON_RIGHT_SHOULDER) and cooldown <= 0:
		$Sprite2D.look_at(localCursorPosition)
		if Input.get_joy_axis(DEVICE, JOY_AXIS_TRIGGER_RIGHT) >= 0.9:
			var currentBullet = bulletScene.instantiate()
			currentBullet.global_position = $BulletPoint.global_position
			var target = $BulletPoint/RayCast2D.target_position + $BulletPoint.global_position
			currentBullet.get_child(1).look_at(target)
			currentBullet.apply_central_impulse(target * BULLET_SPEED)
			cooldown = MAX_COOLDOWN
		return
	
	cooldown -= 1
	cooldown = clamp(cooldown, 0, MAX_COOLDOWN)
	
	if (localCursorPosition.x > 0.2 or localCursorPosition.x < -0.2):
		if (localCursorPosition.y > 0.2 or localCursorPosition.y < -0.2):
			global_position += localCursorPosition
		else:
			global_position.x += localCursorPosition.x
	else:
		if (localCursorPosition.y > 0.2 or localCursorPosition.y < -0.2):
			global_position.y += localCursorPosition.y
