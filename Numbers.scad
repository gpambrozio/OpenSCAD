
$fa=0.2; // default minimum facet angle is now 0.5
$fs=0.2; // default minimum facet size is now 0.5 mm

ext_diameter = 9;
int_diameter = 4.46;
height = 12;
pin_height = 12;
pin_depth = 10;

number("/Users/gustavoambrozio/Downloads/poppins_extralight_wayne/6.svg", [[0, 58, 0], [0, -58.5, 0]]);

module number(file, offsets) {
    union() {

        rotate([0, 180, 0])
        linear_extrude(height = height)
        import(file = file, center = true);

        for (offset=offsets) {
            translate(offset)
            translate([0, 0, -1])
            difference() {
                cylinder(d = ext_diameter, h = pin_height+1);
                translate([0, 0, 1 + pin_height - pin_depth]) cylinder(d = int_diameter, h = pin_depth+1);
                translate([0, 0, 4.5 + pin_height - pin_depth]) cylinder(d1 = 0, d2 = ext_diameter, h = ext_diameter);
            }
        }
    }
}
