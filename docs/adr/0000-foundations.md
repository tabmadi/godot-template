# ADR-0000: Foundations

**Status:** Accepted
**Decides:** What this repo is, its layout, its GDScript conventions, and the ADR process itself.

## Context

A Godot game starts with the same choices every time: the folder layout, the renderer, the formatter and linter, and a way to run tests outside the editor. Each choice has several common answers, and a mix of them costs time on every game. A template makes these choices once, so a new game starts at its first feature.

2D and 3D games use the same toolchain. They differ in a few project settings and in the root node of the main scene. Two templates for this difference make two copies of the toolchain that drift.

## Decision

This repo is a Godot template for a game in GDScript. It starts from [github-project-template](https://github.com/tabmadi/github-project-template) and adds the Godot toolchain. The sample scene shows the structure. It is not a feature set.

| Path | Holds |
| --- | --- |
| `project.godot` | The project settings. The editor writes it |
| `scenes/` | Each scene with its script next to it, in `snake_case` |
| `tests/` | The test runner, the test base class, and the `test_*.gd` files |
| `addons/` | Third-party Godot plugins, when the game adds one |
| `docs/` | The procedures, such as [switching to 3D](../switch-to-3d.md) |

**2D is the default.** The renderer is Compatibility, and the stretch mode is `canvas_items`. A 3D game changes the settings in [docs/switch-to-3d.md](../switch-to-3d.md).

**GDScript is the one language.** C# needs .NET and a different toolchain, so it is out of scope for this template.

**Every declaration has a static type.** `project.godot` makes an untyped declaration an error, and an unsafe access a warning.

**The test runner is part of the repo.** `tests/runner.gd` is a small `SceneTree` script. It runs every `test_*` method in every `tests/**/test_*.gd` file, and exits with code 1 when a test fails. A test framework addon is code that `mise` cannot pin, so the template adds none.

**The editor cache is not committed.** `.godot/` is a cache that `mise run import` rebuilds. The `*.uid` files next to scripts and resources are committed, because scenes refer to them.

**Every decision is an ADR.** An ADR states what is true of the repo. It is law, not a plan. Planned work lives in an untracked `*.local.md` file.

## Consequences

A test that needs a scene adds it to the tree through `Engine.get_main_loop()`. The runner waits one frame before the tests start, so the root is in the tree.

A game that needs mocks, parameterized tests, or a test report adds a framework such as GUT under `addons/`. That game then records the change in an ADR.

A generated game inherits these ADRs. So an ADR is written for the engineer who maintains the game. Selection guidance belongs in the root `README.md`.

## Rules

- A scene and its script are in the same folder, with the same `snake_case` name.
- Every declaration has a static type. `(CI: test)`
- Tests live under `tests/`, in files named `test_*.gd` that extend `tests/test_case.gd`.
- `.godot/` is never committed. A `*.uid` file is always committed.
- `gdlint` and `gdformat` skip `addons/`. Third-party code keeps its own style.
- Every ADR carries a `Status`, a one-sentence `Decides` line, and a flat `Rules` section.
- Planned work lives in an untracked `*.local.md` file. No committed file links to one.
