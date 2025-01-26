extends Node
@export var obstacle_scene: PackedScene
var score = 0
var weightedScore = 0.0
var playing = false
signal incrementScore(second: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$exitGame.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	score = 0
	playing = true
	$StartTimer.start()
	$background.scroll_speed = 150.0
	$music.play()
	
func game_over() -> void:
	playing = false
	$BubblePack.hide()
	$bubbleridehud.show_game_over()
	$ScoreTimer.stop()
	$ObstacleTimer.stop()
	$background.scroll_speed = 0.0
	$exitGame.show()
	
	


func _on_start_timer_timeout() -> void:
	print("here?")
	$ScoreTimer.start()
	$ObstacleTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	Variablemanager.obstaclespeed -= 0.3
	incrementScore.emit(1)
	


func _on_obstacle_timer_timeout() -> void:
	print("bing!")
	print("score: ", score)
	var obstacle = obstacle_scene.instantiate()
	
	var obstacle_spawn_location = $obstacleSpawner/spawnlocation
	obstacle_spawn_location.progress_ratio = randf()	
	obstacle.position = obstacle_spawn_location.position
	obstacle.rotation = randf_range(-PI/4, PI/4)
	add_child(obstacle)




func _on_obstacle_obstacle_hit() -> void:
	game_over()
	print("test")


func _on_bubbleridehud_start_game() -> void:
	new_game()


func _on_exit_game_pressed() -> void:
	if (score > 30):
		weightedScore = 15.0
	elif (score > 20 && score <= 30.0):
		weightedScore = 7.5
	elif (score > 10 && score <= 20):
		weightedScore = 5.0
	else:
		weightedScore = 3.0
	if (Variablemanager.gameCounter < len(Variablemanager.minigames)):
		Variablemanager.gameCounter += 1
	Variablemanager.anger_meter = Variablemanager.anger_meter - weightedScore
	Variablemanager.obstaclespeed = -10.0
	Variablemanager.globalscore += weightedScore
	get_tree().change_scene_to_file("res://main.tscn")
