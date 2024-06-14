extends Node2D

var sfxBusIndex = AudioServer.get_bus_index("SFX")
var musicBusIndex = AudioServer.get_bus_index("Music")
var MasterBusIndex = AudioServer.get_bus_index("Master")

var musciVolume = -1
var masterVolume = -1
var sfxVolume = -1

func _ready():
	$AudioOptions/Master/MasterBar.value = AudioServer.get_bus_volume_db(MasterBusIndex)
	$AudioOptions/Music/MusicBar.value = AudioServer.get_bus_volume_db(musicBusIndex)
	$AudioOptions/Music/SFX/SFXBar.value = AudioServer.get_bus_volume_db(sfxVolume)

func _on_plus_button_master_pressed():
	masterVolume += 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(MasterBusIndex, masterVolume)
	$AudioOptions/Master/MasterBar.value = masterVolume


func _on_minus_button_master_pressed():
	masterVolume -= 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(MasterBusIndex, masterVolume)
	$AudioOptions/Master/MasterBar.value = masterVolume


func _on_plus_button_music_pressed():
	musciVolume += 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(musicBusIndex, musciVolume)
	$AudioOptions/Music/MusicBar.value = musciVolume


func _on_minus_button_music_pressed():
	musciVolume -= 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(musicBusIndex, musciVolume)
	$AudioOptions/Music/MusicBar.value = musciVolume


func _on_plus_button_sfx_pressed():
	sfxVolume += 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(sfxBusIndex, sfxVolume)
	$AudioOptions/Music/SFX/SFXBar.value = sfxVolume


func _on_minus_button_sfx_pressed():
	sfxVolume -= 1
	$Audio/MenuSFX.play()
	AudioServer.set_bus_volume_db(sfxBusIndex, sfxVolume)
	$AudioOptions/Music/SFX/SFXBar.value = sfxVolume
