extends RigidBody2D

@export var maxCooldown : float = 90
@export var maxDuration : float = 60
var cooldown = 0
var duration = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if duration > 0:
		collision_layer = 2
		collision_mask = 12
		duration -= 1
	else:
		collision_layer = 0
		collision_mask = 0
		if cooldown == 0:
			visible = false
			return
		cooldown -= 1

func _physics_process(delta: float) -> void:
	pass

func ability_one() -> void:
	if cooldown > 0:
		return
	
	visible = true
	duration = maxDuration
	cooldown = maxCooldown
