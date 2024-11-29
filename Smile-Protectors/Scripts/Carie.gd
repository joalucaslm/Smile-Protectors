extends CharacterBody2D

var health = 3
var scores = 100

# Defina os jogadores com caminhos corretos
@onready var playerManha = get_node_or_null("/root/noManha/cafeDaManha/player")
@onready var playerAlmoco = get_node_or_null("/root/noAlmoco/almoco/player")
@onready var playerJantar = get_node_or_null("/root/noJantar/jantar/player")

# Para armazenar qual fase está ativa
var active_phase = "manha"

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	# Atualize a fase ativa com base na pontuação
	if Globals.score < 101:
		active_phase = "manha"
	elif Globals.score > 100 and Globals.score < 300:
		active_phase = "almoco"
	elif Globals.score >= 300:
		active_phase = "jantar"

	# Execute a lógica da fase ativa
	match active_phase:
		"manha":
			if playerManha:
				_physics_process_phase(delta, playerManha)
		"almoco":
			if playerAlmoco:
				_physics_process_phase(delta, playerAlmoco)
		"jantar":
			if playerJantar:
				_physics_process_phase(delta, playerJantar)

func _physics_process_phase(delta, player):
	# Calcula a direção para o jogador e aplica movimento
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 30.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()

	if health == 0:
		queue_free()
		Globals.score += scores
		print(Globals.score)

		# Adiciona a explosão de fumaça
		const SMOKE_SCENE = preload("res://Assets Smile Protectors/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
