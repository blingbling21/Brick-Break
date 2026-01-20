extends Node

const MOUSE_HOVER = preload("uid://cn72j4yiova3k")
const MOUSE_CLICK = preload("uid://dmhlxsq52aukb")
const GAME_WIN = preload("uid://dptlaspboesuv")
const BALL_HIT = preload("uid://b4bbtxxkwvb3u")
const GAME_FAIL = preload("uid://c8hxs07u2wmxq")
const COUNTDOWN_TIMEOUT = preload("uid://kugne0jssjt5")
const COUNTDOWN_TIMING = preload("uid://xifclk4frq1u")

@onready var sfx_mouse: AudioStreamPlayer = $鼠标
@onready var sfx_over: AudioStreamPlayer = $结束
@onready var sfx_ball_hit: AudioStreamPlayer = $球撞击
@onready var sfx_countdown: AudioStreamPlayer = $倒计时

# 播放鼠标hover音效
func play_mouse_hover():
	sfx_mouse.stream = MOUSE_HOVER
	sfx_mouse.play()

# 播放鼠标click音效
func play_mouse_click():
	sfx_mouse.stream = MOUSE_CLICK
	sfx_mouse.play()

# 播放游戏失败音效
func play_game_fail():
	sfx_over.stream = GAME_FAIL
	sfx_over.play()

# 播放游戏win音效
func play_game_win():
	sfx_over.stream = GAME_WIN
	sfx_over.play()
	
# 播放球撞击音效
func play_ball_hit():
	sfx_ball_hit.stream = BALL_HIT
	sfx_ball_hit.play()
	
# 播放倒计时计时阶段音效
func play_countdown_timing():
	sfx_countdown.stream = COUNTDOWN_TIMING
	sfx_countdown.play()
		
# 播放倒计时结束阶段音效
func play_countdown_timeout():
	sfx_countdown.stream = COUNTDOWN_TIMEOUT
	sfx_countdown.play()
