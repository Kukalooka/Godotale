extends StaticBody2D

class_name BattleBox

@export var defaultPosOffset: int
@export var player: CharacterBody2D
@export var borderWidth : int
@export var UIObject : Control

@export var borderColor : Color
@export var backgroundColor : Color
@export var boxBgColor : Color

@onready var viewportHeight = get_viewport().size.y
@onready var viewportWidth = get_viewport().size.x

@onready var bg : BattleBg = $Background

func resize(x, y):
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
	
func checkForPlayerInBounds() -> void:
	var playerCol = player.get_node("CollisionShape2D")
	
	if player.position.x < $Box_Top.global_position.x - $Box_Top.shape.size.x / 2:
		player.position.x = ($Box_Top.global_position.x - $Box_Top.shape.size.x / 2 + 
				playerCol.shape.size.x / 2 + borderWidth / 2)
	
	if player.position.x > $Box_Top.global_position.x + $Box_Top.shape.size.x / 2:
		player.position.x = ($Box_Top.global_position.x + $Box_Top.shape.size.x / 2 - 
				playerCol.shape.size.x / 2 - borderWidth / 2)
	
	if player.position.y < $Box_Left.global_position.y - $Box_Left.shape.size.y / 2:
		player.position.y = ($Box_Left.global_position.y - $Box_Left.shape.size.y / 2 + 
				playerCol.shape.size.y / 2 + borderWidth / 2)
				
	if player.position.y > $Box_Left.global_position.y + $Box_Left.shape.size.y / 2:
		player.position.y = ($Box_Left.global_position.y + $Box_Left.shape.size.y / 2 - 
				playerCol.shape.size.y / 2 - borderWidth / 2)
	
	
# This resize ignores UI when positioning
	
func resizeIgnoreUI(x, y):
	resize(x, y)
	
	var sizePercent = float(y)/ float(viewportHeight)
	var esc = pow((1 - sizePercent), 0.5)
	if esc > 1:
		esc = 1
	elif esc < 0:
		esc = 0
	
	self.position = Vector2(self.position.x, viewportHeight / 2 + defaultPosOffset * esc)		
			
	checkForPlayerInBounds()

	#player.position = Vector2(self.position.x + (self.scale.x / 2), self.position.y + (self.scale.y / 2), )
	
func resizeMindUI(x, y):
	var UIPos = UIObject.position.y
	
	resize(x, y)
	self.position = Vector2(viewportWidth / 2, UIObject.position.y - 
			($Box_Left.shape.size.y / 2))
			
	checkForPlayerInBounds()
	#player.position = Vector2(self.position.x + (self.scale.x / 2), self.position.y + (self.scale.y / 2), )

func _draw():
	var offset_x = get_node("Box_Top").get_shape().get_rect().size.x / 2
	var offset_y = get_node("Box_Left").get_shape().get_rect().size.y / 2 
	
	var topW = get_node("Box_Top").get_shape().get_rect().size.x
	var topH = get_node("Box_Top").get_shape().get_rect().size.y
	
	var sideW = get_node("Box_Left").get_shape().get_rect().size.x
	var sideH = get_node("Box_Left").get_shape().get_rect().size.y
	
	var mePosX = self.position.x
	var mePosY = self.position.y
	
	# Box background
	bg.bgRedraw(-offset_x, -offset_y, topW, sideH)
	
	# Left and Right
	draw_rect(Rect2(-offset_x, -offset_y, sideW, sideH), borderColor)
	draw_rect(Rect2(offset_x - borderWidth, -offset_y, sideW, sideH), borderColor)
	
	# Top and Bottom
	draw_rect(Rect2(-offset_x, -offset_y, topW, topH), borderColor)
	draw_rect(Rect2(-offset_x, offset_y - borderWidth, topW, topH), borderColor)
	pass

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
