extends "res://Scripts/Character.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motion = Vector2()
var torch_on = true

func _ready():
	Global.Player = self

func _process(delta):
#	if is_colliding():
#		if get_collider().is_in_group("Walls"):
#    	print("Player has died")
	update_motion(delta)
	move_and_slide(motion)


#func _input(event):
#	if Input.is_action_just_pressed("turn_torch"):
#		toggle_torch()
#
#func toggle_torch():
#	torch_on = !torch_on
#	$Torch.enabled = torch_on
	
func update_motion(delta):
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = clamp((motion.y + SPEED),0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0 , FRICTION)	#slow down player over FRICTION time
			
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		