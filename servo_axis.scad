$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.1; // default minimum facet size is now 0.5 mm

outside_diameter = 12;
screw_diameter = 5.8;
screw_depth = 11;
screw_outside_diameter = 6.4;
screw_outside_depth = 5;
axis_diameter = 5.26;
axis_notch = 4.5 - 2.5 + 0.3;
axis_height = 15;
total_lenght = screw_depth + axis_height + 3;

wrench_opening = 10 - .2;
wrench_height = 6;

rotate([0,180,0])
difference() {
	cylinder(d = outside_diameter, h = total_lenght);
	translate([0,0,-1]) cylinder(d = screw_diameter, h = screw_depth + 1);
	translate([0,0,-1]) cylinder(d = screw_outside_diameter, h = screw_outside_depth + 1);

	translate([0,0,total_lenght+1]) rotate([180,0,0]) difference() {
		union() {
			cylinder(d=axis_diameter, h=axis_height + 1);
			translate([0,0,axis_height+1]) cylinder(d=axis_diameter, d2 = 1, h=1);
		}
		translate([-axis_diameter/2-1,axis_notch,-1]) cube([axis_diameter+2, axis_diameter + 2, axis_height + 3]);
	}

	translate([wrench_opening / 2,-outside_diameter/2,screw_depth]) cube([outside_diameter, outside_diameter, wrench_height]);
	translate([-wrench_opening / 2 - outside_diameter,-outside_diameter/2,screw_depth]) cube([outside_diameter, outside_diameter, wrench_height]);
}
