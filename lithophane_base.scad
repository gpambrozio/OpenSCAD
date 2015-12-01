$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

base_ext = 89;
base_height = 20;
base_floor = 2;
base_border = 8;
base_int = base_ext - 2 * base_border;
slit_width = 77;
slit_border = 2;   // Distance between exterior or box to start of slit;
slit_height = 3.5;
slit_depth = 1.5;

power_diameter = 12.5;
power_clearance = 9;  // from floor to center

center_tube_d = 26;
center_tube_tickness = 2;
center_tube_height = 15;

text_depth = 2;
text = "GG & BB Lith♥phane";

difference() {
    union() {
        // Main block
        translate([0, 0, base_height/2]) cube([base_ext, base_ext, base_height], center=true);
    }
    // center
    translate([0, 0, base_height/2]) cube([base_int, base_int, base_height+2], center=true);
    // slits
    for (angle = [0:90:359]) {
        rotate([0, 0, angle]) translate([0, base_ext/2-slit_height/2-slit_border, base_height-slit_depth/2+0.5]) cube([slit_width, slit_height, slit_depth+1], center=true);
    }
    // Power hole
    translate([0, -base_ext/2-1, base_floor+power_clearance]) rotate([-90, 0, 0]) cylinder(d = power_diameter, h = base_border + 2);
    translate([0, base_ext/2-text_depth, base_height/2]) rotate([0, 0, 180]) rotate([90, 0, 0]) linear_extrude(height=text_depth+1) scale(0.65) text(text, valign = "center", halign = "center");
}
// floor
translate([0, 0, base_floor/2]) cube([base_ext, base_ext, base_floor], center=true);
difference() {
    translate([0, 0, base_floor]) cylinder(d = center_tube_d, h = center_tube_height);
    translate([0, 0, base_floor]) cylinder(d = center_tube_d - center_tube_tickness * 2, h = center_tube_height+1);
}


