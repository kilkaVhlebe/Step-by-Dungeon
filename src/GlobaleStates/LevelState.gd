extends Node


var currentLevel

var allSecenesPaths = ["res://Scenes/Levels/Level1/level1.1.tscn","res://Scenes/Levels/Dev_lvl.tscn"]

var playerItemsList = []

func changeCurrentLevel(level):
	currentLevel = level
