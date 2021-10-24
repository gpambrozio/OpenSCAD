$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <snap-pins.scad>;

//socket(diameter = 4.5);
pin();
translate([0, 0, -5]) rotate([0, 0, 0]) cylinder(d=10, h=5);

module pin(
    // Pulls the snaps together on the pin to ensure a tight coupling, does not affect socket
    preload = 0.2,
    // Clearance gap between the pin and the socket opening, does not affect socket
    clearance = 0.2,
    // Thickness of cylinder wall around socket when printable
    cylinder_thickness = 0.8,
    
    thickness = 1.5,
    
    length = 10.8,
    
    diameter = 5,
    snap = 0.5,
    snapDepth = 1.8
) {
    offset = diameter / 2 * sqrt(2) - 2 * clearance;
    translate([0, -offset/2, 0])
    rotate([-90, 0, 0])
    difference() {
        render(
            part = "pin",
            length = length,
            diameter = diameter,
            snap = snap,
            snapDepth = snapDepth,
            thickness = thickness,
            pointed = 0,
            fins = 0,
            preload = preload,
            clearance = clearance,
            printable = 1,
            shadowSocket = 1,
            spacing = 0,
            cylinderThickness = cylinder_thickness
        );
        translate([-10, 0, -10 + thickness]) cube([20, 13, 20]);
    }
}

module socket(
    // Pulls the snaps together on the pin to ensure a tight coupling, does not affect socket
    preload = 0.2,
    // Clearance gap between the pin and the socket opening, does not affect socket
    clearance = 0.2,
    // Thickness of cylinder wall around socket when printable
    cylinder_thickness = 0.8,
    
    thickness = 1.5,
    
    length = 10.8,
    
    diameter = 5,
    snap = 0.5,
    snapDepth = 1.8
) {
    translate([0, 0, length+cylinder_thickness])
    rotate([0, 180, 0])
    render(
        part = "socket_free",
        length = length,
        diameter = diameter,
        snap = snap,
        snapDepth = snapDepth,
        thickness = thickness,
        pointed = 1,
        fins = 0,
        preload = preload,
        clearance = clearance,
        printable = 1,
        shadowSocket = 1,
        spacing = 0,
        cylinderThickness = cylinder_thickness
    );
}
