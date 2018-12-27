extends ItemList

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func update_disguises(number):
	clear()
	for i in range(number):
		add_icon_item(load(Global.box_sprite),false) # zamiast ręcznego dodawania itemow mozna zrobic tak 
		#w ogole doodawanie rzeczy przez sciezki jest chyba modne i dobre :P
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
