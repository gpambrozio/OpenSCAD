$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

inch = 25.4;

w = 1.5 * inch;
d = 21;
h = 3;
hole = 0.25 * inch;

difference() {
    union() {    
        translate([0, -18, 0]) import("/Users/gustavoambrozio/Dropbox/MyDocuments/3DModels/OpenSCAD/DSO-203_holder/DSO203_5.STL", convexity=3);
        translate([21, 0, h/2]) roundedBox([d, w, h], radius=1);
    }
    translate([22, 0.5 * inch, -1]) rotate([0, 0, 0]) cylinder(d=hole, h=h+2);
    translate([22, -0.5 * inch, -1]) rotate([0, 0, 0]) cylinder(d=hole, h=h+2);
}
