extends Control

@onready var score_counter = $container/score_container/score_counter as Label

func _ready():
	score_counter.text = str("%06d" % Globals.score)

func _process(delta):
	score_counter.text = str("%06d" % Globals.score)
