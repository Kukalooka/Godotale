extends Node2D

class_name BattleBg
@export var sideBg : BattleSidesBg

@export var Box_Top : CollisionShape2D
@export var Box_Left : CollisionShape2D

@onready var viewportHeight = get_viewport().size.y
@onready var viewportWidth = get_viewport().size.x

var offset_x
var offset_y
var topW
var sideH

func bgRedraw(x, y, w, h):
	offset_x = x
	offset_y = y
	topW = w
	sideH = h
	queue_redraw()

func _draw():
	var defaultPosOffset = get_parent().defaultPosOffset
	var backgroundColor = get_parent().backgroundColor
	var boxBgColor = get_parent().boxBgColor
			
	# Top and Bottom
	draw_rect(Rect2(-(viewportWidth / 2), -(Box_Left.shape.size.y / 2), 
			viewportWidth, -viewportHeight), backgroundColor)
	draw_rect(Rect2(-(viewportWidth / 2), Box_Left.shape.size.y / 2, 
			viewportWidth, viewportHeight), backgroundColor)
			
	draw_rect(Rect2(offset_x, offset_y, topW, sideH), boxBgColor)
	
	sideBg.bgRedraw()
