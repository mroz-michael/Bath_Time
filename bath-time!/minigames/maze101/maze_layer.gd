extends TileMapLayer

var timer = 0
var mazeScore = 0.0

func _ready() -> void:
	$player/ColorRect.hide()
	$player/exit.hide()
	$player/winTxt.hide()

func _on_character_body_2d_hit():
	$player/exit.show()
	$player/winTxt.show()
	$player/ColorRect.show()
	$winbody.hide()
	$winbody2.hide()
	$player/timerTxt.hide()
	$player/Timer.stop()
	
	# Debugging purposes, make sure the timer stops.
	#print("The timer is: ", timer)

func _on_timer_timeout():
	timer += 1
	$player/timerTxt.text = str(timer)

func _on_exit_pressed() -> void:
	if (timer < 10):
		mazeScore = 15
	elif (timer >= 10 && timer < 20):
		mazeScore = 10
	elif (timer >= 20 && timer < 30):
		mazeScore = 7.5
	elif (timer >= 30):
		mazeScore = 2.5
	if (Variablemanager.gameCounter < len(Variablemanager.minigames)):
		Variablemanager.gameCounter += 1
	Variablemanager.anger_meter = Variablemanager.anger_meter - mazeScore
	Variablemanager.globalscore += mazeScore
	get_tree().change_scene_to_file("res://main.tscn")

func _on_start_pressed():
	$player/instructions.hide()
	$player/start.hide()
	$player/Timer.start()
	$player/AudioStreamPlayer.play()
	
