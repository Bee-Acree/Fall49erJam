extends RigidBody2D

@export var airSpeed := 5

func _physics_process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		constant_force = Vector2.ZERO
		return
	var moveAxis = (Vector2(Input.get_axis("LeftL", "RightL"), 0)) * airSpeed * delta
	apply_central_impulse(moveAxis)

func _on_cannon_blast(angle: Variant) -> void:
	set_axis_velocity(Vector2.from_angle(angle) * 500)
