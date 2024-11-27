extends CharacterBody2D

var health = 3
var scores = 100

@onready var playerManha = get_node("/root/noManha/cafeDaMnaha/player")
@onready var playerAlmoco = get_node("/root/noAlmoco/almoco/jogador_1")
@onready var playerJantar = get_node("/root/noJantar/jantar/jogador_1")

func _ready():
	%Slime.play_walk()

func _physics_process_manha(delta):
	var direction = global_position.direction_to(playerManha.global_position)
	velocity = direction * 30.0
	move_and_slide()

func _physics_process_almoco(delta):
	var direction = global_position.direction_to(playerAlmoco.global_position)
	velocity = direction * 30.0
	move_and_slide()
	

func _physics_process_jantar(delta):
	var direction = global_position.direction_to(playerJantar.global_position)
	velocity = direction * 30.0
	move_and_slide()


func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		Globals.score += scores
		print(Globals.score)
		
		const SMOKE_SCENE = preload("res://Assets Smile Protectors/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position