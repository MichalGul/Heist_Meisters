extends "res://Scripts/Character.gd"

var motion =Vector2()
var vision_change_on_cooldown = false
enum vision_mode {DARK, NIGHTVISION}

export var disguises = 3 # how many disguises do you start with
export var disguise_duration = 5 # how long a disguise can last
export var disguise_slowdown = 0.25

var disguised = false
var velocity_multiplier = 1


signal disguising

func _ready():
	Global.Player = self
	vision_mode = DARK
	$Timer.wait_time = disguise_duration
	reveal()
	#2 metody podczenia GUI z informacje o ilosci przebran : przez sygnal lub przez wolanie grupy
	update_dusguise_display()
	
	

func _process(delta):
	#face label always up
	update_motion(delta)
	move_and_slide(motion * velocity_multiplier)
	if disguised:
		update_timer_label()

func update_timer_label():
	$Label.rect_rotation = -rotation_degrees
	$Label.text = str($Timer.time_left).pad_decimals(2)

func update_motion(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = clamp((motion.y - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = clamp((motion.x - SPEED), -MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

func _input(event):
	if Input.is_action_just_pressed("ui_vision_mode_change") and not vision_change_on_cooldown:
		cycle_vision_mode()
		$VisionModeTimer.start()
		vision_change_on_cooldown = true
		
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()
		print("Poof")
		
func cycle_vision_mode():	
	if vision_mode == DARK:
		get_tree().call_group("interface","NightVision_mode")
		get_tree().call_group("CompDoor","NightVision_mode")		
		vision_mode = NIGHTVISION
	elif vision_mode == NIGHTVISION:
		get_tree().call_group("interface","DarkVision_mode")
		get_tree().call_group("CompDoor","NightVision_mode")	
		vision_mode = DARK
		
func toggle_disguise():
	if disguised:
		reveal()
	elif disguises > 0:
		disguise()
		
func reveal():
	$Sprite.texture = load(Global.player_sprite)
	$Light2D.texture = load(Global.player_sprite)
	collision_layer = 1
	$LightOccluder2D.occluder = load(Global.player_occluder)
	$Label.visible = false
	disguised = false	
	velocity_multiplier = 1

func disguise():
	$Label.visible = true	
	$Sprite.texture = load(Global.box_sprite)
	$Light2D.texture = load(Global.box_sprite)	
	collision_layer = 16	
	$LightOccluder2D.occluder = load(Global.box_occluder)
	
	disguised = true
	$Timer.start()
	velocity_multiplier = disguise_slowdown
	disguises -=1
	#2 metody do update GUI przez sygnał lub przez grupe w ktorej jest 1 element
	update_dusguise_display()


func update_dusguise_display():
	get_tree().call_group("DisguiseDisplay", "update_disguises", disguises)
	#Update kontrolki item list
	#emit_signal("disguising", disguises) # metoda sygnalu wylacza podlaczenia w scenie z levele i mania skryptu na GUI node
	#rozwiazanie z grupami jest szybsze ale jak bedziemy mielu duzo takich wywolan w grze to moze zwolnić

func _on_VisionModeTimer_timeout():
	vision_change_on_cooldown = false

func collect_briefcase():
	#Zamiast trzymania jakiejs zmiennej to gdy mamy walizke dodajemy pusty node i potem przy wyjsciu sprawdzimy czy Player ma ten node
	var loot = Node.new()
	loot.set_name("briefcase") # dodanie noda gdy podniesie sie walizke
	add_child(loot)
	get_tree().call_group("Loot", "collect_loot", "briefcase")
	
func collect_folder():
	#Zamiast trzymania jakiejs zmiennej to gdy mamy walizke dodajemy pusty node i potem przy wyjsciu sprawdzimy czy Player ma ten node
	var loot = Node.new()
	loot.set_name("folder") # dodanie noda gdy podniesie sie walizke
	add_child(loot)
	get_tree().call_group("Loot", "collect_loot", "folder")
	
