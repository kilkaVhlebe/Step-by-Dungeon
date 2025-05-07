extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		RunState.creditsValue += 50
		AutoSaveLoad.scrapValue += 100
		queue_free()
