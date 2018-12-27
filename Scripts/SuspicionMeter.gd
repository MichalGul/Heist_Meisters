extends TextureProgress

var suspicion = 0

export var suspicion_step = 1 # How much suspicion goes up every time we're seen
export var suspicion_dropoff = 0.3 # How fast suspicion falls

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	suspicion -= suspicion_dropoff
	value = suspicion
	suspicion = clamp(suspicion, min_value, max_value)
	if suspicion == max_value:
		end_game()
	#print(max_value)

func player_seen():
	suspicion += suspicion_step

		
func end_game():
	get_tree().quit()