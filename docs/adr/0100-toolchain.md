# ADR-0100: Toolchain

**Status:** Accepted
**Decides:** The pinned toolchain, the task surface, what runs at commit and push time, how the pins stay current, and how a release is tagged.

## Context

The value of a template is that its tool choices are made and reproducible. Three failures matter. The first is a tool that resolves from `$PATH`, at the version the machine has. The second is a check that only CI runs, which every local commit passes. The third is a pin that nobody updates.

A Godot project adds one more failure. The engine version on each machine is often different, and the editor rewrites `project.godot` for the version that opens it.

## Decision

`mise` pins every tool and is the only command surface. A command is `mise run <task>`.

| Tool | Owns |
| --- | --- |
| godot | The engine and the editor, from the official release |
| uv | Installs gdtoolkit for the `pipx` backend of mise |
| gdtoolkit | `gdformat` formats GDScript, and `gdlint` lints it |
| lefthook | Git hooks |
| cocogitto | Commit message shape |
| rumdl | Markdown style |
| gitleaks | Secret scanning |
| Renovate | Updates to the pins |

| Task | Does |
| --- | --- |
| `import` | Imports the assets and builds the `.godot` cache |
| `setup` | Runs `import` and installs the git hooks |
| `run` | Runs the game |
| `edit` | Opens the project in the editor |
| `format` | Applies every formatter |
| `lint` | Runs every linter |
| `test` | Runs the tests headless |
| `check` | Runs `lint` and `test`. It is the gate before a change is finished |
| `ci` | Runs `import` and `check`, exactly what CI runs |

`gdlint` runs with its default rules. `gdlintrc` only excludes `.godot/` and `addons/`. `gdformat` does not read `gdlintrc`, so `gdformatrc` excludes the same directories and keeps the default settings. The tests need the `.godot` cache, so `ci` runs `import` first.

A hook has no active mise shell, so each hook command runs its tool through `mise x` or a `mise` task. The `pre-commit` hook runs `gdformat` and `gdlint` on the staged GDScript, and `rumdl` and `gitleaks`. The `pre-push` hook runs `cog check` on the commits that the push adds, and `mise run ci`.

The CI workflow runs `mise run ci` on every push to `master` and on every pull request. On a pull request, it also verifies the title with `cog`. Renovate opens a pull request for a new tool or Action version, and the CI gate decides.

### Releases

A release is a git tag in [CalVer](https://calver.org/): `vYYYY.0M.MICRO`. The first release in a month has `MICRO` 0, and each later release in that month adds 1.

A game copies the template once, at a release tag, and does not take later releases. No consumer depends on a compatibility promise, so the version states only the date of the release.

## Consequences

The editor that `mise run edit` opens is the pinned version. An editor from another source can write a different `config/features` version into `project.godot`.

A new Godot minor version is a Renovate pull request. The CI gate imports and tests the project on it before the merge.

Renovate needs the Renovate GitHub app on the repository. Without it, the pins go stale.

## Rules

- Every tool is pinned in `.mise.toml`. No tool is resolved from `$PATH`.
- Every command is a `mise` task with a `description`. A CI workflow step calls a task, never a tool directly.
- A git hook runs every tool through `mise x` or a `mise` task.
- GDScript is formatted by `gdformat`, and passes `gdlint`. `(CI: lint:gd)`
- `gdlintrc` and `gdformatrc` exclude the same directories.
- The project opens only in the pinned Godot version.
- Commit messages and pull request titles follow Conventional Commits with the type set in `cog.toml`. `(ref: Conventional Commits 1.0.0)`
- `mise run check` passes before a change is finished.
- A workflow never puts event text, such as a pull request title, directly into a `run` script.
- A release is a git tag `vYYYY.0M.MICRO`. `(ref: CalVer)`
