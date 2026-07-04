#!/usr/bin/env python3
"""Post-process an OpenSCAD 3MF export for reliable color import in Bambu Studio.

OpenSCAD nightlies export colors as per-triangle property overrides (pid/p1 on
every <triangle>), with every <object> defaulting to an unused "Default"
material. Bambu Studio 2.5+ converts per-triangle colors into Color Painting
and mishandles them. Slicers reliably import the simpler structure of one
basematerial per object with no per-triangle properties, so this script:

  1. Lifts each object's (uniform) triangle color up to the object's pindex.
  2. Strips all per-triangle pid/p1 attributes.
  3. Drops unused entries from <basematerials>, remapping indices.

Usage: fix_3mf_colors.py input.3mf [output.3mf]   (in-place if no output)
"""

import re
import sys
import zipfile

MODEL_PATH = "3D/3dmodel.model"


def fix_model(xml: str) -> str:
    # Parse the basematerials palette.
    palette_match = re.search(r"<basematerials[^>]*>(.*?)</basematerials>", xml, re.DOTALL)
    if not palette_match:
        raise SystemExit("No <basematerials> found - export with -O export-3mf/material-type=basematerial")
    bases = re.findall(r"<base [^>]*/>", palette_match.group(1))

    # Resolve each object's color from its triangles and strip triangle overrides.
    used_indices = []

    def fix_object(match: re.Match) -> str:
        obj = match.group(0)
        p1s = set(re.findall(r'p1="(\d+)"', obj))
        pindex_match = re.search(r'pindex="(\d+)"', obj)
        if len(p1s) > 1:
            raise SystemExit("Object has mixed triangle colors; cannot lift to object level")
        index = int(p1s.pop()) if p1s else int(pindex_match.group(1)) if pindex_match else 0
        used_indices.append(index)
        obj = re.sub(r'(<object [^>]*pindex=")\d+(")', rf"\g<1>{index}\g<2>", obj, count=1)
        obj = re.sub(r'(<triangle [^>]*?) pid="\d+" p1="\d+"', r"\1", obj)
        return obj

    xml = re.sub(r"<object .*?</object>", fix_object, xml, flags=re.DOTALL)

    # Rebuild the palette with only used colors, remapping object pindex values.
    kept = sorted(set(used_indices))
    remap = {old: new for new, old in enumerate(kept)}
    new_palette = palette_match.group(0).replace(
        palette_match.group(1), "\n\t\t\t" + "\n\t\t\t".join(bases[i] for i in kept) + "\n\t\t"
    )
    xml = xml.replace(palette_match.group(0), new_palette)
    xml = re.sub(r'(<object [^>]*pindex=")(\d+)(")', lambda m: f"{m.group(1)}{remap[int(m.group(2))]}{m.group(3)}", xml)
    return xml


def fix_file(path_in: str, path_out: str) -> None:
    with zipfile.ZipFile(path_in) as zin:
        entries = {name: zin.read(name) for name in zin.namelist()}
    entries[MODEL_PATH] = fix_model(entries[MODEL_PATH].decode("utf-8")).encode("utf-8")
    with zipfile.ZipFile(path_out, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in entries.items():
            zout.writestr(name, data)


if __name__ == "__main__":
    if len(sys.argv) not in (2, 3):
        raise SystemExit(__doc__)
    fix_file(sys.argv[1], sys.argv[2] if len(sys.argv) == 3 else sys.argv[1])
