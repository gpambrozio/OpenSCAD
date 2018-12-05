$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

holes_distance = 140;

arm_width = 10;
string_hole_d = 3;
string_distance = 8;

engine_hole_d = 4.3;
engine_hole_distance = 14;
engine_hole_notch = engine_hole_d - 4;

arm_length = holes_distance + engine_hole_distance + string_distance;

engine_screw_d = 3;
engine_bolt_d = 6.7;
engine_bolt_w = 6.1;
engine_bolt_depth = 2.7;

engine_screw_center = engine_hole_distance+engine_screw_d/2+engine_hole_d/2-engine_hole_notch;

difference() {
    union() {
        difference()
        {
            translate([-arm_width/2,0,-arm_width/2]) cube([arm_width, arm_length, arm_width]);
            translate([0,arm_length-string_distance,-arm_width/2-1]) cylinder(d=string_hole_d, h = arm_width+2);
            translate([0,engine_hole_distance,-arm_width/2-1]) cylinder(d=engine_hole_d, h = arm_width+2);
            //translate([-arm_width/2-1,engine_screw_center,0]) rotate([0,90,0]) cylinder(d=engine_screw_d, h = arm_width+2);
            //translate([arm_width/2-engine_bolt_depth/2+1,engine_screw_center,0]) rotate([0,90,0]) 
        }
        translate([-arm_width/2,engine_hole_distance-engine_hole_d/2,-arm_width/2]) cube([arm_width, engine_hole_notch, arm_width]);
    }
    translate([0,-1,0]) rotate([-90,0,0]) cylinder(d=engine_screw_d, h = engine_hole_distance);
    translate([0,engine_hole_distance/2,0]) rotate([90,30,0]) cylinder(d=engine_bolt_d,h=engine_bolt_depth,center=true,$fn=6);
    translate([0,engine_hole_distance/2,arm_width/2]) cube([engine_bolt_w, engine_bolt_depth, arm_width], center=true);
}
