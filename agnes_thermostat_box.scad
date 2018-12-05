use <MinkowskiRound/MinkowskiRound.scad>

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

base_ext_h = 65;
base_ext_w = 72;
base_height = 22;
base_floor = 1.6;
base_border = 1.6;
base_int_h = base_ext_h - 2 * base_border;
base_int_w = base_ext_w - 2 * base_border;

slit_w = 16;
slit_h = 4;

holes_d = 60;
holes_size = 6;

button_d = 8;

difference() {
    minkowskiOutsideRound(2,2) union() {
        // Main block
        translate([0, 0, base_height/2]) cube([base_ext_w, base_ext_h, base_height], center=true);

        // floor
        translate([0, 0, base_floor/2]) cube([base_ext_w, base_ext_h, base_floor], center=true);
    }
    // center
    translate([0, 0, base_floor + (base_height + base_floor) / 2]) cube([base_int_w, base_int_h, base_height], center=true);

    // Slit
    translate([-slit_w, base_int_h / 2 - 1, base_height - slit_h]) cube([slit_w, base_border + 2, slit_h + 1]);
    
    // screw holes
    translate([holes_d / 2, 0, -1]) cylinder(d = holes_size, h = base_floor + 3);
    translate([-holes_d / 2, 0, -1]) cylinder(d = holes_size, h = base_floor + 3);
    
    // button hole
    translate([0, 0, -1]) cylinder(d = button_d, h = base_floor + 3);
}
