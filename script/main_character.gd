extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var Sprite_2D = $Sprite2D

func _physics_process(delta):
	# Handle animation states
	if abs(velocity.x) > 1:
		Sprite_2D.animation = "running"
	else:
		Sprite_2D.animation = "default"

	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		Sprite_2D.animation = "jumping"

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement input
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()

	# Flip sprite based on direction
	Sprite_2D.flip_h = velocity.x < 0
