extends "res://Scripts/Character.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motion = Vector2()


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	update_motion(delta)
	move_and_slide(motion)
	
func update_motion(delta):
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = clamp((motion.y + SPEED), MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0 , FRICTION)	#slow down player over FRICTION time
			
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = clamp((motion.x + SPEED), MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
	else:
		motion.x = lerp(motion.x, 0 , FRICTION)	
		