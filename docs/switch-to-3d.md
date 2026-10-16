# Switch to 3D

The template starts as a 2D game. Follow these steps to start a 3D game instead. Do them before you add game code.

## Change the project settings

Open the project with `mise run edit`, and then open **Project > Project Settings**. Turn on **Advanced Settings**, and set these values:

| Setting | 2D value | 3D value |
| --- | --- | --- |
| Rendering > Renderer > Rendering Method | `gl_compatibility` | `forward_plus` |
| Rendering > Renderer > Rendering Method.mobile | `gl_compatibility` | `mobile` |
| Display > Window > Stretch > Mode | `canvas_items` | `disabled` |
| Physics > 3D > Physics Engine | Default | `Jolt Physics` |

The editor asks to restart after the renderer changes. Restart it.

## Replace the main scene

1. In `scenes/main.tscn`, right-click the `Main` node and select **Change Type**. Select `Node3D`.
2. Change `extends Node2D` to `extends Node3D` in `scenes/main.gd`.
3. Add a `Camera3D`, a `DirectionalLight3D`, and a `WorldEnvironment` as children of `Main`.
4. Keep the `Label` node, or delete it and the code that sets its text.

## Check the result

1. Change the scene type in `tests/test_main.gd` from `Node2D` to `Node3D`.
2. Run the gate:

   ```bash
   mise run check
   ```

3. Commit `project.godot`, the scene, and the script together.
