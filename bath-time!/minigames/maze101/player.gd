extends CharacterBody2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	self.velocity = velocity
	var collision = move_and_slide()
	
	# Check for collision with the goal
	if collision:
		for i in range(get_slide_collision_count()):
			var collision_info = get_slide_collision(i)
			var collider = collision_info.get_collider()
			
			if collider.is_in_group("goal"):
				emit_signal("hit")
