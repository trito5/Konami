extends KinematicBody2D

const UP = Vector2(0,-1)
const SPEED = 150
const DISTANCE = 800
const DELTACONST = 80

var motion = Vector2()
var shouldShoot = false
var shotDistance = 0
var direction = 1

func _ready():
	pass
	
func _physics_process(delta):
	if shouldShoot:
		motion.x = SPEED * direction * delta * DELTACONST
		var velocity = move_and_slide(motion)

func shot(facing_right, position, cheatMegaShot):
	if not shouldShoot:
		if facing_right:
			direction = 1
		else:
			direction = -1
		var offset = Vector2(direction * 9, 1)
		self.global_position = position + offset
		shouldShoot = true
		if cheatMegaShot:
			$Sprite.scale.x = 7
			$Sprite.scale.y = 7
			
		self.set_deferred("visible", true)
		$shotAudio.play()
		$ShotTimer.start()


func _on_ShotTimer_timeout():
	shouldShoot = false
	self.set_deferred("visible", false)
	self.global_position = Vector2.ZERO


func _on_StaticBody2D_body_entered(mob):
	$EnemyHit.play()
	mob.queue_free()
