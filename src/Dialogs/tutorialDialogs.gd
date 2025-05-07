extends Node2D

@onready var dialogWindow = $"../../../CanvasLayer/dialogWindow"
var firstDialogComplete: bool = false
func _on_first_dialog_body_entered(body):
	if body.name == "Player" and firstDialogComplete == false:
		dialogWindow.start_dialog(AllDialogLines.tutorialFirstLines)
		firstDialogComplete = true

