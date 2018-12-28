extends NinePatchRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	visible = false

func collect_loot(item):
	visible = true
	if item == "briefcase":
		$LootList.add_icon_item(load(Global.briefcase_sprite), false)
	elif item == "folder":
		$LootList.add_icon_item(load(Global.folder_sprite), false)
		