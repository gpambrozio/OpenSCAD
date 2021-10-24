$fa=0.2; // default minimum facet angle is now 0.5
$fs=0.2; // default minimum facet size is now 0.5 mm

channel_d = 2.5;
channel_l = 40;
funnel_d = 2.5;
funnel_l = 15;

difference() {
    union() {
        difference() {
            translate([0, 0, 0]) cube([20, 20, 5], center=false);
            translate([10, 10, 11]) sphere(d=20);
        }
        
        translate([0, 20, 0]) cube([20, channel_l, 5]);
    }
    translate([10, 15, 5]) rotate([-90, 0, 0]) cylinder(d=channel_d, h=channel_l);
    translate([10, 15, 5]) rotate([-90, 0, 0]) cylinder(d1=channel_d+funnel_d, d2=channel_d, h=funnel_l);
}
