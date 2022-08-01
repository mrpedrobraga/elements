# Elements

Greetings.

Elements is an asset editor for games and similar projects, created to be simple and powerful.

It started as a pixel art editor (with capabilities to paint normal and uv maps) and evolved into something more abstract.

It's built with simplicity, power and comfort in mind by making use of elegant emergent systems in its set of features.

Elements is made on top of [Godot Engine](https://github.com/godotengine), using Vulkan as its graphics renderer -- it's quite fast.

The entire editor is basically a simple abstraction that allows the user to comunicate with Vulkan in a high-level way, and making good use of GPU parallelization.

It also has many export templates that allows you to control precisely memory usage in your images (image formats), encryption and layouts.

> Futurely, you should be able to export some layers as ready-to-use Godot resources!

This project is and should remain being FOSS.
You can download the source, make any changes, and distribute it under the same license.

You can support me by donating / contributing.

# Platforms

- Windows
- Linux and its thousands of Distros
- Mac OS
- Android -- YES!!!
- Web (Not yet implemented)

# Requirements

- Some Memory
- Vulkan Support (you probably have it anyway)
- An editing peripheral (mouse cursor, keyboard, graphics tablet, touch screen)

# Features

## User Interface

The editor comes with a simple UI, with different docks to edit your project.

![The Main UI View](/docs/ui-1.png)

The docks are customizable -- you can change their visibility and position to be however you'd like.

You can even make them float to make good use of multiple windows.

## Layers

Layers are instances of data. There are many layer types that can hold multiple kinds of data.

- *RasterLayer* can hold pixel-based data such as pixel colours, normal maps, UV maps, lightmaps, depthmaps, palette indexes, etc.

- *GroupLayer* holds several layers inside and merges them into one single image. It's like a folder.

- *ShapeLayer* can hold triangles, circles, rectangles and other kinds of cool vector shapes.

- *ShapeGroupĹayer* can hold several *ShapeLayer*s, like a folder, to be edited together (like in MS. Powerpoint) you can also merge them using boolean operations.

- *TilemapLayer* allows you to edit a tilemap as well as place tiles around (and export these tiles in a special file format.

- *LayerReference* allows you to reference a layer's data effectively working as a duplicate that updates dynamically.

There are many more types of Layers (*3DMesh*, *Tileset*, *BitmapFont*, *Gizmo*, *Parameter*, and so on.

## Palette

You can choose a main document palette, but also override a palette for each layer.

Palettes are 2D and will allow you to freely organize your colours however you want.

You can then sample from them directly with the mouse (or your finger), or change between entries with Alt+ScrollWheel, Alt+Arrows, VolumeUP/Down.

You can export your document (or a layer) as a true indexed image format (each pixel will be an integer instead of 4 floats) saving precious memory and allowing for fast palette swap.

## Sampler

The sampler allows you to sample data to paint on your layer. It's tipically a Color Picker since that's what you'll be doing the most... but it can change depending on the layer's type.

For example, for NormalMapLayer the sampler will show a circle and will let you pick a normal from it to paint. You can also add test lights and it will react to it.

For TilemapLayer, the sampler will show the list of available tiles.

## Tools

Tools are scripts that react to user input and can change layer data. The visible tools change depending on the selected layer...

Here are some commonly used tools.

- Brush (for painting)
- Select (for Selecting things)
- Shape (For adding shapes)
- Floodill (For floodfilling a closed area with colour)
- Replace (For replacing a colour with another)
- Interact (for clicking on things)
- Pan (for panning around)
- Zoom (for zooming on things)

There's also polymorphism, allowing "the same tool" to edit two different kinds of layers (the brush tool can edit pixels on a RasterLayer, tiles in a TilemapLayer, paint vertices or textures in a 3DMeshLayer and so on).

## Animation

You can animate essentially everything by creating an animation and an animation track.

An animation can have multiple tracks,,, each animation can also contain children animations.

You can animate:

- Layer Data (For example, cells in RasterDataLayer)
- Layer Properties (Opacity, Transform, etc)
- Layer Modifier Parameters
- Numerical Values
- Gizmos (Light positions, etc)
- Animations (Which animations are currently playing)

You create a keyframe in an animation track that has each frame's data.

Animation tracks can be:

- *LinearTrack*: Organize keyframes on a line and choose the current frame based on a numerical value (usually Time).
- *PlanarTrack*: Organize keyframes on a plane and choose the current frame based on two numerical values.
- *StateMachineTrack*: Organize keyframes to be selected depending on the state of a state machine.

> This whole system is simple and easy to set up, but allows for super powerful animations.

## Scripting

All the default tools, layers, gizmos, etc are classes written in a consistent API.

You can edit them or create your own by using GDScript/C#/GLSL and creating an addon.

> I may futurely add bindings for Python, Lua, C++ or Rust. If it's requested... I do recommend using GDScript, though, it's the most well integrated one.

You create:

- Custom Layer Types
- Custom Layer Modifiers (using Shaders, too!)
- Custom Modifier Nodes
- Custom Importers / Exporters
- Processes that add general extra code into the engine.
- New Panels, Docks, Gizmos

> Remember that the editor itself is created using the same API that addon makers use,,, so anything natively possible in Elements can be added via addons.

Addons are easy to write, share and use...

# Closing Notes

Elements is the first project of a programs suite intended to empower people to make their dreams giving them all the power they will ever need in a simple, friendly, comfortable user interface.

Together we can destroy the industry of super-expensive predatory software and unleash our creativity.

Regards, Pedro Braga.
