$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

external_d = 35;
internal_d_lower = 21;
internal_d_upper = 23;
height = 24;
opening = 18;

support_d = 145;
testing_length = 75;

for_printing = true;

if (for_printing) {
    main(for_printing);
    translate([-external_d/2, -support_d/8, external_d/2]) support(for_printing);
} else {
    main(for_printing);
    translate([0, -external_d/2, -support_d/2 + height])
    rotate([90,0,0])
    rotate([0,-90,0])
    support(for_printing);
}

module main(for_printing) {
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

module support(for_printing) {
    difference() {
        cylinder(h=external_d, d = support_d, center=true);
        cylinder(h=external_d+2, d = support_d - height * 2, center=true);
        translate([-support_d/2,0,0]) cube([support_d, support_d+2, external_d+2], center=true);
        rotate([0,0,135]) translate([-support_d/2,0,0]) cube([support_d, support_d+2, external_d+2], center=true);
    }
    if (!for_printing) {
        rotate([0,0,135]) translate([-support_d/2,0,0]) cube([support_d, support_d+2, external_d+2], center=true);
    }
}