extends KinematicBody2D

var SPEED = 30
const ZONE = 3000
const DELTACONST = 100
var motion = Vector2()
var direction = 1
var moved = 0

func _ready():
	$AnimatedSprite.play("idle")
	
func _physics_process(delta):
	moved += motion.x
	if moved > ZONE or moved < ZONE * -1:
		moved = 0
		direction = -direction
	
	if direction > 0:
		$AnimatedSprite.scale.x = -1
	else:
		$AnimatedSprite.scale.x = 1
		
	motion.x = SPEED * direction * delta * DELTACONST
	var velocity = move_and_slide(motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(player):
	player.trigger_hit(self.name)


func _on_Area2D2_body_entered(body):
	$AnimatedSprite.play("attack")


func _on_Area2D2_body_exited(body):
	$AnimatedSprite.play("idle")
