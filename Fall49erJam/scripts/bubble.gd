extends Area2D

@export var maxCooldown : float = 90
@export var maxDuration : float = 60
var cooldown = 0
var duration = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if duration > 0:
		collision_layer = 2
		collision_mask = 12
		duration -= 1
	else:
		collision_layer = 0
		collision_mask = 0
		$Sprite2D.visible = false
		cooldown -= 1

func _physics_process(_delta: float) -> void:
	pass

func ability_one() -> void:
	print("bubble: ability one")
	if cooldown > 0:
		print("bubble: ability one cooldown above 0")
		return
	
	print("bubble: ability one success!")
	$Sprite2D.visible = true
	duration = maxDuration
	cooldown = maxCooldown + maxDuration
