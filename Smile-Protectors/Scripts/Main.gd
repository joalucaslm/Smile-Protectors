extends Node

func _ready():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	

func spawn_mob():
	var CARIE = preload("res://Cenas/carie.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	CARIE.global_position = %PathFollow2D.global_position
	add_child(CARIE)

