extends Node


var config = ConfigFile.new()
var pathToSaveFile = "user://saves/game.cfg"
var sectionName = "game"

var scrapValue: int

var atkBuff: int
var energyBuff: int
var hpBuff: int

var atkBuffLvl: int
var energyBuffLvl: int
var hpBuffLvl: int

var tuturialComplete: bool

func _ready():
	print("autoloaded")
	loadGame()
	
func saveGame():
	config.set_value(sectionName, "scrapValue", scrapValue)
	
	config.set_value(sectionName, "atkBuff", atkBuff)
	config.set_value(sectionName, "energyBuff", energyBuff)
	config.set_value(sectionName, "hpBuff", hpBuff)

	config.set_value(sectionName, "atkBuffLvl", atkBuffLvl)
	config.set_value(sectionName, "energyBuffLvl", energyBuffLvl)
	config.set_value(sectionName, "hpBuffLvl", hpBuffLvl)

	config.set_value(sectionName, "tuturialComplete", tuturialComplete)
	
	config.save(pathToSaveFile) 
	print("Game saved")

func loadGame():
	config.load(pathToSaveFile)
	
	scrapValue = config.get_value(sectionName, "scrap_value", 0)
	
	atkBuff = config.get_value(sectionName, "atkBuff", 0)
	energyBuff = config.get_value(sectionName, "energyBuff", 0)
	hpBuff = config.get_value(sectionName, "hpBuff", 0)

	atkBuffLvl = config.get_value(sectionName, "atkBuffLvl", 0)
	energyBuffLvl = config.get_value(sectionName, "energyBuffLvl", 0)
	hpBuffLvl = config.get_value(sectionName, "hpBuffLvl", 0)
	
	tuturialComplete = config.get_value(sectionName, "tuturialComplete", false)

	print("Game loaded")
	
