extends Node
var clean_progress = Variablemanager.clean_progress
const clean_goal = 100.0
var anger_meter = Variablemanager.anger_meter
const anger_threshold = 10.0
var game_running = false
var game_started = Variablemanager.started
var minigames = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	$mainSceneHud/restart.hide()
	$mainSceneHud/youwin.hide()
	$mainSceneHud/CleanBar.value = clean_progress
	$mainSceneHud/AngerBar.value = anger_meter
	#$angerincrement.start()
func _on_cleaning(amount: float):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (clean_progress > clean_goal):
		game_over()
	$mainSceneHud/CleanBar.value = clean_progress
	$mainSceneHud/AngerBar.value = anger_meter
	
	
	#launch a minigame here
	if (anger_meter >= anger_threshold):
		Variablemanager.anger_meter = anger_meter
		Variablemanager.clean_progress = clean_progress
		get_tree().change_scene_to_file("res://minigames/bubbleRide!/bubble_ride_main.tscn")
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
	$angerincrement.start()
	gameHud()
	
func gameHud():
	$Sponge.show()
	$character.show()
	$mainSceneHud/AngerBar.show()
	$mainSceneHud/CleanBar.show()
	$mainSceneHud/Instructions.hide()
	$mainSceneHud/StartButton.hide()
	
	
func game_over():
	$Sponge.hide()
	$mainSceneHud/CleanBar.hide()
	game_running = false
	$mainSceneHud/restart.show()
	$mainSceneHud/youwin.show()
	
	
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
	if (anger_meter <= anger_threshold && game_running && $Sponge.mouse_speed > 1500):
		anger_meter += 1.0
