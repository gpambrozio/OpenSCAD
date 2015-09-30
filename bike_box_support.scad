$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

support_height = 4;
support_width = 7;
support_length = 130;

hole_diameter = 4;
hole_offset = 6;

difference() {
    union() {
        cube([support_length, support_width, support_height]);
        translate([support_length - 10, 0, -support_height]) cube([10, support_width, support_height]);
    }
    translate([support_width/2,support_width/2,-1]) cylinder(d = hole_diameter, h = 2 + support_height);
    #translate([support_length,0,-1-support_height]) rotate([0,0,20]) cube([support_width*2, support_width*2, 2 + support_height*2]); 
}
