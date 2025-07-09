extends Area2D

@export var projectileDmg : int

# Currently this is placeholder dummy code to test functionality

func _physics_process(_delta):
	self.position.x += 5


func _on_body_entered(body : PlayerHeart) -> void:
	body.projectile_hit(projectileDmg)
	pass # Replace with function body.
