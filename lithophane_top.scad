$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

base_ext = 89;
base_height = 7.8;
base_floor = 3;
base_border = 8;
base_int = base_ext - 2 * base_border;
slit_width = 78;
slit_border = 2;   // Distance between exterior or box to start of slit;
slit_height = 3.7;
slit_depth = 1.5;

center_hole = 4.5;

difference() {
    union() {
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
            
        }
        // floor
        translate([0, 0, base_floor/2]) cube([base_ext, base_ext, base_floor], center=true);
    }
    // center hole
    translate([0, 0, -base_height/2]) cylinder(d = center_hole, h = base_border + 2);
}
