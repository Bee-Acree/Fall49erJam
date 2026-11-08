extends RigidBody2D

@export var maxCooldown : float = 90
var cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown -= 1
	cooldown = clamp(cooldown, 0, maxCooldown)

func _physics_process(delta: float) -> void:
	pass

func ability_one() -> void:
	if cooldown > 0:
		return
	
	cooldown = maxCooldown
