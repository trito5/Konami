extends Node2D

var allowContinue = false
var isShowingCredits = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$instructions1/RichTextLabel.set_deferred("visible", false)
	$instructions1/RichTextLabel.visible_characters = 0

func _physics_process(delta):
	
	if Input.is_action_just_pressed("credits"):
		if not isShowingCredits:
			isShowingCredits = true
			$Credit3.set_deferred("visible", true)
			$instructions1.set_deferred("visible", false)
			$Instructions2.set_deferred("visible", false)
			$instructions1/AnimationPlayer.stop()
			$Instructions2/AnimationPlayer2.stop()
			allowContinue = false
		else:
			$instructions1/AnimationPlayer.seek(0)
			$instructions1/AnimationPlayer.play("instructions1")
			$instructions1.set_deferred("visible", true)
			$instructions1/RichTextLabel.set_deferred("visible", true)
			$Credit3.set_deferred("visible", false)
			$instructions1/AnimationPlayer.play()
			isShowingCredits = false
			allowContinue = true
	
	if not isShowingCredits:
		if allowContinue and Input.is_action_just_pressed("jump"):
			$instructions1.set_deferred("visible", false)
			$Instructions2/AnimationPlayer2.play("instructions2")
			$Instructions2.set_deferred("visible", true)
			allowContinue = false
	
	if Input.is_action_just_pressed("play"):
		get_tree().change_scene("res://World.tscn")

func setAllowContinue(inputBool):
	allowContinue = inputBool


func _on_Timer_timeout():
	$TitelMusic.play()
