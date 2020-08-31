$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

h = 24;

panel_h = 96.5;
panel_d = 15;
thickness = 2.4;

screw_distance = 76;
screw_d = 3.3;
holes_diam_external = 15;
holes_diam_internal = 9;
sucker_diameter = 44;

slot_w = 64;

round_radius = 4;


// "output" side
/*
translate([-h, 0, 0])
difference() {
    bracket();
    translate([0, 0, h/2]) rotate([0, 90, 0]) roundedBox([h, slot_w, thickness+2], radius=round_radius, sidesonly=true);
}
*/

output_raise = 5;
output_raise_w = h - 5;
reinforcement_size = 4;

// "input" side
union() {
    difference() {
        bracket();
        translate([0, 0, -output_raise_w/2-h/2+output_raise_w-1]) cube([thickness+2, slot_w, output_raise_w+2], center=true);
    }
    y_center_offset = -output_raise_w/2-h/2+output_raise_w;
    color("black") translate([-output_raise, 0, y_center_offset]) cube([thickness, slot_w, output_raise_w], center=true);
    translate([-output_raise/2, 0, (output_raise_w - h/2) + thickness/2]) cube([output_raise+thickness, slot_w+2*thickness, thickness], center=true);

    translate([-output_raise/2, -slot_w/2-thickness/2, y_center_offset]) cube([output_raise+thickness, thickness, output_raise_w], center=true);
    translate([-output_raise/2, slot_w/2+thickness/2, y_center_offset]) cube([output_raise+thickness, thickness, output_raise_w], center=true);
}

module bracket() {
    difference() {
        union() {
            translate([0, 0, 0]) cube([thickness, panel_h, h], center = true);
            
            x = panel_d + thickness;
            translate([x/2-thickness/2, panel_h/2+thickness/2, 0]) cube([x, thickness, h], center = true);
            translate([x/2-thickness/2, -panel_h/2-thickness/2, 0]) cube([x, thickness, h], center = true);
            
            y_top    = sucker_diameter/2 + holes_diam_internal/2 + thickness;
            y_bottom = sucker_diameter/2 + holes_diam_internal/2 + holes_diam_external + thickness;
            deltaY = panel_h/2+thickness/2-thickness/2;

            translate([x-thickness, deltaY + (y_top-round_radius)/2, 0]) cube([thickness, y_top-round_radius, h], center = true);
            translate([x-thickness, deltaY + y_top - round_radius, 0]) rotate([0, 90,0]) roundedBox([h, round_radius*2, thickness], radius=round_radius, sidesonly=true);
            
            translate([x-3/2*thickness-reinforcement_size, deltaY+thickness, -h/2])
            scale([reinforcement_size, reinforcement_size, h])
            difference() {
                cube([1, 1, 1]);
                translate([0, 0, -1]) rotate([0, 0, 45]) cube([2,2,3]);
            }

            translate([x-thickness, -deltaY-(y_bottom-round_radius)/2, 0]) cube([thickness, y_bottom-round_radius, h], center = true);
            translate([x-thickness, -deltaY-y_bottom+round_radius, 0]) rotate([0, 90,0]) roundedBox([h, round_radius*2, thickness], radius=round_radius, sidesonly=true);
            
            translate([x-3/2*thickness, -deltaY-thickness-reinforcement_size, -h/2])
            rotate([0, 0, 90])
            scale([reinforcement_size, reinforcement_size, h])
            difference() {
                cube([1, 1, 1]);
                translate([0, 0, -1]) rotate([0, 0, 45]) cube([2,2,3]);
            }
        }
        
        // Screw holes
        translate([-thickness/2-1, screw_distance/2, 0]) rotate([0, 90, 0]) cylinder(d=screw_d, h=thickness+2);
        translate([-thickness/2-1, -screw_distance/2, 0]) rotate([0, 90, 0]) cylinder(d=screw_d, h=thickness+2);
        
        // Top holes for sucker
        y = panel_h/2 + sucker_diameter / 2;
        translate([panel_d-2, y, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_internal, h=thickness+2);
        translate([panel_d-2, y-holes_diam_internal, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_external, h=thickness+2);
        
        // Bottom holes
        translate([panel_d-2, -y, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_internal, h=thickness+2);
        translate([panel_d-2, -y-holes_diam_internal, 0]) rotate([0, 90, 0]) cylinder(d=holes_diam_external, h=thickness+2);
    }
}
