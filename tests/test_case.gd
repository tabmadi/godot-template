## The base class of every test file. A test file extends it and adds methods named `test_*`.
extends RefCounted

var failures: PackedStringArray = []


## Records a failure when [param actual] is not equal to [param expected].
func assert_eq(actual: Variant, expected: Variant, message: String = "") -> void:
	if actual != expected:
		_fail("expected %s, got %s" % [var_to_str(expected), var_to_str(actual)], message)


## Records a failure when [param condition] is false.
func assert_true(condition: bool, message: String = "") -> void:
	if not condition:
		_fail("expected true", message)


func _fail(reason: String, message: String) -> void:
	failures.append(reason if message.is_empty() else "%s: %s" % [reason, message])
