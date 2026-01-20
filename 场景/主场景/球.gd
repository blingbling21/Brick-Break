extends CharacterBody2D

@export var initial_speed := 400.0
# 挡板给球的水平速度分量系数
@export var velocity_x = 0.5

func _physics_process(delta: float) -> void:
	var collidion = move_and_collide(velocity * delta)
	if collidion:
		AudioManager.play_ball_hit()
		velocity = velocity.bounce(collidion.get_normal())
		var collider = collidion.get_collider()
		if collider is CharacterBody2D:
			velocity.x += collider.velocity.x * velocity_x
			velocity = velocity.normalized() * initial_speed
		elif collider.is_in_group("Bricks"):
			collider.hit()

func reset():
	position = Vector2(576.0, 600.0)
	velocity = Vector2.ZERO

func launch():
	var direction_x = randf_range(-0.5, 0.5)
	var direction_y = 1 if randf() > 0.5 else -1
	velocity = Vector2(direction_x, direction_y).normalized() * initial_speed
