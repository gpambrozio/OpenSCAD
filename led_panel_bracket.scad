$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

h = 20;

panel_h = 90.5;
panel_d = 14;
thickness = 2;

screw_distance = 70;
screw_d = 3.3;
holes_diam_external = 15;
holes_diam_internal = 9;
sucker_diameter = 44;

slot_w = 60;

round_radius = 4;

output_raise = 4;

// "input" side
difference() {
    bracket();
    translate([0, 0, h/2]) rotate([0, 90, 0]) roundedBox([h, slot_w, thickness+2], radius=round_radius, sidesonly=true);
}

// "output" side
translate([-h, 0, 0])
union() {
    difference() {
        bracket();
        translate([0, 0, -h/2]) rotate([0, 90, 0]) cube([h, slot_w, thickness+2], center=true);
    }
    color("black") translate([-output_raise, 0, -h/4]) cube([thickness, slot_w, h/2], center=true);
    translate([-output_raise/2, 0, thickness/2]) cube([output_raise+thickness, slot_w, thickness], center=true);

    translate([-output_raise/2, -slot_w/2-thickness/2, -h/4+thickness/2]) cube([output_raise+thickness, thickness, h/2+thickness], center=true);
    translate([-output_raise/2, slot_w/2+thickness/2, -h/4+thickness/2]) cube([output_raise+thickness, thickness, h/2+thickness], center=true);
}

module bracket() {
    difference() {
        union() {
            translate([0, 0, 0]) cube([thickness, panel_h, h], center = true);
            
            x = panel_d + 2 * thickness;
            translate([x/2-thickness/2, panel_h/2+thickness/2, 0]) cube([x, thickness, h], center = true);
            translate([x/2-thickness/2, -panel_h/2-thickness/2, 0]) cube([x, thickness, h], center = true);
            
            y_top    = sucker_diameter/2 + holes_diam_internal/2 + thickness;
            y_bottom = sucker_diameter/2 + holes_diam_internal/2 + holes_diam_external + thickness;
            deltaY = panel_h/2+thickness/2-thickness/2;
            color("black") translate([x-thickness, deltaY + (y_top-round_radius)/2, 0]) cube([thickness, y_top-round_radius, h], center = true);
            translate([x-thickness, deltaY + y_top - round_radius, 0]) rotate([0, 90,0]) roundedBox([h, round_radius*2, thickness], radius=round_radius, sidesonly=true);

            color("black") translate([x-thickness, -deltaY-(y_bottom-round_radius)/2, 0]) cube([thickness, y_bottom-round_radius, h], center = true);
            translate([x-thickness, -deltaY-y_bottom+round_radius, 0]) rotate([0, 90,0]) roundedBox([h, round_radius*2, thickness], radius=round_radius, sidesonly=true);
        }
        
        // Screw holes
        translate([-thickness/2-1, screw_distance/2, 0]) rotate([0, 90, 0]) cylinder(d=screw_d, h=thickness+2);
        translate([-thickness/2-1, -screw_distance/2, 0]) rotate([0, 90, 0]) cylinder(d=screw_d, h=thickness+2);
        
        // Top holes for sucker
        y = panel_h/2 + sucker_diameter / 2;
        translate([panel_d, y, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_internal, h=thickness+2);
        translate([panel_d, y-holes_diam_internal, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_external, h=thickness+2);
        
        // Bottom holes
        translate([panel_d, -y, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_internal, h=thickness+2);
        translate([panel_d, -y-holes_diam_internal, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_external, h=thickness+2);
    }
}
