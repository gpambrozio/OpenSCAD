$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

inch = 25.4;
tolerance = 0.4;
wall_size = 2.4;
round_r = 3;

lens_dist = 11;

lens_h = 30;
lens_w = 32;

w = 62;
h = 45.5;
d = 8;

eyepiece_d = 32;
eyepiece_h = 8;

ext_add = 2 * tolerance + 2 * wall_size;
int_add = 2 * tolerance;

rotate([180, 0, 0])
difference() {
    union() {
        difference() {
            translate([0, 0, 0]) roundedBox([w + ext_add, h + ext_add, d + ext_add], radius = round_r);
            translate([0, 0, wall_size]) roundedBox([w + int_add, h + int_add, d + ext_add], radius = round_r);
        
            translate([(lens_w - w) / 2, (h - lens_h) / 2, -d / 2]) roundedBox([lens_w + int_add, lens_h + int_add, wall_size + ext_add], radius = round_r);
        }
        
        translate([(lens_w - w) / 2, (h - lens_h) / 2, -eyepiece_h - d / 2 - wall_size - tolerance]) 
        difference() {
            translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(d=eyepiece_d+ext_add, h=eyepiece_h);
            translate([0, 0, -1]) rotate([0, 0, 0]) cylinder(d=eyepiece_d+int_add, h=eyepiece_h*8);
        }
        
        translate([(lens_w - w) / 2, (h - lens_h) / 2, -eyepiece_h - d / 2 - wall_size - tolerance]) 
        difference() {
            translate([0, 0, eyepiece_h]) rotate([0, 0, 0]) cylinder(d1=eyepiece_d+ext_add, d2=0, h=eyepiece_h*6);
            translate([wall_size, -wall_size, 0]) cube([eyepiece_d+ext_add, eyepiece_d+ext_add, eyepiece_h*30], center=true);
        }
    }
    translate([(w - lens_w + wall_size) / 2, 0, 0]) cube([w - lens_w - ext_add, h - wall_size * 2, h + ext_add + 2], center=true);
}
