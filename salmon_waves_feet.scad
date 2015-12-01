$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

foot_d = 19.3;
foot_h = 19.6;

for (i=[0,90,180,270]) {
    rotate([0, 0, 45+i]) translate([foot_h, 0, 0]) cylinder(d = foot_d, h=foot_h);
}