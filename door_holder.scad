$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

l = 90;
d = 30;
hook = 20;
tooth = 3;
round_r = 1;

thickness = 3.4;
h = 15;

union() {
    translate([0, 0, 0]) roundedBox([l+thickness*2, thickness, h], radius = round_r);
    translate([-thickness/2-l/2, d/2, 0]) roundedBox([thickness, d+thickness, h], radius = round_r);
    translate([thickness/2+l/2, d/2+thickness/2, 0]) roundedBox([thickness, d+thickness*2, h], radius = round_r);
    translate([l/2-hook/2+thickness/2, d+thickness, 0]) roundedBox([hook+thickness, thickness, h], radius = round_r);
    translate([-l/2, d+thickness-thickness, 0]) roundedBox([tooth+thickness, thickness, h], radius = round_r);
}

l2 = l + 50;
*translate([0, d*2, 0]) 
union() {
    translate([0, 0, 0]) roundedBox([l2+thickness*2, thickness, h], radius = round_r);
    translate([-thickness/2-l2/2, d/2, 0]) roundedBox([thickness, d+thickness, h], radius = round_r);
    translate([thickness/2+l2/2, d/2+thickness/2, 0]) roundedBox([thickness, d+thickness*2, h], radius = round_r);
    translate([l2/2-hook/2+thickness/2, d+thickness, 0]) roundedBox([hook+thickness, thickness, h], radius = round_r);
}
