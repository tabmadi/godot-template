## Tests for the main scene.
extends "res://tests/test_case.gd"

const Main := preload("res://scenes/main.gd")


func test_greeting_names_the_reader() -> void:
	assert_eq(Main.greeting("world"), "Hello world!")


func test_scene_shows_the_greeting() -> void:
	var scene: Node2D = preload("res://scenes/main.tscn").instantiate()
	var tree: SceneTree = Engine.get_main_loop()
	tree.root.add_child(scene)
	var label: Label = scene.get_node("Label")
	assert_eq(label.text, "Hello world!")
	scene.free()
