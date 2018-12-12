extends "res://Scripts/Character.gd"

const FOV_TOLERANCE = 22
const MAX_DETECTION_RANGE = 600
const RED = Color(1, 0.25, 0.25)
const WHITE = Color(1,1,1)

onready var Player = get_node("/root/Level1/Player") #Make this level neutral

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	if Player_is_in_FOV_TOLERANCE() and Player_is_in_LOS():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
		
	
func Player_is_in_FOV_TOLERANCE():
	var NPC_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.global_position - global_position).normalized()

	if abs(direction_to_Player.angle_to(NPC_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
		print("NPC SEE PLAYER")
	else:
		return false
		

func Player_is_in_LOS():
	var space = get_world_2d().direct_space_state
	#Tutaj robimi customowy raycas z kamery. Jezeli trafi na playara to tru jak na cos innego zdefiniowanegpo w collison mask to false
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	var Player_in_range = distance_to_player < MAX_DETECTION_RANGE
	
	if LOS_obstacle.collider == Player and Player_in_range:
		return true
	else:
		return false
		










		
		
	