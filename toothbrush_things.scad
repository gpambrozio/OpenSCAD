$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

clip_size = 2.5;
clip_width = 5;
clip_thickness = 2;
clip_spacing = 10;

height = 20;
spacing = 5;
ext_d_depth = 3;

paste_int_d = 18;
paste_ext_d = 27;
paste_ext_spacing = 47;

brush_int_d = 25;
brush_ext_d = 36;

// Calculated
total_width = 3 * spacing + paste_ext_spacing + brush_ext_d;
total_depth = 2 * spacing + max(paste_ext_d, brush_ext_d);

difference() {
    translate([total_width, total_depth, height] / 2) roundedBox([total_width, total_depth, height], radius = 4, sidesonly = true);
    
    translate([spacing + paste_ext_spacing / 2, total_depth / 2, -1]) cylinder(d=paste_int_d, h = height + 2);
    translate([spacing + paste_ext_spacing / 2, total_depth / 2, height - ext_d_depth]) cylinder(d=paste_ext_d, h = height);
    
    translate([spacing * 2 + paste_ext_spacing + brush_ext_d / 2, total_depth / 2, -1]) cylinder(d=brush_int_d, h = height + 2);
    translate([spacing * 2 + paste_ext_spacing + brush_ext_d / 2, total_depth / 2, height - ext_d_depth]) cylinder(d=brush_ext_d, h = height + 2);
}

translate([-clip_size, clip_spacing, 0]) cube([clip_size, clip_width, clip_thickness]);
translate([-clip_size - clip_thickness, clip_spacing, 0]) cube([clip_thickness, clip_width, clip_width]);
