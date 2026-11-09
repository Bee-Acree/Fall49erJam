extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("alive")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	if body.collision_layer == 8:
		queue_free()
