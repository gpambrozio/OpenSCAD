$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

external_d = 35;
internal_d_lower = 21;
internal_d_upper = 23;
height = 24;
opening = 18;

support_d = 145;
support_angle = 45;
testing_length = 75;

for_printing = true;

pole_d = 26;

// hidden
support_inner_d = support_d - height * 2;

main();
//hose_support();

module hose_support() {
    rotate([0,90,0])
    translate([-height/2,0,0])
    difference() {
        union() {
            translate([0, external_d/4, external_d/2]) cube([height, external_d/2, external_d], center=true);
            translate([0,external_d/2,external_d/2]) rotate([0,90,0]) cylinder(h=height, d=external_d, center=true);
        }
        translate([0,external_d/2,external_d/2]) rotate([0,90,0]) cylinder(h=height+2, d=internal_d_upper, center=true);
        translate([-height/2-1,external_d/2-internal_d_upper/2,external_d/2]) cube([height+2, external_d/2, external_d], center=false);
        translate([0,external_d-internal_d_upper/2,external_d+7]) cube([height+2, external_d, external_d], center=true);
    }
}

module main() {
    if (for_printing) {
        support(for_printing);

        translate([-external_d/2, -support_d/8, external_d/2]) 
        arm(for_printing);
/*
        translate([0, -external_d - 10, 0])
        pole(for_printing);
*/
    } else {
        support(for_printing);
        
        translate([0, -external_d/2, -support_d/2 + height])
        rotate([90,0,0])
        rotate([0,-90,0])
        arm(for_printing);
        
        translate([0, -external_d/2-support_d * sin(support_angle) / 2, height - support_d / 2 * (1 - cos(support_angle))])
        rotate([180+support_angle, 0, 0])
        translate([0,external_d,0])
        pole(for_printing);
    }
}

module support(for_printing) {
    difference() {
        union() {
            cylinder(h=height, d=external_d);
            translate([0,-external_d/4,height/2]) cube([external_d, external_d/2, height], center=true);
        }
        translate([0, 0, -1]) cylinder(h=height+2, d1=internal_d_lower, d2=internal_d_upper);
        translate([0, external_d/4, height/2]) cube([opening, external_d/2, height+2], center=true);
    }
    if (!for_printing) {
        translate([0,0,-testing_length+height]) cylinder(h = testing_length, d = internal_d_lower);
    }
}

module arm(for_printing) {
    difference() {
        cylinder(h=external_d, d = support_d, center=true);
        cylinder(h=external_d+2, d = support_inner_d, center=true);
        translate([-support_d/2,0,0]) cube([support_d, support_d+2, external_d+2], center=true);
        rotate([0,0,90+support_angle]) translate([-support_d/2,0,0]) cube([support_d, support_d+2, external_d+2], center=true);
    }
}

module pole(for_printing) {
    difference() {
        union() {
            cylinder(h=height, d=external_d);
            translate([0,-external_d/2,height/2]) cube([external_d, external_d, height], center=true);
        }
        translate([0, 0, -1]) cylinder(h=height+2, d=pole_d);
    }
    if (!for_printing) {
        translate([0,0,-testing_length+height]) cylinder(h = testing_length, d = internal_d_lower);
    }
}
