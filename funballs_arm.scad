$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

arm_width = 10;
arm_length = 120;
string_hole_d = 2;
string_distance = 8;

engine_hole_d = 4.1;
engine_hole_distance = 8;
engine_hole_notch = engine_hole_d - 3.4;

engine_screw_d = 4;
engine_bolt_d = 8;
engine_bolt_depth = 2.5;

engine_screw_center = engine_hole_distance+engine_screw_d/2+engine_hole_d/2-engine_hole_notch;

difference()
{
    translate([-arm_width/2,0,-arm_width/2]) cube([arm_width, arm_length, arm_width]);
    translate([0,arm_length-string_distance,-arm_width/2-1]) cylinder(d=string_hole_d, h = arm_width+2);
    translate([0,engine_hole_distance,-arm_width/2-1]) cylinder(d=engine_hole_d, h = arm_width+2);
    translate([-arm_width/2-1,engine_screw_center,0]) rotate([0,90,0]) cylinder(d=engine_screw_d, h = arm_width+2);
    #translate([arm_width/2-engine_bolt_depth/2+1,engine_screw_center,0]) rotate([0,90,0]) cylinder(d=engine_bolt_d,h=engine_bolt_depth+1,center=true,$fn=6);
}
