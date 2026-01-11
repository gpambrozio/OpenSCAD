// Jewelry Bead
// A disc-shaped bead with rounded edges and threading hole

$fa = 1;
$fs = 0.4;

// Parameters
outer_diameter = 15;    // Largest diameter at the edge
flat_diameter = 10;     // Diameter of the flat top/bottom surfaces
height = 5;             // Total height
hole_diameter = 1.2;    // Threading hole diameter

// Letter parameters
letter = "L";
letter_height = 8;      // Font size
letter_thickness = 0.1; // Extrusion thickness
font_file = "Bagel Fat One:style=Regular";

// Calculated radii
outer_radius = outer_diameter / 2;   // 7.5mm
flat_radius = flat_diameter / 2;     // 5mm

module bead_profile() {
    // Create the 2D profile for rotate_extrude
    // Profile must be entirely in positive X

    // Use hull to create smooth curved edge
    hull() {
        // Flat top/bottom disc (thin rectangle at the flat_radius edge)
        translate([0, -height/2])
            square([flat_radius, height]);

        // Bulge at the center (circle creates the rounded outer edge)
        translate([outer_radius - height/2, 0])
            circle(d = height);
    }
}

module bead() {
    difference() {
        // Main bead body
        rotate_extrude(angle = 360)
            bead_profile();

        // Threading hole through the side
        rotate([0, 90, 0])
            cylinder(h = outer_radius * 2 + 1, d = hole_diameter, center = true);
    }
}

module letter_top() {
    // Letter centered on top of bead, top surface flush with bead top
    translate([0, 0, height/2 - letter_thickness])
        linear_extrude(height = letter_thickness + 0.001)
            text(letter, size = letter_height, font = font_file, halign = "center", valign = "center");
}

module letter_bottom() {
    // Letter centered on bottom of bead, bottom surface flush with bead bottom
    // Mirrored in Y so it reads correctly when bead is rotated around hole axis (X)
    translate([0, 0, -height/2 - 0.001])
        mirror([0, 1, 0])
            linear_extrude(height = letter_thickness + 0.001)
                text(letter, size = letter_height, font = font_file, halign = "center", valign = "center");
}

// Render bead in white
color("white")
    bead();

// Render letters in black
color("black") {
    letter_top();
    letter_bottom();
}
