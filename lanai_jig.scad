$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

inch = 25.4;

hole_dist = 4 * inch;
border_dist = 3 * inch;
hole_d = 4.85;

lag = 0.2 * inch;
d = 0.4 * inch;
thickness = 2.5;
notch = 4;

w = 2 * lag + hole_d;
h = hole_dist + border_dist + lag;

union() {
    difference() {
        union() {
            translate([-w/2, 0, 0]) cube([w, h, thickness]);
            translate([0, h-thickness, 0]) rotate([0, 0, 45]) cube([notch, notch, thickness]);
        }
        translate([0, border_dist, -1]) cylinder(d=hole_d, h=thickness+2);
        translate([0, border_dist + hole_dist, -1]) rotate([0, 0, 0]) cylinder(d=hole_d, h=thickness+2);
        translate([-w/2, h-2*thickness, -1]) rotate([0, 0, 45]) cube([w, w, thickness+2]);
        translate([ w/2, h-2*thickness, -1]) rotate([0, 0, 45]) cube([w, w, thickness+2]);
    }
    difference() {
        translate([-w/2, -thickness, 0]) cube([w, thickness, d + thickness]);
        translate([0, 0, d]) rotate([0, -45, 0]) translate([0, -thickness-1, 0]) cube([notch, thickness + 2, notch]);
    }
}