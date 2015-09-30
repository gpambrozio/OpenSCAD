$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

support_diameter = 23.5;
support_width = 24.5;

outside_pad = 2;
pad_width = 2;

hole_diameter = 5;
hole_offset = 6;

hole_outer_diameter = 10;

difference() {
    union() {
        cylinder(d = support_diameter, h = support_width);
        translate([0,0,support_width]) cylinder(d = support_diameter + outside_pad, h = pad_width);
    }
    translate([0,hole_offset,-1]) cylinder(d = hole_diameter, h = 2 + support_width + pad_width);
    translate([0,hole_offset,2.5]) cylinder(d = hole_outer_diameter, h = 2 + support_width + pad_width);
}
