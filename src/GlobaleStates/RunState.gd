extends Node


var creditsValue = 0
var AgressiveLevel = 0

var playerItemsList = []



func nullifyAll():
	creditsValue = 0
	AgressiveLevel = 0
	playerItemsList = []
	
	
	
func changeCraditValue(value):
	creditsValue+=value
