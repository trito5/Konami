extends Area2D


func _ready():
	pass # Replace with function body.


func _on_DeadArea_body_entered(player):
	player.die()
