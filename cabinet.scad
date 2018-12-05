$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

inch = 25.4;

drawer_w = (2.0 + (3.0/16.0)) * inch - 2;
drawer_h = 1.5 * inch - 2;
drawer_d = 5.5 * inch - 5.4;

drawer_rows = 2;
drawer_columns = 2;

spacing = 1;
separator = 2;
holes_border = 5;

/////////////////////////////////////

my_w = drawer_w + 2 * (spacing + separator);
my_h = drawer_h + 2 * (spacing + separator);
my_d = drawer_d + spacing + separator;

module side_hole() {
    hull() {
        translate([-1, drawer_h / 2, separator + spacing + drawer_h / 2]) rotate([0, 90, 0]) cylinder(d=drawer_h - 2 * holes_border, h=my_w + 2);
        translate([-1, my_d - drawer_h / 2 - separator, separator + spacing + drawer_h / 2]) rotate([0, 90, 0]) cylinder(d=drawer_h - 2 * holes_border, h=my_w + 2);
    }
}

module top_hole() {
    hull() {
        translate([drawer_w / 2 + spacing + separator, drawer_w / 2, -1]) cylinder(d=drawer_w - 2 * holes_border, h=my_h + 2);
        translate([drawer_w / 2 + spacing + separator, my_d - drawer_w / 2 - separator, -1]) cylinder(d=drawer_w - 2 * holes_border, h=my_h + 2);
    }
}

module back_hole() {
    hull() {
        translate([drawer_h / 2, my_d + 1, separator + spacing + drawer_h / 2]) rotate([90, 0, 0]) cylinder(d=drawer_h - 2 * holes_border, h=separator + 2);
        translate([my_w - drawer_h / 2, my_d + 1, separator + spacing + drawer_h / 2]) rotate([90, 0, 0]) cylinder(d=drawer_h - 2 * holes_border, h=separator + 2);
    }
}

module 1_drawer() {
    difference() {
        translate([0, 0, 0]) cube([my_w, my_d, my_h]);
        translate([separator, -1, separator]) cube([my_w - 2 * separator, my_d - separator + 1, my_h - 2 * separator]);

        side_hole();
        top_hole();
        back_hole();
    }
}

rotate([-90, 0, 0])
for (r=[0:drawer_rows-1]) {
    for (c=[0:drawer_columns-1]) {
        translate([c * (my_w - separator), 0, r * (my_h - separator)]) 1_drawer();
    }
}
