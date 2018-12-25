extends Popup

var combination =[]
var guess = []

signal combination_correct



onready var light = $VSplitContainer/ButtonContainer/ButtonGrid/Light
onready var display = $VSplitContainer/DisplayContainer/Display

func _ready():
	reset_lock()
	connect_buttons()

func connect_buttons():
	""" Conect buttons grid to signals """
	for child in $VSplitContainer/ButtonContainer/ButtonGrid.get_children():
		#Connect buttons and send signal with parameters
		if child is Button:
			child.connect("pressed", self, "_on_Button_pressed", [child.text])
			
func _on_Button_pressed(button):
	
	if button == "OK":
		check_guess()
	else:
		enter(int(button))
		
func check_guess():
	if guess == combination:
		light.texture = load(Global.green_light)
		play_bip_sound("res://SFX/threeTone1.ogg")
		$Timer.start()
	else:
		reset_lock()
		
func play_bip_sound(path_to_sound):
	$AudioStreamPlayer.stream = load(path_to_sound)
	$AudioStreamPlayer.play()
		
func enter(button):
	play_bip_sound("res://SFX/twoTone1.ogg")
	guess.append(button)
	update_display()
	
func reset_lock():
	light.texture = load(Global.red_light)
	display.clear()
	guess.clear()

func  update_display():
	#get  single string from int array
	display.bbcode_text = "[center]" + PoolStringArray(guess).join("") + "[/center]"
	if guess.size() == combination.size():
		check_guess()
	

func _on_Timer_timeout():
	emit_signal("combination_correct")
	print("correct")
	hide()
	reset_lock()
