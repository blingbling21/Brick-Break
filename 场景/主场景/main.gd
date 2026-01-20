extends Node2D

@onready var ball: CharacterBody2D = $游戏管理/球
@onready var dead_area: Area2D = $游戏管理/死亡区域
@onready var baffle: CharacterBody2D = $游戏管理/挡板
@onready var start_screen: Control = $GUI/开始界面
@onready var over_screen: Control = $GUI/结束界面
@onready var countdown_screen: Control = $GUI/倒计时显示
@onready var countdown_screen_label: Label = $GUI/倒计时显示/Label
@onready var score_label: Label = $GUI/分数显示/分数
@onready var brick_count_label: Label = $GUI/分数显示/剩余砖块
@onready var final_score_label: Label = $GUI/结束界面/HBoxContainer/VBoxContainer/最终分数
@onready var brick_area: Node2D = $游戏管理/砖块区域
@onready var game_world: Node2D = $游戏管理
@onready var game_over_label: Label = $GUI/结束界面/HBoxContainer/VBoxContainer/Label

# 得分
var score := 0
# 砖块数量
var brick_count := 0

func _ready() -> void:
	initial_game()
	game_world.process_mode = Node.PROCESS_MODE_DISABLED

# 初始化游戏
func initial_game():
	start_screen.visible = true
	over_screen.visible = false
	countdown_screen.visible = false

# 开始游戏
func start_game():
	start_screen.visible = false
	over_screen.visible = false
	countdown_screen.visible = false
	reset_game()
	await start_countdown()
	game_world.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().physics_frame
	await get_tree().physics_frame
	ball.launch()
	dead_area.set_deferred("monitoring", true)

# 游戏结束
func game_over():
	over_screen.visible = true
	final_score_label.text = "得分： " + str(score)
	game_world.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	dead_area.set_deferred("monitoring", false)

# 重置游戏数据
func reset_game():
	ball.reset()
	baffle.reset()
	score = 0
	brick_count = 0
	brick_area.generate_bricks()
	update_score_display()

# 开始游戏时倒计时
func start_countdown():
	start_screen.visible = false
	over_screen.visible = false
	countdown_screen.visible = true
	
	for i in range(3, 0, -1):
		countdown_screen_label.text = str(i)
		countdown_screen_label.scale = Vector2.ZERO
		var tween = create_tween()
		tween.tween_property(countdown_screen_label, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
		AudioManager.play_countdown_timing()
		await get_tree().create_timer(1.0).timeout
	
	countdown_screen_label.text = "开始！"
	AudioManager.play_countdown_timeout()
	await get_tree().create_timer(0.5).timeout
	
	countdown_screen.visible = false

# 更新当前得分显示
func update_score_display():
	score_label.text = "当前得分： " + str(score)
	brick_count_label.text = "剩余砖块： " + str(brick_count)

func _on_死亡区域_body_entered(body: Node2D) -> void:
	if body.name == "球":
		game_over_label.text = "游戏结束"
		AudioManager.play_game_fail()
		game_over()

func _on_开始按钮_pressed() -> void:
	start_game()

func _on_重开按钮_pressed() -> void:
	start_game()

func _on_砖块区域_update_score(score_value: int) -> void:
	score += score_value
	brick_count -= 1
	update_score_display()
	if brick_count <= 0:
		game_over_label.text = "WIN !!!"
		AudioManager.play_game_win()
		game_over()

func _on_砖块区域_update_brick_count(count: int) -> void:
	brick_count = count
