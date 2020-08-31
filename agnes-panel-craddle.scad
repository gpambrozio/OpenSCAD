$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

inch = 25.4;
tollerance = 2;

round_r = 3;

panel_w = 64.2;
panel_h = 117.7;
panel_base_shift = 12;

angle = acos(panel_base_shift / panel_h);

slot_w = panel_w + tollerance * 2;

craddle_w = panel_w + round_r * 2 + tollerance * 2;
craddle_h = 8;
craddle_d = 25;

correction_y = craddle_d / 2 - panel_base_shift;
correction_z = 0;

difference() {   
    union() {
        roundedBox([craddle_w, craddle_d, craddle_h], radius = round_r);
        translate([0, 0, -craddle_h/4]) roundedBox([craddle_w, craddle_d, craddle_h/2], radius = round_r, sidesonly=true);
    }
    
    aux = 40;
    translate([0, correction_y, correction_z]) rotate([angle, 0, 0]) translate([0, aux/2, aux/2]) cube([slot_w, aux, aux], center=true);
}