$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

inner_diameter = 25;
outer_diameter = 42;
thickness = 4.4;

difference() {
    cylinder(d=outer_diameter, h=thickness);
    translate([0,0,-1]) cylinder(d=inner_diameter, h=thickness+2);
}
