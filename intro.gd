extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func playAudio():
	$AudioStreamPlayer.play()
	
func startInstructions():
	$Titel.set_deferred("visible", true)
	$Titel/instructions1/AnimationPlayer.seek(0)
	$Titel/instructions1/AnimationPlayer.play("instructions1")
	$Titel/instructions1.visible = true
	$Titel/instructions1/RichTextLabel.set_deferred("visible", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
