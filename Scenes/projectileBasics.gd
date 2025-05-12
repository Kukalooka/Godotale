extends Area2D

func _physics_process(_delta):
	self.position.x += 5


func _on_body_entered(body : PlayerHeart) -> void:
	body.projectile_hit()
	pass # Replace with function body.
