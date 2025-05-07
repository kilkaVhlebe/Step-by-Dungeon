extends CharacterBody2D

@onready var battleSystem = $"../../.."
@onready var animation = $AnimatedSprite2D

@onready var player = $"../../Player/CharacterBody2D"

@onready var hpBar = $HpBar

@onready var SFX = $"../../../Audio/SFX"
var ShootSound = preload("res://Audio/SFX/Battle/Retro Weapon Gun LoFi 03.wav")
var StunSound = preload("res://Audio/SFX/Battle/Retro Shot 23.wav")

var rng = RandomNumberGenerator.new()

var maxHealth = 100
var currentHealth = maxHealth
var skillChance = 0.1
var stunColdown = 0

var isStanned = false

func _ready():
	add_to_group("Entity")
	add_to_group("Enemy")
	hpBar.max_value = maxHealth
	hpBar.value = currentHealth
	
@warning_ignore("unused_parameter")
func _process(delta):
	if isStanned:
		$"stun effect".visible = true
	else:
		$"stun effect".visible = false

func onStep():
	if not isStanned and player != null :
		print("enemy step")
		var x = rng.randf() 
		if x < skillChance and not player.isStanned:
			print("first check")
			if RunState.playerItemsList.find("energy_barier") == -1 and battleSystem.energyBarierColdown != 0:
				print("second check")
				stun(player)
			elif RunState.playerItemsList.find("energy_barier") != -1 and battleSystem.energyBarierColdown == 0: 
				battleSystem.energyBarierColdown = 3
				#сделать заглушку под эффект предмета
		else:
			await attack(player)
		battleSystem.endStep()


func attack(target):
	animation.play("shoot")
	SFX.stream = ShootSound
	SFX.play()
	target.takeDamage(20)
	await animation.animation_finished
	animation.play("idle")
	
func stun(target):
	print("enemy use stun")
	skillChance -= 0.05
	animation.play("shoot")
	SFX.stream = StunSound
	SFX.play()
	print("player was stuned")
	target.takeDamage(5)
	target.isStanned = true
	target.stunColdown = rng.randi_range(1,2)
	await animation.animation_finished
	animation.play("idle")
	
func takeDamage(damageValue):
	currentHealth -= damageValue
	hpBar.value = currentHealth
	print("enemy was damaged")
	if currentHealth <= 0:
		remove_from_group("Entity")
		remove_from_group("Enemy")
		animation.play("death")
		await animation.animation_finished
		queue_free()
		if get_tree().get_nodes_in_group("Enemy").size() == 0:
			battleSystem.endBattle("win")
	
