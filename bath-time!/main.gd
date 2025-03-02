extends Node
var clean_progress = Variablemanager.clean_progress
const clean_goal = 100.0
var anger_meter = Variablemanager.anger_meter
const anger_threshold = 10.0
var game_running = false
var game_started = Variablemanager.started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$title.show()
	new_game()
	
	$mainSceneHud/FinalScore.hide()
	$mainSceneHud/TotalScore.show()
	$mainSceneHud/TotalScore.text = "Score: " + str(Variablemanager.globalscore)
	$mainSceneHud/restart.hide()
	$mainSceneHud/youwin.hide()
	$mainSceneHud/CleanBar.value = clean_progress
	$mainSceneHud/AngerBar.value = anger_meter
	print("length: ", len(Variablemanager.minigames))
	if (Variablemanager.gameCounter >= len(Variablemanager.minigames)):
		Variablemanager.gameCounter = 0
	print(Variablemanager.gameCounter)
func _on_cleaning(amount: float):
	pass


func _process(delta: float) -> void:
	if (clean_progress > clean_goal):
		game_over()
	$mainSceneHud/CleanBar.value = clean_progress
	$mainSceneHud/AngerBar.value = anger_meter
	if Variablemanager.mouse_speed > 10000:
		$character/AnimatedSprite2D.animation = "wince"
		$winceTimer.start()
	
	
	#launch a minigame here
	if (anger_meter >= anger_threshold):
		Variablemanager.anger_meter = anger_meter
		Variablemanager.clean_progress = clean_progress
		Variablemanager.gamesPlayed += 1
		get_tree().change_scene_to_file(Variablemanager.minigames[Variablemanager.gameCounter])
		#pass
func new_game():
	$Sponge.hide()
	$character.hide()
	$mainSceneHud/AngerBar.hide()
	$mainSceneHud/CleanBar.hide()

func start_game():
	Variablemanager.started = true
	game_running = true
	$character/AnimatedSprite2D.play()
	$duck.play()
	$music.play()
	$sprinkle.play()
	$angerincrement.start()
	gameHud()
	
func gameHud():
	$Sponge.show()
	$character.show()
	$mainSceneHud/AngerBar.show()
	$mainSceneHud/CleanBar.show()
	$mainSceneHud/Instructions.hide()
	$mainSceneHud/StartButton.hide()
	$title.hide()
	$tubfrontanim.play()
	
	
func game_over():
	$Sponge.hide()
	$duck.stop()
	$mainSceneHud/CleanBar.hide()
	game_running = false
	#Variablemanager.globalscore = Variablemanager.globalscore / Variablemanager.gamesPlayed
	$mainSceneHud/FinalScore.text = "Final Score\n" + str(Variablemanager.globalscore)
	$mainSceneHud/FinalScore.show()
	$mainSceneHud/restart.show()
	$mainSceneHud/youwin.show()
	$tubfrontanim.stop()
	$sprinkle.stop()
	
	
#this function increments the player's cleaning progress
func _on_sponge_cleaning(amount: float) -> void:
	if (game_running):
		clean_progress += amount
	#print(clean_progress)
	
#this function increments the anger meter
#func _on_sponge_anger(amount: float) -> void:
	#if (anger_meter <= anger_threshold && game_running):
		#$angerincrement.start()
	#else:
		#$angerincrement.stop()


func _on_main_scene_hud_button_pressed() -> void:
	start_game()
	
func set_progress(clean: float, angry: float):
	clean_progress = clean
	anger_meter = anger_threshold


func _on_angerincrement_timeout() -> void:
	if (anger_meter <= anger_threshold && game_running):
		anger_meter += 1.0


func _on_wince_timer_timeout() -> void:
	$character/AnimatedSprite2D.animation = "idle"
