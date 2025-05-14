extends Node2D

class_name BattleBg
@export var sideBg : BattleSidesBg
@export var boxBg : BoxBg

@export var Box_Top : CollisionShape2D
@export var Box_Left : CollisionShape2D

@onready var viewportHeight = 480
@onready var viewportWidth = 640

func bgRedraw(x, y, w, h):
	boxBg.bgRedraw(x, y, w, h)
	queue_redraw()

func _draw():
	var backgroundColor = get_parent().backgroundColor
			
	# Top and Bottom
	draw_rect(Rect2(-(viewportWidth / 2), -(Box_Left.shape.size.y / 2), 
			viewportWidth, -viewportHeight), backgroundColor)
	draw_rect(Rect2(-(viewportWidth / 2), Box_Left.shape.size.y / 2, 
			viewportWidth, viewportHeight), backgroundColor)
	
	sideBg.bgRedraw()
