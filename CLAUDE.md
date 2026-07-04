# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of OpenSCAD 3D models for practical objects (hooks, brackets, holders, cases, etc.). Each `.scad` file is typically a standalone parametric model that generates an STL for 3D printing.

## Commands

This computer has the latest nightly build of OpenSCAD. For all command line options look at [these docs](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_OpenSCAD_in_a_command_line_environment)

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

## Export as 3MF (with colors, for Bambu Studio)

Export with `material-type=basematerial` (NOT `color` — Bambu Studio 2.5+ mishandles
per-triangle color data), then run the fixer script to lift colors to the object level:

```bash
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -o output.3mf -O export-3mf/material-type=basematerial --enable all input.scad
python3 fix_3mf_colors.py output.3mf
```

Requirements for the .scad file:
- Each color must be a separate top-level statement (lazy-union makes each one its own 3MF object)
- Every object must be a single uniform color

`fix_3mf_colors.py` (repo root) rewrites the 3MF so each object references one
basematerial with no per-triangle properties — the structure slicers import reliably.
In Bambu Studio, choose "Import as multiple objects" when prompted.

### Export as an image

```bash
# Front view (X-axis aligned)
OpenSCAD -o design_front.png --render --imgsize=1200,1200 --viewall --autocenter --camera=80,0,0,60,0,0,120 design.scad

# Side view (Y-axis aligned)
OpenSCAD -o design_side.png --render --imgsize=1200,1200 --viewall --autocenter --camera=0,80,0,60,0,90,120 design.scad

# Top view (Z-axis aligned)
OpenSCAD -o design_top.png --render --imgsize=1200,1200 --viewall --autocenter --camera=0,0,80,0,0,0,120 design.scad
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
