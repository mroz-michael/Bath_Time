extends Node
var clean_progress = 0
const clean_goal = 100
var anger_meter = 2.5
const anger_threshold = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	$mainSceneHud/CleanBar.value = clean_progress
	$mainSceneHud/AngerBar.value = anger_meter
	
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
		#get_tree().change_scene_to_file("res://minigames/test_minigame/node.tscn")
		pass

func new_game():
	$Sponge.hide()
	$character.hide()
	$mainSceneHud/AngerBar.hide()
	$mainSceneHud/CleanBar.hide()

func start_game():
	clean_progress = 0
	anger_meter = 2.5
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
	
#this function increments the player's cleaning progress
func _on_sponge_cleaning(amount: float) -> void:
	clean_progress += amount
	#print(clean_progress)
	
#this function increments the anger meter
func _on_sponge_anger(amount: float) -> void:
	anger_meter += amount
	print(anger_meter)


func _on_main_scene_hud_button_pressed() -> void:
	start_game()
