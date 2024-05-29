extends Node
@onready var score_label = $Scorelabel
var score = 0
@onready var PLAYER = preload("res://Scenes/player.tscn")
@onready var SLIME = preload("res://Scenes/slime.gd")

signal player_has_died(flag)

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins"

func _on_slime_killed_player():
	print ("slime death")
	const flag: int = 1
	emit_signal("player_has_died", flag)

func _on_killzone_player_death():
	print ("fell off")
	const flag: int = 2
	emit_signal("player_has_died", flag)
