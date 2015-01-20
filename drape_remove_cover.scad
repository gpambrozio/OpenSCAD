use <MCAD/rounding.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

rounding_radius = 2.5;
wall_thickness = 1.6;
remote_width = 42.1 - 2 * wall_thickness;
remote_length = 59 - 2 * wall_thickness;
remote_height = 13 + wall_thickness;
top_clearance = 5.5;
hole_diameter = 9;
hole_vertical = 8.3;
hole_horizontal = 14.5;
top_teeth_size = 1.6;
teeth_size = 1.2;
teeth_height = 1.8;
teeth_width = 3.5;
bottom_teeth_distance = 6.54;

difference() {
	union() {
		// top
		cube([remote_width, remote_length, wall_thickness]);

		// side walls
		translate([-wall_thickness, 0,0]) cube([wall_thickness, remote_length, remote_height]);
		translate([remote_width, 0,0]) cube([wall_thickness, remote_length, remote_height]);
		
		// front and back
		translate([-wall_thickness,-wall_thickness,0]) cube([remote_width + 2* wall_thickness, wall_thickness, remote_height]);
		translate([-wall_thickness,remote_length,0]) cube([remote_width + 2* wall_thickness, wall_thickness, remote_height - top_clearance]);

		// top teeth
		translate([(remote_width - teeth_width)/2, remote_length + wall_thickness, remote_height - top_clearance - teeth_size]) cube([teeth_width, top_teeth_size, teeth_size]);

		// bottom teeth
		translate([bottom_teeth_distance - teeth_width/2, 0, remote_height - teeth_height]) cube([teeth_width, teeth_size, teeth_height]);
		translate([remote_width - bottom_teeth_distance - teeth_width/2, 0, remote_height - teeth_height]) cube([teeth_width, teeth_size, teeth_height]);
	}
	// power hole
	translate([remote_width-1, hole_horizontal - wall_thickness, remote_height - hole_vertical]) rotate([0,90,0]) cylinder(d=hole_diameter, h = wall_thickness + 2);

	// Corner rounds
	translate([-wall_thickness,-wall_thickness,0]) rotate([0,0,90]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([-wall_thickness,remote_length+wall_thickness,0]) rotate([0,0,0]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([remote_width + wall_thickness,remote_length+wall_thickness,0]) rotate([0,0,-90]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
	translate([remote_width + wall_thickness,-wall_thickness,0]) rotate([0,0,180]) rotate([0,180,0]) round_corner_and_sides([remote_length+2, 0, remote_length+2], rounding_radius);
}
