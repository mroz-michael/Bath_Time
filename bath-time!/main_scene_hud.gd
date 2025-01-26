extends CanvasLayer
signal buttonPressed()
signal restartPressed()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	buttonPressed.emit() # Replace with function body.


func _on_restart_pressed() -> void:
	Variablemanager.clean_progress = 0
	Variablemanager.anger_meter = 2.5
	get_tree().change_scene_to_file("res://main.tscn")
