extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var battleSystem = $"../../.."

@onready var attackButton = $"../../../Map/UI/UIButtuns/Attak"
@onready var skipButton = $"../../../Map/UI/UIButtuns/Skip"
@onready var stunButton = $"../../../Map/UI/UIButtuns/Stun"


@onready var uiButtons = $"../../../Map/UI/UIButtuns"

@onready var enemy = $"../../Enemies/CharacterBody2D"
@onready var enemy2 = $"../../Enemies/2CharacterBody2D"

@onready var hpBar = $"../../../Map/UI/PlayerHpBar"
@onready var energyBar = $"../../../Map/UI/PlayerEnergyBar"

@onready var SFX = $"../../../Audio/SFX"
var ShootSound = preload("res://Audio/SFX/Battle/Retro Weapon Gun LoFi 03.wav")
var StunSound = preload("res://Audio/SFX/Battle/Retro Shot 23.wav")
var UIsfx = preload("res://Audio/SFX/UI/MI_SFX 43.wav")

var maxHealth = 200
var currentHealth = maxHealth
var energyCapacity = 100
var currentEnergy = energyCapacity
var currentEnemy = enemy
var stunColdown = 0

var isStanned = false
var isAttacking = false
var isStunning = false
var isSkip = false




func _ready():
	add_to_group("Entity") 
	hpBar.max_value = maxHealth
	hpBar.value = currentHealth
	
	if LevelState.playerItemsList.find("energy_barier") == -1:
		energyBar.max_value = energyCapacity
		energyBar.value = currentEnergy
	else:
		energyCapacity - 20
		energyBar.max_value = energyCapacity
		currentEnergy = energyCapacity
		energyBar.value = currentEnergy

@warning_ignore("unused_parameter")
func _process(delta):
	pass
	
func onStep():
	if enemy != null:
		enemy.skillChance = 0.1 
	if enemy2 != null:
		enemy2.skillChance = 0.1
	uiButtons.visible = true
	print("player step")

func takeDamage(damageValue):
	currentHealth -= damageValue
	hpBar.value = currentHealth
	if currentHealth <= 0:
		animation.play("death")
		await animation.animation_finished
		queue_free()
		battleSystem.endBattle("lose")

func _on_attak_pressed():
	if currentEnergy > 15 and currentEnemy != null:
		uiButtons.visible = false
		currentEnergy -= 15
		energyBar.value = currentEnergy
		animation.play("shoot")
		SFX.stream = ShootSound
		SFX.play()
		currentEnemy.takeDamage(50)
		if LevelState.playerItemsList.find("shotgun") != -1:
			print("shotgun is shooting")
			get_tree().call_group("Enemy", "takeDamage", 10)
		await animation.animation_finished
		animation.play("reload")
		await animation.animation_finished
		animation.play("idle")
		battleSystem.endStep()

func _on_skip_pressed():
	uiButtons.visible = false
	SFX.stream = UIsfx
	SFX.play()
	battleSystem.endStep()

func _on_stun_pressed():
	if currentEnergy > 40 and currentEnemy != null:
		uiButtons.visible = false
		currentEnergy -= 40
		energyBar.value = currentEnergy
		currentEnemy.isStanned = true
		currentEnemy.stunColdown = randi_range(1,3)
		animation.play("shoot")
		SFX.stream = StunSound
		SFX.play()
		currentEnemy.takeDamage(10)
		await animation.animation_finished
		animation.play("reload")
		battleSystem.endStep()
		animation.play("idle")


func _on_target_1_pressed():
	currentEnemy = $"../../Enemies/CharacterBody2D"


func _on_target_2_pressed():
	currentEnemy = $"../../Enemies/2CharacterBody2D"



