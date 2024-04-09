extends CharacterBody2D


const SPEED = 50.0
@onready var animation = $"AnimatedSprite2D"

func _ready():
	LevelState.changeCurrentLevel(get_tree().current_scene)
	

func _physics_process(delta):
	var direction = 1
	if direction:
		velocity.x = direction * SPEED
		animation.play("run" if direction else "idle")
		animation.flip_h = direction < 0
		position.x += velocity.x * delta


func _on_area_2d_body_entered(body):
	if body and body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/Levels/battle_lvl.tscn")
