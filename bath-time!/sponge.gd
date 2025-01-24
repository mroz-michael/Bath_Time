extends Area2D
signal hit
var mouse_speed = 0.0
var mouse_coordDiff = 0.0
var mouse_prevPos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	position = mouse_position
	
	#the following code block keeps track of mouse speed
	mouse_coordDiff = (mouse_position - mouse_prevPos) / delta
	mouse_prevPos = mouse_position
	mouse_speed = mouse_coordDiff.length()
	print("speed: ", mouse_speed)


func _on_body_entered(body: Node2D) -> void:
	#emit a hit when the sponge is touching body
	if (mouse_speed > 500):
		hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
