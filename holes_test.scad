$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

start = 4.6;
increase = 0.1;
n = 4;
h1 = 5;
h2 = 10;

text_depth = 1;

final = start + increase * (n - 1) + 5;

difference() {
    intersection() {
        union() {
            cube([final * n, final, h1]);
            for (i=[0:n-1]) {
                translate([final / 2 + final * i, final / 2, 0]) rotate([0, 0, 0]) cylinder(d=final, h=h2);
            }
        }
        hull() {
            for (i=[0,n-1]) {
                translate([final / 2 + final * i, final / 2, 0]) rotate([0, 0, 0]) cylinder(d=final, h=h2);
            }
        }
    }
    for (i=[0:n-1]) {
        translate([final / 2 + final * i, final / 2, -1]) rotate([0, 0, 0]) cylinder(d=start + i * increase, h=h2+2);
        translate([final / 2 + final * i, final / 2, -1]) rotate([0, 0, 0]) cylinder(d1=0, d2=2 + start + i * increase, h=h2+2);
        translate([final / 2 + final * i, text_depth, 1]) rotate([90, 0, 0]) linear_extrude(height=text_depth+1) scale(0.3) text(str(start + i * increase), valign = "bottom", halign = "center");
    }
}
