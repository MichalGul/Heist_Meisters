extends Node


func generate_combination(length):
	var combination = []
	for number in range(length):
		randomize()
		combination.append(randi() % 10)
	return combination


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
