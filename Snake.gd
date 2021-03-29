extends KinematicBody2D

var SPEED = 10
var DELTACONST = 100
const ZONE = 3000
var motion = Vector2()
var direction = 1
var moved = 0

func _ready():
	$SnakeAnimation.play("idle")
	
func _physics_process(delta):
	moved += motion.x
	if moved > ZONE or moved < ZONE * -1:
		moved = 0
		direction = -direction
	
	if direction > 0:
		$SnakeAnimation.scale.x = -1
	else:
		$SnakeAnimation.scale.x = 1
		
	motion.x = SPEED * direction * delta * DELTACONST
	var velocity = move_and_slide(motion)

func _on_Area2D_body_entered(player):
	var name = self.name.substr(0, 5)
	player.trigger_hit(name)



func _on_Area2D2_body_entered(body):
	SPEED = 40
	$SnakeAnimation.play("attack")


func _on_Area2D2_body_exited(body):
	SPEED = 10
	$SnakeAnimation.play("idle")
