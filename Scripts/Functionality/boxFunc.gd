extends StaticBody2D

class_name BattleBox

@export var defaultPosOffset: int
@export var player: CharacterBody2D
@export var borderWidth : int
@export var UIObject : Control

@export var borderColor : Color
@export var backgroundColor : Color
@export var boxBgColor : Color

@onready var viewportHeight = 480
@onready var viewportWidth = 640

@onready var bg : BattleBg = $Background

var resizeToken = 0

func _resize(x, y):
	$Box_Top.shape.set_size(Vector2(x, borderWidth))
	$Box_Bottom.shape.set_size(Vector2(x, borderWidth))
	$Box_Left.shape.set_size(Vector2(borderWidth, y))
	$Box_Right.shape.set_size(Vector2(borderWidth, y))
	
	$Box_Top.position = Vector2($Box_Top.position.x, $Box_Left.position.y -
			($Box_Left.shape.get_size().y / 2 ) + borderWidth / 2)
	$Box_Bottom.position = Vector2($Box_Bottom.position.x, $Box_Left.position.y + 
			($Box_Left.shape.get_size().y / 2 ) - borderWidth / 2)
	
	$Box_Left.position = Vector2($Box_Top.position.x - 
			($Box_Top.shape.get_size().x / 2 ) + borderWidth / 2, $Box_Left.position.y)
	$Box_Right.position = Vector2($Box_Top.position.x + 
			($Box_Top.shape.get_size().x / 2 ) - borderWidth / 2, $Box_Right.position.y)
	queue_redraw()
	
# This function will teleport the player in bounds if there is need to do so
func checkForPlayerInBounds(offset) -> void:
	var playerCol = player.get_node("CollisionShape2D")
	
	# These two if statements check if the player is on either of the sides
	if player.position.x < $Box_Top.global_position.x - $Box_Top.shape.size.x / 2 + borderWidth + playerCol.shape.size.x / 2:
		player.position.x = ($Box_Top.global_position.x - $Box_Top.shape.size.x / 2 + 
				playerCol.shape.size.x / 2 + borderWidth / 2 + offset)
	if player.position.x > $Box_Top.global_position.x + $Box_Top.shape.size.x / 2 - borderWidth - playerCol.shape.size.x / 2:
		player.position.x = ($Box_Top.global_position.x + $Box_Top.shape.size.x / 2 - 
				playerCol.shape.size.x / 2 - borderWidth / 2 - offset)
	
	# These if statements check if the player is above or below
	if player.position.y < $Box_Left.global_position.y - $Box_Left.shape.size.y / 2 + borderWidth + playerCol.shape.size.y / 2:
		print("outside")
		player.position.y = ($Box_Left.global_position.y - $Box_Left.shape.size.y / 2 + 
				playerCol.shape.size.y / 2 + borderWidth / 2 + offset)
	if player.position.y > $Box_Left.global_position.y + $Box_Left.shape.size.y / 2 - borderWidth - playerCol.shape.size.y / 2:
		print("outside")
		player.position.y = ($Box_Left.global_position.y + $Box_Left.shape.size.y / 2 - 
				playerCol.shape.size.y / 2 - borderWidth / 2 - offset)
	
	
# This resize ignores UI when positioning
func _resizeIgnoreUI(x, y):
	_resize(x, y)
	
	var sizePercent = float(y)/ float(viewportHeight)
	var esc = pow((1 - sizePercent), 0.5)
	if esc > 1:
		esc = 1
	elif esc < 0:
		esc = 0
	
	self.position = Vector2(self.position.x, viewportHeight / 2 + defaultPosOffset * esc)		
			#
	#checkForPlayerInBounds(0)

	#player.position = Vector2(self.position.x + (self.scale.x / 2), self.position.y + (self.scale.y / 2), )
	
# This resize will always keep the bottom boundry above the control UI node
func _resizeMindUI(x, y):
	var UIPos = UIObject.position.y
	
	_resize(x, y)
	self.position = Vector2(viewportWidth / 2, UIPos - 
			($Box_Left.shape.size.y / 2))
			
	#checkForPlayerInBounds(0)
	#player.position = Vector2(self.position.x + (self.scale.x / 2), self.position.y + (self.scale.y / 2), )

func resizeBox(x, y, rate=2, wait=1, mindUi=true):
	resizeToken += 1
	
	return await _resizeBox(x, y, rate, wait, mindUi, resizeToken)

func _resizeBox(x, y, rate, wait, mindUi, token):
	if token != resizeToken:
		return false
	
	for i in range(wait):
		await get_tree().process_frame
	var xRate = rate
	var yRate = rate
	
	if x != $Box_Top.shape.size.x || y != $Box_Left.shape.size.y:
		if x < $Box_Top.shape.size.x:
			xRate = -xRate
		if y < $Box_Left.shape.size.y:
			yRate = -yRate

		if abs(x - $Box_Top.shape.size.x) <= rate || abs(y - $Box_Left.shape.size.y) <= rate:
			if abs(x - $Box_Top.shape.size.x) <= rate && abs(y - $Box_Left.shape.size.y) <= rate:
				if mindUi:
					_resizeMindUI(x, y)
				else:
					_resizeIgnoreUI(x, y)
			elif abs(y - $Box_Left.shape.size.y) <= rate:
				xRate *= 2
				if mindUi:
					_resizeMindUI($Box_Top.shape.size.x + xRate, y)
				else:
					_resizeIgnoreUI($Box_Top.shape.size.x + xRate, y)
			else:
				yRate *= 2
				if mindUi:
					_resizeMindUI(x, $Box_Left.shape.size.y + yRate)
				else:
					_resizeIgnoreUI(x, $Box_Left.shape.size.y + yRate)
		else:
			if mindUi:
				_resizeMindUI($Box_Top.shape.size.x + xRate, $Box_Left.shape.size.y + yRate)
			else:
				_resizeIgnoreUI($Box_Top.shape.size.x + xRate, $Box_Left.shape.size.y + yRate)
		checkForPlayerInBounds(rate)
		return await _resizeBox(x, y, rate, wait, mindUi, token)
	else:
		return true
	

func _draw():
	var offset_x = get_node("Box_Top").get_shape().get_rect().size.x / 2
	var offset_y = get_node("Box_Left").get_shape().get_rect().size.y / 2 
	
	var topW = get_node("Box_Top").get_shape().get_rect().size.x
	var topH = get_node("Box_Top").get_shape().get_rect().size.y
	
	var sideW = get_node("Box_Left").get_shape().get_rect().size.x
	var sideH = get_node("Box_Left").get_shape().get_rect().size.y
	
	var mePosX = self.position.x
	var mePosY = self.position.y
	
	# This offloads the drawing of the box to the other nodes so they can have different Z indexes
	bg.bgRedraw(-offset_x, -offset_y, topW, sideH)
	
	# Left and Right
	draw_rect(Rect2(-offset_x, -offset_y, sideW, sideH), borderColor)
	draw_rect(Rect2(offset_x - borderWidth, -offset_y, sideW, sideH), borderColor)
	
	# Top and Bottom
	draw_rect(Rect2(-offset_x, -offset_y, topW, topH), borderColor)
	draw_rect(Rect2(-offset_x, offset_y - borderWidth, topW, topH), borderColor)
	pass

func _ready():
	pass

func _process(delta):
	pass
