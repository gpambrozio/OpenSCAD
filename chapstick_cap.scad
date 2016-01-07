$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

inner_d = 14.3;
thickness = 1.2;

inner_depth = 10.5;
cap_top_h = 3;
clip_hole = 6.5;
clip_top = 2;
clip_opening = 6;

total_h = inner_depth + cap_top_h + clip_hole + clip_top;
external_d = inner_d + 2 * thickness;

translate([0, 0, total_h])
rotate([0, 180, 0])
difference() {
    cylinder(d = external_d, h = total_h);
    translate([0, 0, -1]) cylinder(d=inner_d, h=inner_depth + 1);

    translate([0, 0, clip_hole/2+inner_depth+cap_top_h]) 
    difference() {
        cube([clip_opening, external_d+2, clip_hole], center=true);
        translate([-clip_opening *3/4, 0, -clip_hole * 3 / 4]) rotate([0, 45, 0]) cube([clip_opening, external_d+4, clip_hole], center=true);
        translate([clip_opening * 3 / 4, 0, -clip_hole * 3 / 4]) rotate([0, -45, 0]) cube([clip_opening, external_d+4, clip_hole], center=true);
    }
    
    translate([-clip_opening/2, clip_opening/2, clip_hole/2+inner_depth+cap_top_h]) cube([clip_opening, external_d, total_h]);
    translate([-clip_opening/2, -external_d-clip_opening/2, clip_hole/2+inner_depth+cap_top_h]) cube([clip_opening, external_d, total_h]);
}
