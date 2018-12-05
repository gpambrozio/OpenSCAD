$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

h = 20;
l = 135;
w = 11;

holes_distance = 62;
holes_diam = 6;

// From https://www.thingiverse.com/thing:252814/files
file = "16x32_LED_DIsplay_bracket.stl";

difference() {
    translate([0, -l / 2, 0])
    import(file, convexity = 5);
    
    translate([-1, -holes_distance, h/2]) rotate([0, 90, 0]) cylinder(d=holes_diam, h=10);
    translate([-1,  holes_distance, h/2]) rotate([0, 90, 0]) cylinder(d=holes_diam, h=10);
}
