extends Area2D

var travalled_distance = 0

func _physics_process(delta):
	const SPEED = 100
	const RANGE = 50
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travalled_distance += SPEED * delta
	if travalled_distance > RANGE: 
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
