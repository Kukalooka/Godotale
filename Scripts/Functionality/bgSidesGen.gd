extends Node2D

class_name BattleSidesBg

@export var Box_Top : CollisionShape2D
@export var Box_Left : CollisionShape2D

@onready var viewportHeight = 480
@onready var viewportWidth = 640

func bgRedraw():
	queue_redraw()

func _draw():
	var defaultPosOffset = get_parent().defaultPosOffset
	var backgroundColor = get_parent().backgroundColor
	var boxBgColor = get_parent().boxBgColor
	
	# Left and Right
	draw_rect(Rect2(-(viewportWidth / 2), -(Box_Left.shape.size.y / 2), 
			(get_parent().position.x - Box_Top.shape.size.x / 2), viewportHeight), backgroundColor)
	draw_rect(Rect2(Box_Top.shape.size.x / 2, -(Box_Left.shape.size.y / 2), 
			viewportWidth, viewportHeight), backgroundColor)
