extends Node2D

@onready var box : BattleBox = $Box

func _ready():
	box.resizeIgnoreUI(100, 100)
	pass # Replace with function body.

func _input(ev):
	if Input.is_key_pressed(KEY_K):
		box.resizeIgnoreUI(200, 50)
