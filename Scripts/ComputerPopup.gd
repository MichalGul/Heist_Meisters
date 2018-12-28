extends Popup

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_text(combination):
	$RichTextLabel.bbcode_text = "Will you stop fortetting combination code? I've set it to  " + PoolStringArray(combination).join("")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
