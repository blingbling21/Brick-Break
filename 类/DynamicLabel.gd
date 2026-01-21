@tool

class_name DynamicLabel extends Label

@export var trans_key: String = "":
	set(value):
		trans_key = value
		update_text()

# 显示的动态数据
var data: Array = [0]
var current_key: String = ""

func _ready() -> void:
	current_key = trans_key

# 设置文本
func set_msg(key: String):
	current_key = key
	data = []
	update_text()

# 设置动态数据
func set_data_msg(key: String, args: Array):
	current_key = key
	data = args
	update_text()

# 更新文本
func update_text():
	if current_key.is_empty():
		return
	if data.is_empty():
		text = tr(current_key)
	else:
		text = tr(current_key) % data

# 发生语言更改时触发文本自动翻译
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		update_text()
