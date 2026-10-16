## The test runner. It runs every `test_*` method in every `tests/**/test_*.gd` file,
## prints one line for each test, and exits with code 1 when a test fails.
## Run it with `mise run test`.
extends SceneTree

const TESTS_DIR := "res://tests"


func _initialize() -> void:
	# The root enters the tree after this method returns. A test that adds a scene needs it.
	await process_frame
	var failed := 0
	var passed := 0
	for path in _find_tests(TESTS_DIR):
		var script: GDScript = load(path)
		if script == null or not script.can_instantiate():
			printerr("FAIL %s: the script does not load" % path)
			failed += 1
			continue
		for method in script.get_script_method_list():
			var name: String = method["name"]
			if not name.begins_with("test_"):
				continue
			var test_case: RefCounted = script.new()
			test_case.call(name)
			var failures: PackedStringArray = test_case.get("failures")
			if failures.is_empty():
				print("PASS %s:%s" % [path, name])
				passed += 1
			else:
				for failure in failures:
					printerr("FAIL %s:%s: %s" % [path, name, failure])
				failed += 1
	print("%d passed, %d failed" % [passed, failed])
	quit(1 if failed > 0 or passed == 0 else 0)


func _find_tests(dir_path: String) -> PackedStringArray:
	var paths: PackedStringArray = []
	for dir_name in DirAccess.get_directories_at(dir_path):
		paths.append_array(_find_tests(dir_path.path_join(dir_name)))
	for file_name in DirAccess.get_files_at(dir_path):
		if file_name.begins_with("test_") and file_name.ends_with(".gd"):
			paths.append(dir_path.path_join(file_name))
	return paths
