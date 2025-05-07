extends Control

@onready var resume: TextureButton = $Panel/Panel/VBoxContainer/resum
@onready var quit: TextureButton = $Panel/Panel/VBoxContainer/quit

var gamePaused: bool = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		show()

func _on_resum_pressed():
	get_tree().paused = false
	hide()

func _on_quit_pressed():
	RunState.nullifyAll()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
