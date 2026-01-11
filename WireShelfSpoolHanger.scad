
// WireShelfSpoolHanger
//    2021-03-02 Jeff Spirko <spirko@gmail.com>, CC-BY-SA 4.0
// This is intended to allow hanging the spool hanger form a wire shelf
//  above the printer.

// These are the dimensions of a set of shelves from a
//   large hardware store chain in the US.
wire_diameter = 3.2;
wire_spacing = 20;

// echo(wire_spacing);

// Horizontal plate dimensions.  The width must be less than 
//   the spacing if it's to be installed from below.
l_plate = 1*wire_spacing + 4*wire_diameter;
w_plate = 10;
// Thickness of the thinnest part of the plate.
t_plate = 3;
// Full thickness of the plate
t_full = t_plate + wire_diameter/2;

// Mount dimensions, except where widened to make room for the holes.
t_mount = 8;
l_mount = 130;

// These are the mount points, spaced for the Creality spool mount
//   that came with the Ender 3 V2.
hole_spacing = 24;
hole_diameter = 5;

hanger_d = 10;

// Quality of holes.
$fs = 0.5;

// Easier to print upside-down
rotate([90,0,0]) {

  difference() { 
    union() {
      // Horizontal plate.
      translate([0,0,t_full/2]) 
        cube([l_plate, w_plate, t_full], center=true);
      // Vertical mounting block.
      translate([0,0,-l_mount/2-t_plate/2])
        cube([t_mount, w_plate, l_mount + t_plate], center=true);

      translate([0, hanger_d/2 + t_mount/4 + w_plate/2,-l_mount+hanger_d/2-t_plate/2]) 
        cube([t_mount, hanger_d + t_mount/2, hanger_d + t_plate], center=true);

      translate([0, hanger_d + t_mount/4 + w_plate/2,-l_mount+hanger_d]) 
        cube([t_mount, t_mount/2, hanger_d], center=true);
    }
    // Grooves for shelf wires
    for(i=[-0.5:1:0.5]) {
      translate([i*wire_spacing,0,0]) rotate([90,0,0])
        cylinder(r=wire_diameter/2, h=w_plate+1, center=true);
    }
    translate([0,w_plate/2+hanger_d/2,-l_mount+hanger_d]) rotate([90,0,90])
      cylinder(d=hanger_d, h=w_plate+1, center=true);
  }

}
