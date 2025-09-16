extends Node2D

@onready var main = get_tree().current_scene
@onready var projectile = load("res://scenes/projectile.tscn")
@onready var cooldown_timer: Timer = $cooldown

@export var cooldown : float

func _ready() -> void:
	if cooldown != 0:
		cooldown_timer.wait_time = cooldown
		cooldown_timer.start()

func _physics_process(_delta: float) -> void:
	#rotation_degrees += 50 * delta
	pass

func shoot():
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.spawnPosition = global_position - Vector2(20, 0).rotated(rotation)
	instance.spawnRotation = rotation
	instance.zIndex = z_index - 1
	main.add_child.call_deferred(instance)

func _on_cooldown_timeout() -> void:
	shoot()

func interact():
	queue_free()
