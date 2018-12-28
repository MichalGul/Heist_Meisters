extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var text

func _ready():
	add_to_group("interface")
	text = get_json()
	update_pointer_position(0)
	$TutorialGUI/Popup.show()

func get_json():
	var file = File.new()
	file.open(Global.tutorial_messages, file.READ)
	var content = file.get_as_text()
	file.close()
	return parse_json(content)

func update_pointer_position(number):
	var pointer = $ObjectivePointer
	var marker = $ObjectiveMarkers.get_child(number)
	#Interpolacja wartosci miedzy jakimis elementami
	$Tween.interpolate_property(pointer, "position", pointer.position, marker.position,
			0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$AudioStreamPlayer.play()
	$TutorialGUI/AnimationPlayer.play("MessageTransition")
	$TutorialGUI/Popup/Label.text = text[str(number)]

func _on_ObjectiveMove_body_entered(body):
	update_pointer_position(1)


func _on_ObjectiveDoor_body_entered(body):
	update_pointer_position(2)


func _on_ObjectiveNightVision_body_entered(body):
	update_pointer_position(3)
	DarkVision_mode()


func _on_Briefcase_body_entered(body):
	update_pointer_position(7)


func _on_Folder_body_entered(body):
	update_pointer_position(4)


func _on_ObjectiveComputer_body_entered(body):
	update_pointer_position(5)


func _on_ObjectiveDoor2_body_entered(body):
	update_pointer_position(6)
	
func NightVision_mode():
	$TutorialGUI/Popup.hide()
	
func DarkVision_mode():
	$TutorialGUI/Popup.show()
