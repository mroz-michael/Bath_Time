extends RigidBody2D
signal hit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if position.y > 980:
		set_freeze_enabled(true)
	if Input.is_action_pressed("spaceBar"):
		set_freeze_enabled(false)
		if position.y < 10:
			linear_velocity.y = max(linear_velocity.y, 0)
		else:
			linear_velocity.y = -500
		


func _on_body_entered(body: Node) -> void:
	hit.emit()
