extends Node2D

class_name BattleBg
@export var sideBg : BattleSidesBg
@export var boxBg : BoxBg

@export var Box_Top : CollisionShape2D
@export var Box_Left : CollisionShape2D

@onready var viewportHeight = get_viewport().size.y
@onready var viewportWidth = get_viewport().size.x

func bgRedraw(x, y, w, h):
	boxBg.bgRedraw(x, y, w, h)
	queue_redraw()

func _draw():
	var defaultPosOffset = get_parent().defaultPosOffset
	var backgroundColor = get_parent().backgroundColor
			
	# Top and Bottom
	draw_rect(Rect2(-(viewportWidth / 2), -(Box_Left.shape.size.y / 2), 
			viewportWidth, -viewportHeight), backgroundColor)
	draw_rect(Rect2(-(viewportWidth / 2), Box_Left.shape.size.y / 2, 
			viewportWidth, viewportHeight), backgroundColor)
	
	sideBg.bgRedraw()
