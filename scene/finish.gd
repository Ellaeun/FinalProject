extends Area2D

@export var total_items_needed: int = 13
@onready var game_manger: Node = %GameManger
@onready var congrats_label: Label = %CongratsLabel
@onready var retry_label: Label = %RetryLabel
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"

var start_position: Vector2  

func _ready():
	congrats_label.visible = false
	retry_label.visible = false

	if character_body_2d:
		start_position = character_body_2d.global_position  
	else:
		print("❌ CharacterBody2D not found in _ready()")

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		var collected = game_manger.points

		if collected >= total_items_needed:
			show_congratulations()
		else:
			show_retry()

func show_congratulations():
	congrats_label.text = "🎉 Congratulations! You got all items!"
	congrats_label.visible = true
	await get_tree().create_timer(3.0).timeout
	congrats_label.visible = false
	

func show_retry():
	retry_label.text = "⚠️ Didn't collect all! Try again..."
	retry_label.visible = true

	if character_body_2d:
		character_body_2d.velocity = Vector2.ZERO
		character_body_2d.global_position = start_position
		print("✅ Player moved back to start")
	else:
		print("❌ CharacterBody2D is NULL!")

	# Optional: Hide the retry label after 1.5 seconds 
	await get_tree().create_timer(1.5).timeout
	retry_label.visible = false
