$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

height = 22.5;
spacing = 5;
ext_d_depth = 3;

paste_int_d = 18;
paste_ext_d = 27;
paste_ext_spacing = 47;

brush_int_d = 14;
brush_int_d2 = 9;
brush_ext_d = 14;

small_brush_d = 8;
small_brush_depth = 12;

// Calculated
total_width = 3 * spacing + paste_ext_spacing + brush_ext_d;
total_depth = 2 * spacing + max(paste_ext_d, brush_ext_d);

difference() {
    translate([total_width, total_depth, height] / 2) roundedBox([total_width, total_depth, height], radius = 4, sidesonly = true);
    
    translate([spacing + paste_ext_spacing / 2, total_depth / 2, -1]) cylinder(d=paste_int_d, h = height + 2);
    translate([spacing + paste_ext_spacing / 2, total_depth / 2, height - ext_d_depth]) cylinder(d=paste_ext_d, h = height);
    
    translate([spacing * 2 + paste_ext_spacing + brush_int_d / 2, total_depth / 2, -1]) cylinder(d1=brush_int_d2, d2=brush_int_d, h = height + 2);
    
    translate([spacing * 2 + paste_ext_spacing * 3/4 + brush_int_d / 4, total_depth / 4, height-small_brush_depth+1]) cylinder(d=small_brush_d, h = small_brush_depth+1);
}

