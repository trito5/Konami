extends KinematicBody2D

const SPEED = 15
const ZONE = 3000
const DELTACONST = 100
var motion = Vector2()
var direction = 1
var moved = 0

func _ready():
	pass
	
func _physics_process(delta):
	moved += motion.x
	if moved > ZONE or moved < ZONE * -1:
		moved = 0
		direction = -direction
	
	if direction > 0:
		$MosquitoAnimation.scale.x = -1
	else:
		$MosquitoAnimation.scale.x = 1
		
	motion.x = SPEED * direction * delta * DELTACONST
	var velocity = move_and_slide(motion)

func _on_Area2D_body_entered(player):
	player.trigger_hit(self.name)
