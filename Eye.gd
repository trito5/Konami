extends KinematicBody2D

var player
var SPEED = 1800
var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	player = null


func _physics_process(delta):
	if player:
		motion = position.direction_to(player.position) * SPEED * delta
		if motion.x < 0 and motion.y < 0:
			$AnimatedSprite.play("leftUp")
		elif motion.x < 0 and motion.y > 0:
			$AnimatedSprite.play("leftDown")
		elif motion.x > 0 and motion.y > 0:
			$AnimatedSprite.play("rightDown")
		elif motion.x > 0 and motion.y < 0:
			$AnimatedSprite.play("rightUp")
		else:
			$AnimatedSprite.play("idle")
	else:
		motion = Vector2.ZERO
		$AnimatedSprite.play("idle")
		
	
	var velocity = move_and_slide(motion)


func _on_Area2D_body_entered(player):
	player.trigger_hit(self.name)


func _on_Area2D2_body_entered(body):
	player = body


func _on_Area2D2_body_exited(body):
	player = null
