$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

n = 3;

hd_w = 13;
hd_d = 115;
arm_h = 40;
arm_d = 10;
arm_w = 5;
arms_d = 60;
round = 2;


offset = (arm_w + hd_w);
h = arm_h + arm_w;

for (i = [0:n-1]) {
    translate([i*offset, 0, 0]) full_arm();
}

translate([0, 0, 0]) cube([arm_w, arms_d + arm_d, arm_w]);
translate([offset * n, 0, 0]) cube([arm_w, arms_d + arm_d, arm_w]);

module column() {
    translate([0, 0, 0]) cube([arm_w, arm_d, h]);
    translate([arm_w/2, 0, h]) rotate([-90, 0, 0]) cylinder(d=arm_w, h=arm_d);
}

module bottom_round(r) {
    translate([r, 0, r]) rotate([0, 180, 0])
    difference() {
        translate([0, 0, 0]) cube([r, arm_d, r]);
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(d=r*2, h=arm_d+2);
    }
}

module rounds() {
    translate([arm_w, 0, arm_w]) bottom_round(round);
    translate([offset, 0, arm_w]) rotate([0, -90, 0]) bottom_round(round);
}

module arm_ends() {
    intersection() {
        translate([0, -arm_w, 0]) cube([arm_w, arm_w, arm_w * 2]);
        translate([0, 0, arm_w]) rotate([0, 90, 0]) cylinder(d=arm_w * 2, h=arm_w);
    }
}

module full_arm() {
    translate([0, 0, 0]) column();
    translate([offset, 0, 0]) column();
    translate([0, arms_d, 0]) column();
    translate([offset, arms_d, 0]) column();
    
    translate([0, 0, 0]) cube([arm_w + offset, arm_d, arm_w]);
    translate([0, arms_d, 0]) cube([arm_w + offset, arm_d, arm_w]);
    
    translate([0, 0, 0]) rounds();
    translate([0, arms_d, 0]) rounds();
    
    translate([(arm_w + hd_w)/2, -(hd_d - arms_d - arm_d) / 2, 0]) cube([arm_w, (hd_d - arms_d - arm_d) / 2, arm_w]);
    translate([(arm_w + hd_w)/2, arms_d + arm_d, 0]) cube([arm_w, (hd_d - arms_d - arm_d) / 2, arm_w]);
    
    translate([(arm_w + hd_w)/2, -(hd_d - arms_d - arm_d) / 2 , 0]) arm_ends();
    translate([arm_w + (arm_w + hd_w)/2, hd_d-(hd_d - arms_d - arm_d) / 2 , 0]) rotate([0, 0, 180]) arm_ends();
}