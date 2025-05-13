extends Node2D

@onready var box : BattleBox = $Box

var placeholderProjectile = load("res://Assets/Objects/Projectiles/placeholderKnife.tscn")

func _ready():
	box.resizeMindUI(350, 175)
	pass # Replace with function body.

func _input(ev):
	if GameMaster.devMode:
		if Input.is_key_pressed(KEY_K):
			box.resizeMindUI(200, 200)
		if Input.is_key_pressed(KEY_L):
			box.resizeMindUI(300, 100)
		if Input.is_key_pressed(KEY_M):
			box.resizeIgnoreUI(300, 100)
		if Input.is_key_pressed(KEY_D):
			var projectile = placeholderProjectile.instantiate()
			add_child(projectile)
			projectile.position.y = 350
			projectile.scale.x = 2
			projectile.scale.y = 2
