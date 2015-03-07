$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.1; // default minimum facet size is now 0.5 mm

w = 105;
h = 50;

recess = 2.9 - 2.14 + 2.8;
tickness = 5.92 - 3.89;

hole_w = 12.94;
hole_h = 6;
hole_slit_h = 3.3;
hole_slit_w = hole_w - 6.84;

hole_distance_x = 30.5;
hole_distance_y = 24.4;

difference() {
	union() {
		difference() {
			import("iPhone6.stl", convexity=10);
			cube([w,h,10], center = true);
		}
		translate([-w/2-tickness,-h/2,-recess]) cube([tickness, h, recess]);
		translate([w/2,-h/2,-recess]) cube([tickness, h, recess]);
		translate([-w/2-tickness,h/2,-recess]) cube([w+2*tickness, tickness, recess]);
		translate([-w/2-tickness,-h/2-tickness,-recess]) cube([w+2*tickness, tickness, recess]);
		translate([0,0,-recess+tickness/2]) cube([w,h,tickness], center=true);
	}
	holes();
	scale([1,-1,1]) holes();
}

module hole() {
	union() {
		difference() {
			cube([hole_w, hole_h, tickness+2]);
			translate([-1,-1,-1]) cube([hole_slit_w+1, hole_h-hole_slit_h+1, tickness+4]);
		}
		translate([hole_slit_w,hole_h-hole_slit_h,tickness/2+1]) rotate([0,0,45]) cube([1,1,tickness+2], center=true);
		translate([3.2,hole_h-hole_slit_h+2.3,0]) 
		difference() {
			cylinder(d=5, h=tickness+2);
			translate([-3,0,-1]) cube([6,6,tickness+4]);
		}
	}
}

module holes() {
	translate([hole_distance_x/2-hole_w/2,hole_distance_y/2-hole_h,-recess-1]) hole();
	translate([-(hole_distance_x/2-hole_w/2)-hole_w,hole_distance_y/2-hole_h,-recess-1]) hole();
}