extends Area2D
signal hit
var mouse_speed = 0.0
var mouse_coordDiff = 0.0
var mouse_prevPos = Vector2.ZERO
var is_cleaning = false
@export var score_multiplier = 300
var real_score_multiplier = score_multiplier * 250
signal cleaning(amount: float)
signal anger(amount: float)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	position = mouse_position
	
	#the following code block keeps track of mouse speed
	mouse_coordDiff = (mouse_position - mouse_prevPos) / delta
	mouse_prevPos = mouse_position
	mouse_speed = mouse_coordDiff.length()
	#print("speed: ", mouse_speed)
	if (is_cleaning && (mouse_speed > 1500)):
		hit.emit()
		cleaning.emit(mouse_speed / real_score_multiplier)
		anger.emit(1)


func _on_body_entered(body: Node2D) -> void:
	#emit a hit when the sponge is touching body
	is_cleaning = true
	print("entered!")
		
		
	#$CollisionShape2D.set_deferred("disabled", true)


func _on_body_exited(body: Node2D) -> void:
	is_cleaning = false
	print("im not cleaning")# Replace with function body.
