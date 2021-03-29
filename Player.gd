extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 350
const ACCELERATION = 10
const DELTACONST = 300

var motion = Vector2()
var facing_right = true
var hearts = 5
var numberOfCheats = 0
var cheatSnake = false
var cheatWalkOnWater = false
var cheatMegaShot = false
var cheatGodMode = false

var up1 = false
var up2 = false
var down1 = false
var down2 = false
var left1 = false
var left2 = false
var right1 = false
var right2 = false
var keyA = false
var keyB = false

var secretCode1 = 0 #down down
var secretCode2 = 0 #<- ->  B
var secretCode3 = 0 #up down -> A (1up. 2left) mega shop
var secretCode4 = 0 # alla utom A
var secretCode5 = 0 #mega shot A + B
var konamiCode = 0

#var cheatSequence = [up1, up2, down1, down2, left1, right1, left2, right2, keyB, keyA]

func _ready():
	pass
	
func _physics_process(delta):
	
#	if Input.is_action_just_pressed("jumpToEnd"):
#		get_tree().get_root().get_node("Global").saveTime($Camera2D/Control/GameTimeText.fetchGameTime())
#		get_tree().change_scene("res://MapCleared.tscn")
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
		
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCELERATION * delta * DELTACONST
		facing_right = true
		if is_on_floor():
			$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCELERATION * delta * DELTACONST
		facing_right = false
		if is_on_floor():
			$AnimationPlayer.play("walk")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE * 60 * delta
			$jump.play()
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("jump")
		elif motion.y > 0:
			$AnimationPlayer.play("falling")
			
	if Input.is_action_just_pressed("attack"):
		get_tree().get_root().get_node("World").get_node("shot").shot(facing_right, self.global_position, cheatMegaShot)
	
	if Input.is_action_just_pressed("CheatUp"):
		if up1:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink1").set_deferred("visible", true)
			$codeBlip.play()
			up1 = false
			secretCode3 += 1
			secretCode4 += 1
			konamiCode +=1
		elif up2:
			$codeBlip.play()
			up2 = false
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink2").set_deferred("visible", true)
			konamiCode +=1
			secretCode4 += 1
			secretCode5 += 1
			
	if Input.is_action_just_pressed("CheatDown"):
		if down1:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink3").set_deferred("visible", true)
			$codeBlip.play()
			secretCode1 += 1
			secretCode4 += 1
			konamiCode += 1
			down1 = false
		elif down2:
			down2 = false
			$codeBlip.play()
			secretCode1 += 1
			secretCode4 += 1
			konamiCode += 1
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink4").set_deferred("visible", true)
	
	if Input.is_action_just_pressed("CheatLeft"):
		if left1:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink5").set_deferred("visible", true)
			$codeBlip.play()
			left1 = false
			secretCode4 += 1
			secretCode2 += 1
			konamiCode +=1
		elif left2:
			left2 = false
			secretCode4 += 1
			secretCode3 += 1
			konamiCode +=1
			$codeBlip.play()
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink7").set_deferred("visible", true)
	
			
	if Input.is_action_just_pressed("CheatRight"):
		if right1:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink6").set_deferred("visible", true)
			$codeBlip.play()
			right1 = false
			secretCode4 += 1
			secretCode2 += 1
			konamiCode += 1
		elif right2:
			right2 = false
			secretCode4 += 1
			konamiCode +=1
			$codeBlip.play()
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink8").set_deferred("visible", true)
	
	if Input.is_action_just_pressed("CheatB"):
		if keyB:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink9").set_deferred("visible", true)
			$codeBlip.play()
			keyB = false
			secretCode2 += 1
			secretCode4 += 1
			konamiCode += 1
			
	if Input.is_action_just_pressed("CheatA"):
		if keyA:
			get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node("pink0").set_deferred("visible", true)
			$codeBlip.play()
			keyA = false
			secretCode5 += 1
			konamiCode +=1
	
	if secretCode1 == 2:
		$unlockCode.play()
		cheatSnake = true
		$Camera2D/Control/TextMessageSnake.set_deferred("visible", true)
		secretCode1 = 0		
		
	if secretCode2 == 3:
		$unlockCode.play()
		cheatWalkOnWater = true
		$Camera2D/Control/TextMessageWater.set_deferred("visible", true)
		secretCode2 = 0
		
	if secretCode3 == 2 or secretCode5 == 2:
		$unlockCode.play()
		cheatMegaShot = true
		$Camera2D/Control/TextMessageShot.set_deferred("visible", true)
		secretCode3 = -1
		secretCode5 = -1
	
	if secretCode4 == 8:
		$unlockCode.play()
		cheatGodMode = true
		$Camera2D/Control/TextMessageGodMode.set_deferred("visible", true)
		secretCode4 = 0
		
	if konamiCode == 10:
		get_tree().get_root().get_node("World").get_node("AudioStreamPlayer").stop()
		$Konami.play()
		konamiCode = 0
		$ClearedTimer.start()
		$Camera2D/Control/GameCleared.set_deferred("visible", true)
		
	
	var velocity = move_and_slide(motion, UP)

func takeArrow(numberOfArrow):
	numberOfCheats += 1
	$takeArrow.play()
	if (numberOfArrow == "1"):
		up1 = true
	elif (numberOfArrow == "2"):
		up2 = true
	elif (numberOfArrow == "3"):
		down1 = true
	elif (numberOfArrow == "4"):
		down2 = true
	elif (numberOfArrow == "5"):
		left1 = true
	elif (numberOfArrow == "6"):
		right1 = true
	elif (numberOfArrow == "7"):
		left2 = true
	elif (numberOfArrow == "8"):
		right2 = true
	elif (numberOfArrow == "9"):
		keyB = true
	elif (numberOfArrow == "0"):
		keyA = true

	
func trigger_hit(nodeName):
	if cheatSnake and nodeName == "Snake" or cheatGodMode:
		pass
	else:
		var nameOfNode = "Heart" + str(hearts)
		get_tree().get_root().get_node("World").get_node("Player").get_node("Camera2D").get_node("Control").get_node(nameOfNode).set_deferred("visible", false)
		hearts = hearts - 1
		$hurt.play()
		
		if hearts == 0:
			self.die()
		

func die():
	self.global_position = Vector2(0, 0)
	$gameOver.play()
	self.reset()
	pass
	
func reset():
	hearts = 5
	$Camera2D/Control/Heart1.set_deferred("visible", true)
	$Camera2D/Control/Heart2.set_deferred("visible", true)
	$Camera2D/Control/Heart3.set_deferred("visible", true)
	$Camera2D/Control/Heart4.set_deferred("visible", true)
	$Camera2D/Control/Heart5.set_deferred("visible", true)

func _on_MessageTimer_timeout():
	$Camera2D/Control/TextMessage.set_deferred("visible", false)
	
func walk_on_water():
	if cheatWalkOnWater:
		$Bounce.play()
		motion.y = -400


func _on_ClearedTimer_timeout():
	get_tree().get_root().get_node("Global").saveTime($Camera2D/Control/GameTimeText.fetchGameTime())
	get_tree().change_scene("res://MapCleared.tscn")
