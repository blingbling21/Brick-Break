extends Node2D

@export var brick_scene :PackedScene

signal update_score(score: int)
signal update_brick_count(count: int)

# 生成方块
func generate_bricks():
	for child in get_children():
		child.queue_free()

	var brick_count := 0
	for x in 10:
		for y in 5:
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x * 60, y * 20)
			add_child(brick)
			brick.brick_destroyed.connect(_on_brick_destroyed)
			brick_count +=1
	update_brick_count.emit(brick_count)

func _on_brick_destroyed(score: int):
	update_score.emit(score)
