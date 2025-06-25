extends Area2D
@onready var game_manger = %GameManger


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		queue_free()
		game_manger.add_point()
		
