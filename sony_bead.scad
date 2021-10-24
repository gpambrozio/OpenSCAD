$fa=0.02; // default minimum facet angle
$fs=0.02; // default minimum facet size

use <MCAD/boxes.scad>;

w = 4;
h = 2;
d = 2;
hole_d = 0.9;
round_r = 0.2;

difference() {
    roundedBox([w, d, h], radius = round_r);
    translate([w/4, 0, -h/2-1]) cylinder(d=hole_d, h = h + 2);
    translate([-w/4, 0, -h/2-1]) cylinder(d=hole_d, h = h + 2);
}