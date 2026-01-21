extends Resource

class_name BrickData

@export_group("基础属性")
@export var name := "普通砖块"
@export var color := Color.WHITE
@export var score := 1
@export var hp := 1

@export_group("生成规则")
@export var spawn_chance := 0.5
