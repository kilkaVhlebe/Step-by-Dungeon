extends CharacterBody2D

@onready var battleSystem = $"../../.."
@onready var animation = $AnimatedSprite2D

@onready var player = $"../../Player/CharacterBody2D"

var rng = RandomNumberGenerator.new()

var maxHealth = 100
var currentHealth = maxHealth
var skillChance = 0.1
var resistValue = 10
var isStanned = false

func _ready():
	add_to_group("Entity") 

func _process(delta):
	pass

func onStep():
	if not isStanned:
		print("enemy step")
		var x = rng.randf() 
		if x < skillChance:
			stun(player)
		else:
			await attack(player)
		battleSystem.endStep()


func attack(target):
	animation.play("shoot")
	target.takeDamage(20)
	await animation.animation_finished
	animation.play("idle")
	
func stun(target):
	skillChance -= 0.05
	animation.play("shoot")
	target.takeDamage(5)
	target.isStanned = true
	await animation.animation_finished
	animation.play("idle")
	
func takeDamage(damageValue):
	currentHealth -= damageValue - resistValue
	if currentHealth <= 0:
		remove_from_group("Entity")
		animation.play("death")
		await animation.animation_finished
		battleSystem.aliveEnemys -= 1
		queue_free()
		if battleSystem.aliveEnemys == 0:
			battleSystem.endBattle("win")
	
