use <MCAD/rounding.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

base_width = 30;
base_thickness = 12;
tool_diameter = 14;
rounding = 3;
slit = 8.5;
clamp_width = 5;
clamp_length = 20;
clamp_hole = 6.6;
support_thickness = 4;
support_width = 16;
support_height = 93;
support_holes = 4;
support_offset = 55;
support_rounding = 20;

module round(r, h, negative = false) {
	translate([-r, -r, 0])
	union() {
		difference() {
			cube([r, r, h]);
			translate([0,0,-1]) cylinder(r=r, h=h+2);
		}
		if (negative) {
			translate([r,0,0]) cube([1,r,h]);
			translate([0,r,0]) cube([r+1,1,h]);
		}
	}
}

module rounded_cube(x, y, z, r) {
	hull() {
		for (X=[1, -1]) {
			for (Y=[1, -1]) {
				translate([X*(x/2-r), Y*(y/2-r),0]) cylinder(r=r, h=z, center=true);
			}
		}
	}
}

module base() {
	difference() {
		rounded_cube(base_width, base_width, base_thickness, rounding);
		cylinder(d=tool_diameter, h = base_thickness+2, center=true);
		translate([0,-base_width/4-2,0]) cube([slit, base_width/2+2, base_thickness+2], center=true);
	}
}


module clamps() {
	for (x=[1, -1]) {
		translate([x * (clamp_width + slit)/2, -(base_width+clamp_length)/2+.1, 0]) 
		difference() {
			union() {
				cube([clamp_width, clamp_length, base_thickness], center=true);
				translate([x*clamp_width/2,clamp_length/2,-base_thickness/2]) rotate([0,0,x>0?90:0]) round(r = rounding, h = base_thickness);
			}
			translate([x*clamp_width/2,-clamp_length/2,0]) rotate([0,0,x>0?90:0]) round_side(r = rounding, h = base_thickness+2, negative = true);
			translate([-clamp_width/2-1,0,0]) rotate([0,90,0]) cylinder(d=clamp_hole, h = clamp_width+2);
		}
	}
}

module support() {
	translate([-(base_width-support_thickness)/2,support_offset,(support_height-base_thickness)/2])
	union() {
		difference() {
			union() {
				translate([0,0,-support_height+base_thickness]) rotate([0,90,0]) rounded_cube(support_height, support_width, support_thickness, rounding);
				translate([0,-support_offset/2,-(support_height-base_thickness)/2]) rotate([0,0,90]) rotate([90,0,0]) rounded_cube(support_offset, base_thickness, support_thickness, rounding);
			}
			translate([0,0,(-support_height+base_thickness)*3/2])
			for (offset=[0,46.55,74.05]) {
				translate([0,0,offset]) rotate([0,90,0]) cylinder(d=support_holes, h = support_thickness + 2, center=true);
			}
		}
		translate([support_thickness/2,-support_width/2+0.2,-support_height/2+0.2]) rotate([0,-90,0]) round(r=support_rounding, h=support_thickness);
		translate([support_thickness/2-0.2,-support_offset+base_width/2-0.2,-support_height/2]) rotate([0,0,180]) round(r=support_rounding, h=base_thickness);
	}
}

base();
clamps();
support();
	
