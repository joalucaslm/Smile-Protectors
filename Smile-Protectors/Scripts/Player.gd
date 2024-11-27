extends CharacterBody2D

signal health_depleted

var health = 100.0

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var _friction: float = 0.4
@export var _acceleration: float = 0.8

func _physics_process(_delta: float) -> void:
	_move()
	move_and_slide()
	
	const DAMAGE_RATE = 20.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
	
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"),
	)
	
	if _direction != Vector2.ZERO:
		velocity.x =lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y =lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x =lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y =lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	velocity = _direction.normalized() * _move_speed
	
	

func _die():
	if health == 0:
		get_tree().change_scene_to_file("res://Cenas/perdeu.tscn")
