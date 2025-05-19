extends Node2D

@onready var box : BattleBox = $Box
@onready var player : PlayerHeart = $PlayerSoul

var placeholderProjectile = load("res://Assets/Objects/Projectiles/placeholderKnife.tscn")

func _ready():
	box.resizeProgMindUi(500, 300, 5, 1)
	pass # Replace with function body.

func _input(ev):
	if GameMaster.devMode:
		if Input.is_key_pressed(KEY_O):
			player.updatePlayerState(0)
		if Input.is_key_pressed(KEY_P):
			player.updatePlayerState(1)
		if Input.is_key_pressed(KEY_K):
			box.resizeProgMindUi(200, 200, 5, 1)
		if Input.is_key_pressed(KEY_L):
			box.resizeProgMindUi(300, 100, 5, 1)
		if Input.is_key_pressed(KEY_M):
			box.resizeProgMindUi(300, 100, 5, 1)
		if Input.is_key_pressed(KEY_D):
			var projectile = placeholderProjectile.instantiate()
			add_child(projectile)
			projectile.position.y = 350
			projectile.scale.x = 2
			projectile.scale.y = 2
