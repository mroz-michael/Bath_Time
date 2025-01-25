extends CanvasLayer
signal start_game
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOver.hide()
	$Score.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func show_game_over():
	$GameOver.show()
	
	


func _on_start_button_pressed() -> void:
	start_game.emit()
	$Instructions.hide()
	$Score.show()
	$StartButton.hide()


func _on_bubble_ride_main_increment_score(second: int) -> void:
	score += second
	$Score.text = "Score: " + str(score)
 
