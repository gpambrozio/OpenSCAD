$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

separator_width = 7;
separator_thickness = 6;
wall_height = 4;
wall_thickness = 2.5;

rotate([90, 0, 0])
union() {
    cube([separator_width, separator_width, separator_thickness], center = true);
    translate([separator_width/2 + wall_thickness/2, 0, 0]) cube([wall_thickness, separator_width, wall_thickness * 2 + separator_thickness], center = true);
    translate([-separator_width/2 - wall_thickness/2, 0, 0]) cube([wall_thickness, separator_width, wall_thickness * 2 + separator_thickness], center = true);
};
