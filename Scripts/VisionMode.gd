extends CanvasModulate

const DARK = Color("0f1d53")
const NIGHTVISION = Color("2bc92b")



func _ready():
	add_to_group("interface")
	color = DARK
	get_tree().call_group("label", "hide")
	
func NightVision_mode():
		inform_npcs("NightVision_mode")
		color = NIGHTVISION
		$AudioStreamPlayer.stream = load(Global.nightvision_on_sfx)
		play_sfx()
		get_tree().call_group("label", "show")
		
func DarkVision_mode():
		inform_npcs("DarkVision_mode")
		color = DARK
		$AudioStreamPlayer.stream = load(Global.nightvision_off_sfx)
		play_sfx()
		get_tree().call_group("label", "hide")
func play_sfx():
	$AudioStreamPlayer.play()

func inform_npcs(vision_mode):
	#Ten string vision mode to nazwa funkcji ktora znajduje sie w skyptach w grupie
	# "NPC" tutaj jest ona wywolywana
	#Wywolaj funkcje na wszystkich obiektach w danej grupie
	get_tree().call_group("NPC", vision_mode)
