extends StaticBody2D

signal brick_destroyed(score: int)

@export var score := 1

func hit():
	brick_destroyed.emit(score)
	print("被撞了")
	queue_free()
