extends Node2D

class_name BoxBg

@export var Box_Top : CollisionShape2D
@export var Box_Left : CollisionShape2D

@onready var viewportHeight = 480
@onready var viewportWidth = 640

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
	var boxBgColor = get_parent().boxBgColor
			
	draw_rect(Rect2(offset_x, offset_y, topW, sideH), boxBgColor)
