# Elements

Elements is an asset editor for games and similar projects, created to be simple and powerful.

It started as a pixel art editor (with capabilities to paint normal and uv maps) and evolved into something more abstract.

It's built with simplicity, power and comfort in mind by making use of elegant emergent systems in its set of features.

Elements is made on top of [Godot Engine](https://github.com/godotengine), using Vulkan as its graphics renderer -- it's quite fast.

The entire editor is basically a simple abstraction that allows the user to comunicate with Vulkan in a high-level way, and making good use of GPU parallelization.

# Features

## User Interface

The editor comes with a simple UI, with different docks to edit your project.

![The Main UI View](/docs/ui-1.png)

The docks are customizable -- you can change their visibility and position to be however you'd like.

You can even make them float to make good use of multiple windows.

1. In the center, you have the **canvas**. It's the area where things will be rendered, and where you'll edit each layer's data.

2. In the center right, you have the **toolbar**. It's where you can select which tool you're currently using.

3. In the top left, you have the menus where you can:
	- Open, Save, Export files and directories.
	- Edit your document in special ways.
	- Change the current layout of the UI.
	- Use power tools such as scripting or theme.

4. Underneath the menu there is the **palette** view, which allows you to choose the current palette to be displayed. You can pick colours from it.

5. The Tool dock has the properties for the tool that's currently being used. For the Brush tool, for example, you can set the brush script, brush size, etc.

6. The Workspace dock shows you the contents of a folder you previously selected as the workspace for your project. There you can quickly move files, create new folders and wire exports of contents of each layers to separate files.

7. The Sampler dock shows you the current data picker depending on your layer's data type. For example: For RasterLayer it's usually colours... but if your Layer houses a normal map it'll show a normal picker instead.

8. The Patterns dock will show patterns of data that can be reused. Stencils for RasterLayer, patterns of tiles for TileLayer, and so on.

9. The Animation dock will let you animate layer's data and properties, project properties, gizmos, lights and even the palette.
