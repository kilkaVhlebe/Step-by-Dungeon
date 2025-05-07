extends Node2D

var query = []
var isStepNow = false
@onready var player = $Entity/Player/CharacterBody2D
@onready var enemy = $Entity/Enemies/CharacterBody2D
@onready var enemy2 = $"Entity/Enemies/2CharacterBody2D"

@onready var dialog = $CanvasLayer/dialogWindow


var batlleResult

var stepCounter = 0

var energyBarierColdown = 3


func _ready():
	if AutoSaveLoad.tuturialComplete == false:
		dialog.start_dialog(AllDialogLines.battleTutorial)
	
func _physics_process(delta):
	if query.size() <= get_tree().get_nodes_in_group("Entity").size():
		if player != null: addToQuery(player)
		if enemy != null: addToQuery(enemy)
		if enemy2 != null: addToQuery(enemy2)
		
	if not player or (not enemy and not enemy2):
		pass 
	if not isStepNow:
		isStepNow = true
		stepColdown()
		if query[0] != null and not query[0].isStanned:
			query[0].onStep()
		else:
			endStep()

func endStep():
	if player.currentEnergy < player.energyCapacity and query[0] != null and not query[0].isStanned:
		player.currentEnergy += 5
		
	if energyBarierColdown > 0:
		energyBarierColdown -= 1
		
	if query[0] != null and query[0].isStanned and query[0].stunColdown == 0:
		query[0].isStanned = false
	elif query[0] != null:
		query[0].stunColdown -= 1
		stepCounter += 1
		
	query.remove_at(0)
	
	if stepCounter % 2 == 0 and RunState.playerItemsList.find("medecin_package") != -1:
		player.currentHealth += 5
		player.hpBar.value = player.currentHealth
		
	isStepNow = false

func addToQuery(Entity):
	if Entity:
		query.append(Entity)
	
func stepColdown():
	await get_tree().create_timer(60).timeout
	isStepNow = false
	
func endBattle(result):
	if AutoSaveLoad.tuturialComplete == true:
		match result:
			"lose":
				get_tree().change_scene_to_file("res://Scenes/Levels/hub_scene.tscn") #todo сделать экран смерти
			"win":
				if LevelState.allSecenesPaths.find(LevelState.currentLevel) < LevelState.allSecenesPaths.size() -1 :
					get_tree().change_scene_to_file(LevelState.allSecenesPaths[LevelState.allSecenesPaths.find(LevelState.currentLevel) + 1])
	if AutoSaveLoad.tuturialComplete == false:
		match result:
			"lose":
				get_tree().reload_current_scene()
			"win":
				get_tree().change_scene_to_file("res://Scenes/Levels/hub_scene.tscn")
