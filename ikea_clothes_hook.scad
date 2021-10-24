$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

width = 8;

support_d = 11.1;
support_extension = 14;
thickness = 4.4;

support_angle = 5;
support_bump_distance_from_edge = 27;
support_bump_size = 0;
support_bump_distance = support_bump_distance_from_edge - support_d / 2 + support_bump_size;
support_height = support_bump_distance + support_bump_size;

hook_d = 20;
hook_extension = 10;
height = 35;

difference() {
    cylinder(d = support_d + thickness * 2, h = width);
    translate([0, 0, -1]) cylinder(d=support_d, h=width+2);
    translate([0, 0, -1]) cube([support_d + 2, support_d + thickness * 2 + 2, width + 2]);
    rotate([0, 0, -support_angle]) translate([-support_d - 2, 0, -1]) cube([support_d + 2, support_d + thickness * 2 + 2, width + 2]);
}

translate([support_d/2, 0, 0]) cube([thickness, height, width]);

translate([-support_d/2, 0, 0]) 
rotate([0, 0, -support_angle])
union() {
    translate([-thickness, 0, 0]) cube([thickness, support_height, width]);
    translate([0, support_bump_distance, 0]) rotate([0, 0, 0]) cylinder(r=support_bump_size, h=width);
}

translate([hook_d /2 + thickness + support_d/2, height, 0])
rotate([0, 0, 180])
difference() {
    cylinder(d = hook_d + thickness * 2, h = width);
    translate([0, 0, -1]) cylinder(d=hook_d, h=width+2);
    translate([-hook_d /2 - thickness - 1, 0, -1]) cube([hook_d + thickness * 2 + 2, hook_d + thickness * 2 + 2, width + 2]);
}

translate([hook_d + thickness + support_d / 2, height - hook_extension, 0]) cube([thickness, hook_extension, width]);

