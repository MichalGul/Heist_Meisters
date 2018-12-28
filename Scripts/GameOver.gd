extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_TryAgain_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
