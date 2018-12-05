$fa=1; // default minimum facet angle is now 0.5
$fs=1; // default minimum facet size is now 0.5 mm

external_d = 100;
wall = 1.4;
border_w = 5;
border_h = 2.5;
wire_hole_w = 5;
wire_hole_h = 1;

difference() {
    union() {
        difference() {
            sphere(d = external_d);
            sphere(d = external_d - wall * 2);
            translate([0,0,-external_d/2]) cube([external_d + 10, external_d + 10, external_d], center=true);
        }

        difference() {
            sphere(d = external_d);
            sphere(d = external_d - border_w * 2);
            translate([0,0,-external_d/2]) cube([external_d + 10, external_d + 10, external_d], center=true);
            translate([0,0,external_d/2+border_h]) cube([external_d + 10, external_d + 10, external_d], center=true);
        }
    }
    translate([0, 0, 0]) cube([external_d + 10, wire_hole_w, wire_hole_h*2], center=true);
}
