# Godot Template

A template for a Godot game in GDScript. It starts as a 2D game with static typing enforced, `gdtoolkit` for format and lint, and a headless test runner. A short procedure turns it into a 3D game. It starts from [github-project-template](https://github.com/tabmadi/github-project-template), so it has the same hooks, CI gate, and documentation convention.

## Stack

| Tool | Owns |
| --- | --- |
| [Godot](https://godotengine.org) | The engine and the editor |
| [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit) | `gdformat` and `gdlint` for GDScript |
| [uv](https://docs.astral.sh/uv/) | Installs gdtoolkit for mise |
| [mise](https://mise.jdx.dev) | Tool versions and tasks |
| [lefthook](https://github.com/evilmartians/lefthook) | Git hooks |
| [cocogitto](https://docs.cocogitto.io) | Conventional Commits checks |
| [rumdl](https://github.com/rvben/rumdl) | Markdown lint |
| [gitleaks](https://github.com/gitleaks/gitleaks) | Secret scan |
| [Renovate](https://docs.renovatebot.com) | Updates to the pinned versions |

## Getting started

1. Install [mise](https://mise.jdx.dev/getting-started.html).
2. Clone the repo and install the tools, the import cache, and the hooks:

   ```bash
   git clone git@github.com:tabmadi/godot-template.git
   cd godot-template
   mise install
   mise run setup
   ```

3. Open the project in the pinned editor:

   ```bash
   mise run edit
   ```

## Tasks

| Task | Does |
| --- | --- |
| `mise run setup` | Imports the project and installs the git hooks |
| `mise run import` | Imports the assets and builds the `.godot` cache |
| `mise run edit` | Opens the project in the Godot editor |
| `mise run run` | Runs the game |
| `mise run format` | Applies every formatter |
| `mise run lint` | Runs `lint:gd`, `lint:md`, and `lint:secrets` |
| `mise run test` | Runs the tests headless |
| `mise run check` | Runs `lint` and `test`. Run it before you finish a change |
| `mise run ci` | Runs exactly what CI runs. The `pre-push` hook runs it too |

## Layout

```text
.
├── scenes/               Each scene with its script next to it
│   ├── main.tscn         The main scene
│   └── main.gd           Its script
├── tests/
│   ├── runner.gd         The headless test runner
│   ├── test_case.gd      The base class of every test file
│   └── test_main.gd      The tests for the main scene
├── docs/
│   ├── adr/              The decisions: foundations, doc conventions, toolchain
│   └── switch-to-3d.md   The steps to start a 3D game
├── project.godot         The project settings
├── gdlintrc              The gdlint config
├── .mise.toml            Tool pins and tasks
└── .lefthook.yml         Git hooks
```

## Using this template

1. Create a repository from this template on GitHub.
2. Change `config/name` in `project.godot`.
3. For a 3D game, follow [docs/switch-to-3d.md](docs/switch-to-3d.md).
4. Replace `scenes/main.gd` and its tests with your own code.
5. Update the contacts in `SECURITY.md` and the copyright line in `LICENSE`.
6. Install the [Renovate app](https://github.com/apps/renovate) on the new repository.

## Decisions

The ADRs in [docs/adr](docs/adr/README.md) record every decision and the reason for it. [ADR-0001](docs/adr/0001-documentation-conventions.md) is the house style for all text.

## Contributing

Follow the [Code of Conduct](CODE_OF_CONDUCT.md). Commit messages follow [Conventional Commits](https://www.conventionalcommits.org), and the `commit-msg` hook checks them. Run `mise run check` before you open a pull request.

## Security

To report a vulnerability, follow [SECURITY.md](SECURITY.md).

## License

Apache License 2.0. See [LICENSE](LICENSE).
