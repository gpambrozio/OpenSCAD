$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

inch = 25.4;

column_w = 1 * inch;
column_h = 5.5 * inch;
cut_d = 3 * inch;

base_d = 0 * inch;
base_h = 3;

hole_bottom_d = 0.3 * inch;
hole_bottom_h = 0.3 * inch;

hole_top_d = 0.23 * inch;
hole_top_h = 2 * inch;

diff = (column_w) / 4;

rotate([0, -90, 0])
difference() {
    union() {
    //    translate([-diff, 0, -peg_h]) cylinder(d = peg_d, h=peg_h);
        translate([0, 0, column_h/2]) 
        difference() {
            cube([column_w, column_w, column_h], center = true);
            translate([cut_d/2, 0, -column_h/2-1]) cylinder(d = cut_d, h=column_h+2);
        }
        translate([-diff, 0, 0]) cylinder(d = base_d, h=base_h);
    }
    translate([-diff, 0, -1]) cylinder(d = hole_bottom_d, h=hole_bottom_h + 2);
    translate([-diff, 0, -1]) cylinder(d = hole_top_d, h=hole_top_h + 2);
}