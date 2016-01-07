$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

base_size = [22, 10, 2];
clip_size = [base_size[0], base_size[1], base_size[2]];
clip_angle = 30;

separation = 3;

// Calculated
clip_offset = (base_size[1] - clip_size[1]) / 2;

for (x = [0:3]) {
    for (y = [0:3]) {
        translate([x * (base_size[0] + separation), y * (base_size[0] * sin(clip_angle) + separation), 0])
        rotate([90, 0, 0])
        union() {
            cube(base_size);
            translate([1, clip_offset, 0]) rotate([0, -clip_angle, 0]) cube(clip_size);
        }
    }
}
