extends CharacterBody2D

class_name PlayerHeart

@export var MAX_SPEED = 150.0
@export var SPEED = 150.0
const JUMP_VELOCITY = -400.0

@export var maxHp = 20
@export var curHp = 20

@export_file("*.wav") var damageSfx : String
@export var invDuration : float
@export var invAmount : int

@export var ui : BattleUi

@export var box : BattleBox

var playerState = 1

var invincible = false

func updatePlayerState(val):
	playerState = val
		
	match playerState:
		0:
			ui.changeUiState(false)
			self.visible = false
			velocity = Vector2(0, 0)
		1:
			ui.changeUiState(true)
			self.visible = true
			self.position = Vector2(box.position.x + (box.scale.x / 2), box.position.y + (box.scale.y / 2), )

func blink(duration, amount):
	var vis : bool = true
	invincible = true
	
	for i in range(1, amount):
		await get_tree().create_timer(duration).timeout
		if vis:
			$Sprite2D.self_modulate.a = 0.5
		else:
			$Sprite2D.self_modulate.a = 1
		vis = !vis
	invincible = false	

func _input(key):
	if key.is_action_pressed("ui_advance"):
		SPEED = MAX_SPEED / 2
	elif key.is_action_released("ui_advance"):
		SPEED = MAX_SPEED

func _physics_process(delta):
	if playerState == 1:
		var direction_x = Input.get_axis("ui_left", "ui_right")
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var direction_y = Input.get_axis("ui_up", "ui_down")
		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func projectile_hit(dmg) -> void:
	if !invincible:
		curHp -= dmg
		if curHp < 0:
			curHp = 0		
			
		ui.changeHpBar(curHp)
		blink(invDuration, invAmount)
		$AudioStreamPlayer2D.stream = load(damageSfx)
		$AudioStreamPlayer2D.play()
