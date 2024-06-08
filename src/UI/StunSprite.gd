extends Sprite2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if $"../../../../Entity/Player/CharacterBody2D".isStanned: self.visible = true
	else: self.visible = false
