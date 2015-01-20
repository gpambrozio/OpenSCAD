include <MCAD/constants.scad>
include <MCAD/rounding.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

motor_width = 42;
base_thickness = 4;
base_width = 121;
support_width = 10;
center_offset = 24;
arm_width = support_width + 2 * base_thickness;
support_hole = 5;
base_rounding = 8;

pilot_diameter = 0.866*mm_per_inch;
bolt_hole_distance = 1.220*mm_per_inch;
bolt_hole_size = 4.2;

module base() {
	difference() {
		cube([motor_width, motor_width, base_thickness], center=true);
		cylinder(d = pilot_diameter, h = base_thickness + 2, center=true);
		for (x=[1, -1]) {
			for (y=[1, -1]) {
				translate([x*bolt_hole_distance/2,y*bolt_hole_distance/2,0]) cylinder(d = bolt_hole_size, h = base_thickness + 2, center=true);
			}
		}
		translate([-motor_width/2,0,0]) cube([motor_width, pilot_diameter, base_thickness+2], center=true);
	}
}

module support() {
	difference() {
		cube([base_thickness, support_width * 2, support_width], center=true);
		translate([0,support_width,support_width/2]) rotate([45,0,0]) cube([base_thickness + 2, support_width, support_width], center=true);
		translate([0,-support_width/2,0]) rotate([0,90,0]) cylinder(d=support_hole, h=base_thickness+2, center=true);
	}
}

module arm() {
	difference() {
		translate([center_offset,0,0]) cube([arm_width, base_width, base_thickness], center=true);
		cube([motor_width, motor_width, base_thickness+2], center=true);
	}
}

module supports() {
	// Supports
	for (x=[1, -1]) {
		for (y=[1, -1]) {
			translate([center_offset + x * (arm_width-base_thickness)/2,y * base_width/2, (support_width-base_thickness)/2])
			rotate([0,0,y > 0 ? 180 : 0])
			support();
		}
	}
}

module rounds() {
	translate([center_offset-arm_width/2,-motor_width/2,0]) rotate([0,0,180]) round_side(base_rounding, base_thickness);
	translate([center_offset-arm_width/2,motor_width/2,0]) rotate([0,0,90]) round_side(base_rounding, base_thickness);
}

arm();
base();
supports();
rounds();

