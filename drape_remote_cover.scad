use <MCAD/rounding.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

rounding_radius = 2.5;
wall_thickness = 1.6;
remote_width = 42.1 - 2 * wall_thickness;
remote_length = 59 - 2 * wall_thickness;
remote_height = 13 + wall_thickness;
top_clearance = 5.6;

module profile() {
	translate([-wall_thickness,-wall_thickness,remote_height/2]) linear_extrude(height = remote_height, center=true, convexity=10) scale([25.4,25.4,1]) import(file="drape_remote_cover.dxf", layer="Layer1");
}

difference() {
	union() {
		// top
		difference() {
			cube([remote_width, remote_length, wall_thickness]);
			translate([0,0,-2]) profile();
			translate([0,-1,-2]) profile();
		}

		profile();

		// side walls
		//translate([-wall_thickness, 0,0]) cube([wall_thickness, remote_length, remote_height]);
		//translate([remote_width, 0,0]) cube([wall_thickness, remote_length, remote_height]);
		
		// front and back
		//translate([-wall_thickness,-wall_thickness,0]) cube([remote_width + 2* wall_thickness, wall_thickness, remote_height]);
		difference() {
			translate([-wall_thickness,remote_length,0]) cube([remote_width + 2* wall_thickness, wall_thickness, remote_height]);
			translate([0,remote_length-1,remote_height- top_clearance]) cube([remote_width, wall_thickness+2, top_clearance+1]);
		}
	}

	// Corner rounds
	translate([-wall_thickness,-wall_thickness,0]) rotate([0,0,90]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([-wall_thickness,remote_length+wall_thickness,0]) rotate([0,0,0]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([remote_width + wall_thickness,remote_length+wall_thickness,0]) rotate([0,0,-90]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([remote_width + wall_thickness,-wall_thickness,0]) rotate([0,0,180]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
}
