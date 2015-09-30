$fs=1;
$fa=1;

servo_l = 24;
servo_w = 13;
servo_h = 24;

bolt_hole_diameter = 4.5;
servo_axis_diameter = 4.8;

magnet_hole_l = 10.5;
magnet_hole_w = 6.5;
magnet_hole_d = 2;
magnet_hole_margin = 2;

base_l = servo_l * 2 + 24;
base_w = 44;
base_h = 3;

base_joint_space = 0.7;
base_joint_height = 26;

arm_h = 4.5;
arm_w = 5;
arm_l = 50;

pen_diameter = 13;

eraser_magnet_diameter = 25.5;

module servoholder(h = 8) {
	module bolt_bracket(d) {
		r=d/2;
		translate([-14,0,h/2])
		difference() {
			translate([4,0]) cube([18,5,h], center=true);
			rotate(a=90,v=[1,0,0]) cylinder(r=r, h=20, center=true);
		}
	}
	translate([0,0,-h/2]) {
		for (i = [0,1]) mirror([0,i,0]) {
			translate([0,5,0])
			difference() {
				translate([-4, -6]) cube([servo_w + 8, servo_l + 12, h]);
				translate([0,0,-1]) cube([servo_w, servo_l, h + 2]);
			}
			translate([0,5/2 + servo_l + 6,0]) bolt_bracket(bolt_hole_diameter);
		}
		translate([0,-17,0]) bolt_bracket(servo_axis_diameter);
	}
}

module base() {
	difference() {
		translate([-base_w/2,-base_l/2]) cube([base_w,base_l,base_h]);
		for (i = [0,1]) mirror([i,0,0])
		for (j = [0,1]) mirror([0,j,0]) {
			translate([
				base_w/2 - magnet_hole_w - magnet_hole_margin,
				base_l/2 - magnet_hole_l - magnet_hole_margin,
				base_h - magnet_hole_d
			])
			cube([magnet_hole_w,magnet_hole_l,magnet_hole_d+1]);
		}
	}
	difference() {
		for (i = [0, 1]) mirror([0,i,0]) {
			translate([-servo_w/2 - 4, 0, 0]) cube([servo_w + 8, servo_l + 6 - base_joint_space, 15]);
			translate([0, servo_l + 6 - base_joint_space , 0])
			difference() {
				translate([-5, -5, 0]) cube([10, 5, base_joint_height + 4]);
				translate([0,1,base_joint_height]) rotate(a=90, v=[1,0,0]) cylinder(r=bolt_hole_diameter/2, h=10);
			}
		}
		translate([-servo_w/2,-servo_h/2+3.8,8]) {
			cube([servo_w,servo_h,servo_l]);
			translate([0,2.5,-4]) cube([servo_w,3,6]);
		}
	}
}

module arm_ring(d) {
	do = d + arm_w;
	difference() {
		cylinder(h=arm_h, r=do/2);
		translate([0,0,-1]) cylinder(h=arm_h+2, r=d/2);
	}
}

module arm(hole1, hole2) {
	arm_ring(hole1);
	translate([hole1/2,-arm_w/2,0]) cube([arm_l-hole1/2-hole2/2,arm_w,arm_h]);
	translate([arm_l,0,0]) arm_ring(hole2);
}

module pen_arm() {
	arm(bolt_hole_diameter, bolt_hole_diameter);
	rotate(a=45,v=[0,0,1])
	translate([-arm_w/2-pen_diameter/2-bolt_hole_diameter/2,0,0])
	difference() {
		arm_ring(pen_diameter, pen_diameter + arm_w);
		translate([-pen_diameter/2,0,-1]) cylinder(r=pen_diameter/2,h=arm_h+2);
	}
}

module eraser() {
	module ring(di,do,h) {
		difference() {
			cylinder(h=h, r=do/2);
			translate([0,0,-1]) cylinder(h=h+2, r=di/2);
		}
	}
	ring(10, eraser_magnet_diameter + 1, 5);
	ring(eraser_magnet_diameter, eraser_magnet_diameter + 2.5, 8);
}

//color("red") translate([-50,0,0]) base();
//color("red") translate([0,0,4]) servoholder();
//color("green") translate([40, 30, 0]) arm(servo_axis_diameter, bolt_hole_diameter);
//color("green") translate([40, 10, 0]) arm(servo_axis_diameter, bolt_hole_diameter);
//color("green") translate([40, -10, 0]) arm(bolt_hole_diameter, bolt_hole_diameter);
color("green") translate([40, -30, 0]) pen_arm();
//color("blue") translate([60, 60, 0]) eraser();