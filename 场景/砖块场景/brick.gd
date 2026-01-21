extends StaticBody2D

@onready var panel: Panel = $Panel

signal brick_destroyed(score: int)

var score := 0
var hp := 0
var max_hp := 0
# 定义抖动的强度（像素）
var shake_intensity = 4.0 

# 初始化砖块数据
func initial(brick_data: BrickData):
	score = brick_data.score
	hp = brick_data.hp
	max_hp = brick_data.hp
	modulate.a = 1.0
	change_color(brick_data.color)

#设置砖块颜色
func change_color(color: Color):
	if panel.has_theme_stylebox("panel"):
		var style = panel.get_theme_stylebox("panel").duplicate()
		style.bg_color = color
		panel.add_theme_stylebox_override("panel", style)

# 更新透明度
func update_opacity():
	var new_opacity = float(hp) / float(max_hp)
	modulate.a = new_opacity

func hit():
	hp -= 1
	if hp <= 0:
		brick_destroyed.emit(score)
		queue_free()
	else:
		update_opacity()
		shake_visuals()

func shake_visuals():
	var tween = create_tween()
	
		# 循环 5 次随机抖动
	for i in range(5):
		# 生成一个随机偏移量 (x 和 y 都在 -4 到 4 之间)
		var offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_intensity
		
		# 移动过去
		tween.tween_property(panel, "position", offset, 0.04)
	
	# 最后一定要归位
	tween.tween_property(panel, "position", Vector2.ZERO, 0.04)
