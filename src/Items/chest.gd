extends Node2D

@onready var label = $UI
var PlayerIsNear = false
var closed = true
var node

@onready var medecine_package = load("res://Scenes/Prebafs/medecine_package.tscn")
@onready var shotgun = load("res://Scenes/Prebafs/shotgun.tscn")
@onready var energy_barier = load("res://Scenes/Prebafs/energy_barier.tscn")

var rnd = RandomNumberGenerator.new()
var item

func _input(event):
	if PlayerIsNear == true and event.is_action_pressed("interface_with"):
		open_chest()

func _ready():
	label.visible = false
	
	rnd.randomize()
	
	match rnd.randi_range(1, 3):
		1: item = medecine_package.instantiate()
		2: item = energy_barier.instantiate()
		3: item = shotgun.instantiate()


func _on_area_2d_body_entered(body):
	if body and body.name == "Player" and label != null:
		label.visible = true
		PlayerIsNear = true


func _on_area_2d_body_exited(body):
	if body and body.name == "Player" and label != null:
		label.visible = false
		PlayerIsNear = false

func open_chest():
	if closed:
		closed = false
		$closed_chest.visible = false
		$open_chest.visible = true
		
		label.queue_free()
		add_child(item)
