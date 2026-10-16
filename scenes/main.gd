## The main scene. It shows a greeting in the middle of the screen.
extends Node2D

@onready var _label: Label = $Label


func _ready() -> void:
	_label.text = greeting("world")


## Returns the greeting for [param who].
static func greeting(who: String) -> String:
	return "Hello %s!" % who
