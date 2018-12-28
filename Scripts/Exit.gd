extends ColorRect

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


func _on_Area2D_body_entered(body):
	#Sprawdzenie po prostu czy jest node po nazwie z walizka
	if body.has_node("briefcase") and body.has_node("folder") :
		print("you have a stole everything")
		get_tree().change_scene("res://Scenes/VictoryScreen.tscn")
