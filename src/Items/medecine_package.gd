extends Node2D

@onready var label = $Label

var PlayerIsNear = false

func _ready():
	add_to_group("items")
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
	if LevelState.playerItemsList.find("medecin_package") == -1:
		$"../../../../Audio/SFX".play()
		LevelState.playerItemsList.append("medecin_package")
		queue_free()

