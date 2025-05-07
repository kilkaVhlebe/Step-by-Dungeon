extends Control

@onready var person: Label = $VBoxContainer/personName
@onready var dialog: RichTextLabel = $VBoxContainer/dialogText

var dialog_queue: Array = []
var current_index: int = -1

var gamePaused: bool = false

func _process(delta):
	if gamePaused == true:
		get_tree().paused = true

func start_dialog(lines: Array):
	gamePaused = true
	dialog_queue = lines
	current_index = -1
	_next_line()

func display_line(dialogText: String, personName: String = ""):
	person.visible = (personName != "")
	person.text = personName
	dialog.text = dialogText
	open()

func open():
	show()

func close():
	gamePaused = false
	get_tree().paused = false
	hide()

func _on_continue_pressed():
	_next_line()

func _next_line():
	current_index += 1
	if current_index < dialog_queue.size():
		var line = dialog_queue[current_index]
		display_line(line.get("dialogText", ""), line.get("personName", ""))
	else:
		close()
