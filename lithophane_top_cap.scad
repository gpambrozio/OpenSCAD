$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

tube_d = 26;
tube_tickness = 2;
tube_height = 5;

tube_base = 5;
tube_border = 3.7;

bolt_d = 8.6;
bolt_depth = 2.8;

screw_d = 5;

wire_hole_d = 4;

// floor
difference() {
    translate([0, 0, 0]) cylinder(d = tube_d + 2 * tube_border, h = tube_base);
    translate([0, 0, tube_base - bolt_depth]) cylinder(d=bolt_d, h=bolt_depth+1, $fn=6);
    translate([0, 0, -1]) cylinder(d = screw_d, h = tube_base + 2);
    translate([tube_d / 2 - tube_tickness - wire_hole_d, 0, -1]) cylinder(d = wire_hole_d, h = tube_base + 2);
}
difference() {
    translate([0, 0, tube_base]) cylinder(d = tube_d, h = tube_height);
    translate([0, 0, tube_base-1]) cylinder(d = tube_d - tube_tickness * 2, h = tube_height+2);
}

