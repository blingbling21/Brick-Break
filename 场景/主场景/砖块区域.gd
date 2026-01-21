extends Node2D

@export var brick_scene :PackedScene
@export var brick_data_res: Array[BrickData] = []

signal update_score(score: int)
signal update_brick_count(count: int)

# 生成方块
func generate_bricks():
	for child in get_children():
		child.queue_free()

	var total_weight = 0
	for data in brick_data_res:
		total_weight += data.spawn_chance
		
	print("total_weight: ", total_weight)
	var brick_count := 0
	for x in 10:
		for y in 5:
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x * 60, y * 20)
			var brick_data = pick_brick_data_weighted(total_weight)
			add_child(brick)
			brick.initial(brick_data)
			brick.brick_destroyed.connect(_on_brick_destroyed)
			brick_count +=1
	update_brick_count.emit(brick_count)

# 加权随机返回砖块数据
func pick_brick_data_weighted(total_weight: float) -> BrickData:
	print("pick_brick_data_weighted total_weight: ", total_weight)
	var roll = randf() * total_weight
	var current_weight = 0
	for data in brick_data_res:
		current_weight += data.spawn_chance
		if roll <= current_weight:
			return data
	
	return brick_data_res[0]

func _on_brick_destroyed(score: int):
	update_score.emit(score)
