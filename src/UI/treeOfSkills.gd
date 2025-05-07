extends Node2D

var playerIsNear: bool
var gamePaused: bool = false

@onready var treeMenu = $"../../../CanvasLayer/TreeMenu"

func _on_tree_body_entered(body):
	if body.name == "Player":
		$press_e.show()
		playerIsNear = true

func _on_tree_body_exited(body):
	if body.name == "Player":
		$press_e.hide()
		playerIsNear = false


func _process(delta):
	if gamePaused == true:
		treeMenu.show()
		get_tree().paused = true

func _input(event):
	if playerIsNear == true and event.is_action_pressed("interface_with"):
		gamePaused = true

func _on_back_pressed():
	gamePaused = false
	treeMenu.hide()
	get_tree().paused = false
