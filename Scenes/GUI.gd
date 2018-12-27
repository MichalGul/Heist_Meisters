extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_disguising(disguise_number):
	$DisguiseContainer/VBoxContainer/DisguiseDisplay.update_disguises(disguise_number)
