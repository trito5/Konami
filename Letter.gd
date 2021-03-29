extends Node2D


func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(player):
	var numberOfArrow = str(get_name()[5])
	var nameOfNode = "grey" + numberOfArrow
	get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node(nameOfNode).set_deferred("visible", true)
	player.takeArrow(numberOfArrow)
	queue_free()
