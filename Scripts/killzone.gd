extends Area2D

signal player_death

@onready var timer = $Timer
@onready var label = $CanvasLayer/Deathlabel

func _on_body_entered(body):
	Engine.time_scale = 0.5
	timer.start()
	label.set_visible(true)
	player_death.emit()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()



