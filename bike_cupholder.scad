$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

support_height = 20;
support_top_d = 80;
support_bottom_d = 77.5;
support_thickness = 6.0;

arm_length = 13;
arm_width = 15;

arm_diameter = 23;
arm_thickness = 5;
arm_height = 35;
arm_separation = 1;

lips_hole_diameter = 4;
lips_width = 10;

arm_offset = (support_bottom_d+arm_diameter+arm_thickness)/2+arm_length-1;
arm_lips_tick = arm_thickness * 2 + arm_separation;
arm_lips_width = arm_diameter + arm_thickness + 2*lips_width;

difference() {
    union() {
        cylinder(h = support_height, d2 = support_top_d + support_thickness, d1 = support_bottom_d + support_thickness);
        translate([support_bottom_d/2, -arm_width/2,0]) cube([arm_length+4, arm_width, support_height]);
        translate([0,0,support_height/2]) rotate([90,0,0]) translate([arm_offset,0,-arm_height/2]) cylinder(h = arm_height, d = arm_diameter + arm_thickness);
        
        translate([0,0,support_height/2]) rotate([90,0,0]) translate([arm_offset,0,0]) cube([arm_lips_tick, arm_lips_width, arm_height], center=true);
    }
    translate([0,0,-0.05]) cylinder(h = support_height+.1, d2 = support_top_d, d1 = support_bottom_d);
    translate([0,1,support_height/2]) rotate([90,0,0]) translate([arm_offset,0,-arm_height/2]) cylinder(h = arm_height+2, d = arm_diameter);
    
    translate([0,0,support_height/2]) rotate([90,0,0]) translate([arm_offset,0,0]) cube([arm_separation, arm_lips_width+2, arm_height+2], center=true);
    
    translate([arm_offset-arm_lips_tick/2-1,0,support_height/2+arm_diameter/2+lips_width/2+1.5]) rotate([0,90,0]) cylinder(h=arm_lips_tick+2, d = lips_hole_diameter);
    translate([arm_offset-arm_lips_tick/2-1,0,support_height/2-arm_diameter/2-lips_width/2-1.5]) rotate([0,90,0]) cylinder(h=arm_lips_tick+2, d = lips_hole_diameter);
    
    translate([0,0,50+support_height]) cube([1000,1000,100], center=true);
    translate([0,0,-50]) cube([1000,1000,100], center=true);
    translate([50,0,support_height/2]) rotate([90,0,0]) translate([arm_offset,0,0]) cube([100, arm_lips_width+2, arm_height+2], center=true);
}