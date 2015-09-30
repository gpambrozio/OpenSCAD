$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

support_height = 20;
support_top_d = 80;
support_bottom_d = 77.5;
support_thickness = 6.0;

arm_length = 13;
arm_width = 15;

arm_diameter = 22;
arm_thickness = 3.5;
arm_separation = 21;

lips_hole_diameter = 4;
lips_width = 10;

lips_x_guess = 0.5;
lips_z_guess = 26.5;

module lips() {
    translate([arm_thickness/2,0,0]) difference() {
        translate([0,0,0]) cube([arm_thickness, arm_width, lips_hole_diameter * 5],center=true);
        rotate([0,90,0]) translate([-2,0,0]) cylinder(h=arm_thickness+2, d=lips_hole_diameter, center=true);
    }
}

difference() {
    union() {
        cylinder(h = support_height, d2 = support_top_d + support_thickness, d1 = support_bottom_d + support_thickness);
        translate([support_bottom_d/2, -arm_width/2,0]) cube([arm_length+arm_diameter/2+arm_thickness, arm_width, support_height]);
        translate([support_bottom_d / 2 + arm_length + arm_diameter/2+arm_thickness, 0, arm_diameter / 2 + arm_thickness]) rotate([90,0,0]) cylinder(h = arm_width, d = arm_diameter + arm_thickness * 2, center=true);
        translate([support_bottom_d/2+arm_length+lips_x_guess,0,lips_z_guess]) lips();
        translate([support_bottom_d/2+arm_length+arm_diameter+arm_thickness-lips_x_guess,0,lips_z_guess]) lips();
    }
    translate([0,0,-0.05]) cylinder(h = support_height+.1, d2 = support_top_d, d1 = support_bottom_d);
    #translate([support_bottom_d / 2 + arm_length + arm_diameter/2+arm_thickness, 0, arm_diameter / 2 + arm_thickness]) rotate([90,0,0]) cylinder(h = arm_width+2, d = arm_diameter, center=true);
    
    translate([support_bottom_d / 2 + arm_length + arm_diameter/2+arm_thickness,0,arm_diameter+arm_thickness]) cube([arm_separation, arm_width+2, arm_diameter], center=true);
}
