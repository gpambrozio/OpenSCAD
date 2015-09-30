$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

support_height = 20;
support_top_d = 80;
support_bottom_d = 77.5;
support_thickness = 6.0;

arm_length = 25;
arm_width = 25;
lips_width = 57;
lips_hole_d = 4;

arm_thickness = 4;

difference() {
    union() {
        cylinder(h = support_height, d2 = support_top_d + support_thickness, d1 = support_bottom_d + support_thickness);
        translate([support_bottom_d/2, -arm_width/2,0]) cube([arm_length+4, arm_width, support_height]);
        
        translate([arm_thickness/2+support_bottom_d/2+arm_length+4,0,support_height/2]) cube([arm_thickness, lips_width, support_height], center=true);
    }
    translate([0,0,-0.05]) cylinder(h = support_height+.1, d2 = support_top_d, d1 = support_bottom_d);
    
    translate([support_bottom_d/2+arm_length+3,lips_width/2-(lips_width-arm_width)/4,support_height/2]) rotate([0,90,0]) cylinder(h = arm_thickness+2, d = lips_hole_d);
    translate([support_bottom_d/2+arm_length+3,-lips_width/2+(lips_width-arm_width)/4,support_height/2]) rotate([0,90,0]) cylinder(h = arm_thickness+2, d = lips_hole_d);
    
}
