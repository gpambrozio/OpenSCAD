include <MCAD/motors.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

motor_width = 42;
base_tickness = 3;
base_width = 121;
support_width = 10;
center_offset = 24;
arm_width = support_width + 2 * base_tickness;
support_hole = 5;

module base() {
	difference() {
		cube([motor_width, motor_width, base_tickness], center=true);
		scale([1,1,10]) stepper_motor_mount(17, mochup=false);
		translate([-motor_width/2,0,0]) cube([motor_width, motor_width/2, base_tickness+2], center=true);
	}
}

module support() {
	difference() {
		cube([base_tickness, support_width * 2, support_width], center=true);
		translate([0,support_width,support_width/2]) rotate([45,0,0]) cube([base_tickness + 2, support_width, support_width], center=true);
		translate([0,-support_width/2,0]) rotate([0,90,0]) cylinder(d=support_hole, h=base_tickness+2, center=true);
	}
}

module arm() {
	difference() {
		translate([center_offset,0,0]) cube([arm_width, base_width, base_tickness], center=true);
		cube([motor_width, motor_width, base_tickness+2], center=true);
	}
}

module supports() {
	// Supports
	for (x=[1, -1]) {
		for (y=[1, -1]) {
			translate([center_offset + x * (arm_width-base_tickness)/2,y * base_width/2, (support_width-base_tickness)/2])
			rotate([0,0,y > 0 ? 180 : 0])
			support();
		}
	}
}

arm();
base();
supports();
//support();

