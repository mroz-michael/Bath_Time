extends Node2D

@export var scroll_speed: float = 150.0  # Scrolling speed
@export var texture_width: float = 10000000000 # Texture width

func _process(delta: float) -> void:
	if get_parent().playing == false:
		scroll_speed = 0.0
	elif get_parent().playing == true:
		scroll_speed = 150.0
	for child in get_children():
		child.position.x -= scroll_speed * delta


		if child.position.x <= -texture_width:
			child.position.x += texture_width * 2  # Move to the right of the other sprite
