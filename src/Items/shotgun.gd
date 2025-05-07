extends Node2D

@onready var label = $Label

var PlayerIsNear = false

func _ready():
	label.visible = false

func _input(event):
	if PlayerIsNear == true and event.is_action_pressed("interface_with"):
		equip()

func _on_enter_area_body_entered(body):
	if body and body.name == "Player":
		label.visible = true
		PlayerIsNear = true


func _on_enter_area_body_exited(body):
	if body and body.name == "Player":
		label.visible = false
		PlayerIsNear = false
		
func equip():
	if RunState.playerItemsList.find("shotgun") == -1:
		$"../../../../Audio/SFX".play()
		RunState.playerItemsList.append("shotgun")
		queue_free()

