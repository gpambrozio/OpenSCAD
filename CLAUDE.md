# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of OpenSCAD 3D models for practical objects (hooks, brackets, holders, cases, etc.). Each `.scad` file is typically a standalone parametric model that generates an STL for 3D printing.

## Commands

### Preview/Render in OpenSCAD GUI
```bash
open -a OpenSCAD filename.scad
```

### Command-line STL export
```bash
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o output.stl input.scad
```

### Export with custom parameters
```bash
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o output.stl -D 'width=10' -D 'height=20' input.scad
```

## Available Libraries

- **MCAD** (git submodule): Standard library with boxes, gears, bearings, shapes, hardware
  - Common: `use <MCAD/boxes.scad>`, `use <MCAD/involute_gears.scad>`
- **BOSL2**: Comprehensive library for attachments, beziers, threading, distributors
  - Include via: `include <BOSL2/std.scad>`
- **write/**: Text rendering library for embossing/engraving text
- **MinkowskiRound/**: Rounding utilities using minkowski operations

## Code Conventions

- Quality settings at file top: `$fa=0.5; $fs=0.5;` (or `$fn=75` for fixed resolution)
- Dimensions in millimeters
- Parameters defined as variables at top of file for easy customization
- Customizer-compatible files use special comment syntax:
  ```openscad
  /* [Section Name] */
  param = default; // [min:step:max] or [option1, option2]
  ```
- Use `difference()` for subtractive operations, `union()` for combining
- Use `hull()` for creating smooth transitions between shapes
