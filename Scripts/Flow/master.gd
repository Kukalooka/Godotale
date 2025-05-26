extends Node2D

@onready var box : BattleBox = $Box
@onready var player : PlayerHeart = $PlayerSoul
@onready var textbox : TextboxSystem = $Textbox

var placeholderProjectile = load("res://Assets/Objects/Projectiles/placeholderKnife.tscn")

func _ready():
	textbox.invokeTextbox("Testing testing...")
	pass # Replace with function body.

func _input(ev):
	if GameMaster.devMode:
		if Input.is_key_pressed(KEY_O):
			player.updatePlayerState(0)
		if Input.is_key_pressed(KEY_P):
			player.updatePlayerState(1)
		if Input.is_key_pressed(KEY_K):
			box.resizeBox(640, 200, 10, 1)
		if Input.is_key_pressed(KEY_L):
			box.resizeBox(200, 300, 10, 1)
		if Input.is_key_pressed(KEY_M):
			box.resizeBox(600, 400, 10, 1, false)
		if Input.is_key_pressed(KEY_U):
			box.resizeBox(200, 80, 10, 1)
		if Input.is_key_pressed(KEY_D):
			var projectile = placeholderProjectile.instantiate()
			add_child(projectile)
			projectile.position.y = 350
			projectile.scale.x = 2
			projectile.scale.y = 2
