extends StaticBody2D

class_name BattleBox

@export var defaultPosOffset: int
@export var player: CharacterBody2D

func resize(x, y):
	var viewportHeight = get_viewport().size.y
	
	$Box_Top.shape.set_size(Vector2(x, 8))
	$Box_Bottom.shape.set_size(Vector2(x, 8))
	$Box_Left.shape.set_size(Vector2(8, y))
	$Box_Right.shape.set_size(Vector2(8, y))
	
	$Box_Top.position = Vector2($Box_Top.position.x, $Box_Left.position.y -
			($Box_Left.shape.get_size().y / 2 ) + 4)
	$Box_Bottom.position = Vector2($Box_Bottom.position.x, $Box_Left.position.y + 
			($Box_Left.shape.get_size().y / 2 ) - 4)
	
	$Box_Left.position = Vector2($Box_Top.position.x - 
			($Box_Top.shape.get_size().x / 2 ) + 4, $Box_Left.position.y)
	$Box_Right.position = Vector2($Box_Top.position.x + 
			($Box_Top.shape.get_size().x / 2 ) - 4, $Box_Right.position.y)
			
	var sizePercent = float(y)/ float(viewportHeight)
	var esc = pow((1 - sizePercent), 0.5)
	if esc > 1:
		esc = 1
	elif esc < 0:
		esc = 0
	
	self.position = Vector2(self.position.x, viewportHeight / 2 + defaultPosOffset * esc)		
	player.position = Vector2(self.position.x + (self.scale.x / 2), self.position.y + (self.scale.y / 2), )

func _draw():
	
	var offset_x = get_node("Box_Top").get_shape().get_rect().size.x / 2
	var offset_y = get_node("Box_Left").get_shape().get_rect().size.y / 2 
	
	var topW = get_node("Box_Top").get_shape().get_rect().size.x
	var topH = get_node("Box_Top").get_shape().get_rect().size.y
	
	var sideW = get_node("Box_Left").get_shape().get_rect().size.x
	var sideH = get_node("Box_Left").get_shape().get_rect().size.y
	
	var mePosX = self.position.x
	var mePosY = self.position.y
	
	# Left and Right
	draw_rect(Rect2(-offset_x, -offset_y, sideW, sideH), Color.WHITE)
	draw_rect(Rect2(offset_x - 8, -offset_y, sideW, sideH), Color.WHITE)
	
	# Top and Bottom
	draw_rect(Rect2(-offset_x, -offset_y, topW, topH), Color.WHITE)
	draw_rect(Rect2(-offset_x, offset_y - 8, topW, topH), Color.WHITE)
	pass

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
