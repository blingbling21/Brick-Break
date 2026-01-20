class_name SoundButton extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_hover)
	pressed.connect(_on_mouse_click)


func _on_mouse_hover():
	AudioManager.play_mouse_hover()

func _on_mouse_click():
	AudioManager.play_mouse_click()
