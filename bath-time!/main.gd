extends Node
var clean_progress = 0
var clean_goal = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	$mainSceneHud/CleanBar.value = clean_progress
	
func _on_cleaning(amount: float):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (clean_progress > clean_goal):
		game_over()
	$mainSceneHud/CleanBar.value = clean_progress

func new_game():
	clean_progress = 0
	$Sponge.show()
func game_over():
	$Sponge.hide()
	$mainSceneHud/CleanBar.hide()
func _on_sponge_cleaning(amount: float) -> void:
	clean_progress += amount
	print(clean_progress)# Replace with function body.
	
