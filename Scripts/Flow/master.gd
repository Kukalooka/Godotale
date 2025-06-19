extends Node2D

@onready var box : BattleBox = $Box
@onready var player : PlayerHeart = $PlayerSoul
@onready var textbox : BattleTextbox = $Textbox

var placeholderProjectile = load("res://Assets/Objects/Projectiles/placeholderKnife.tscn")

func _ready():
	textbox.invokeBattleText("Wow this is so [wave amp=50 freq=5][color=yellow]crazy[/color][/wave]. I would like to eat some [color=red][shake rate=20.0 level=5 connected=1]chocolate.[/shake][/color]")
	pass # Replace with function body.

func _input(ev):
	if GameMaster.devMode:
		if Input.is_key_pressed(KEY_1):
			player.updatePlayerState(0)
		if Input.is_key_pressed(KEY_2):
			player.updatePlayerState(1)
		if Input.is_key_pressed(KEY_3):
			box.resizeBox(640, 200, 10, 0.01)
		if Input.is_key_pressed(KEY_4):
			box.resizeBox(200, 300, 10, 0.01)
		if Input.is_key_pressed(KEY_5):
			box.resizeBox(600, 400, 10, 0.01, false)
		if Input.is_key_pressed(KEY_6):
			box.resizeBox(200, 80, 10, 0.01)
		if Input.is_key_pressed(KEY_7):
			var projectile = placeholderProjectile.instantiate()
			add_child(projectile)
			projectile.position.y = 350
			projectile.scale.x = 2
			projectile.scale.y = 2
