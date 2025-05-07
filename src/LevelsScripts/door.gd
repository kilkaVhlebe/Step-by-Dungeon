extends Node2D

var playerIsNear: bool = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		playerIsNear = true
		$Label.show()

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		playerIsNear = false
		$Label.hide()


func _input(event):
	if playerIsNear == true and event.is_action_pressed("interface_with"):
		$AnimatedSprite2D.play("open")
		await  $AnimatedSprite2D.animation_finised
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1/level1.3.tscn") # тут должен юыть босс батлл типо
