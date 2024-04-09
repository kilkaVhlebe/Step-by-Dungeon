extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var battleSystem = $"../../.."

@onready var attackButton = $"../../../Map/UI/UIButtuns/Attak"
@onready var skipButton = $"../../../Map/UI/UIButtuns/Skip"
@onready var stunButton = $"../../../Map/UI/UIButtuns/Stun"


@onready var uiButtons = $"../../../Map/UI/UIButtuns"

@onready var enemy = $"../../Enemies/CharacterBody2D"
@onready var enemy2 = $"../../Enemies/2CharacterBody2D"

var maxHealth = 200
var currentHealth = maxHealth
var energyCapacity = 100
var currentEnergy = energyCapacity
var currentEnemy = enemy
var resistValue = 10

var isStanned = false
var isAttacking = false
var isStunning = false
var isSkip = false

func _ready():
	add_to_group("Entity") 

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
	currentHealth -= damageValue - resistValue
	if currentHealth <= 0:
		animation.play("death")
		await animation.animation_finished
		queue_free()
		battleSystem.endBattle("lose")

func _on_button_pressed():
	if currentEnergy > 15 and currentEnemy != null:
		uiButtons.visible = false
		currentEnergy -= 15
		animation.play("shoot")
		currentEnemy.takeDamage(50)
		await animation.animation_finished
		animation.play("reload")
		battleSystem.endStep()
		animation.play("idle")

func _on_skip_pressed():
	uiButtons.visible = false
	battleSystem.endStep()



func _on_stun_pressed():
	if currentEnergy > 40 and currentEnemy != null:
		uiButtons.visible = false
		currentEnergy -= 40
		currentEnemy.isStanned = true
		animation.play("shoot")
		currentEnemy.takeDamage(10)
		await animation.animation_finished
		animation.play("reload")
		battleSystem.endStep()
		animation.play("idle")


func _on_target_1_pressed():
	currentEnemy = $"../../Enemies/CharacterBody2D"


func _on_target_2_pressed():
	currentEnemy = $"../../Enemies/2CharacterBody2D"
