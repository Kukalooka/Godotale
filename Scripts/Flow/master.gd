extends Node2D

@onready var box : BattleBox = $Box

func _ready():
	box.resizeMindUI(200, 50)
	pass # Replace with function body.

func _input(ev):
	if Input.is_key_pressed(KEY_K):
		box.resizeMindUI(200, 200)
