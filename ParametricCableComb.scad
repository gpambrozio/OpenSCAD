// Parametric Cable Comb
//
// Jason Milldrum
// 22 November 2020

/* [Parameters] */
// The number of slots to hold cables
Cable_Slots = 8; // [2:15]

// Width of the cable slot
Slot_Width = 5.0; // [1:0.1:15]

// Projection distance from the wall
Comb_Depth = 50; // [20:5:100]

// Size of screw
Screw_Hole_Diameter = 5; // [4, 5, 6]

// Include edge screw holes?
Edge_Screw_Holes = true;

// Include center screw hole?
Center_Screw_Hole = false;

/* [Advanced] */
Back_Height = 25; // [20:50]
Comb_Thickness = 3; // [2:5]
Lip_Depth = 10; // [5:20]
Lip_Angle = 20; // [0:90]
Cutout_Margin = 10; // [5:30]
Chamfer_Depth = 1; // [1:0.5:4]

// Calculated Parameter
Comb_Width = (Cable_Slots) * (Slot_Width + Cutout_Margin) + Cutout_Margin;


module screw_holes() {
    if (Edge_Screw_Holes == true) {
        translate([-(Comb_Width / 2 - Screw_Hole_Diameter * 2), Comb_Depth - Comb_Thickness / 2, Back_Height / 2])
            rotate([270, 0, 0])
                union() {
                    cylinder(d=Screw_Hole_Diameter, h=Comb_Thickness);
                    cylinder(d=Screw_Hole_Diameter * 2,h=Comb_Thickness / 2);
                }
        translate([Comb_Width / 2 - Screw_Hole_Diameter * 2, Comb_Depth - Comb_Thickness / 2, Back_Height/2])
            rotate([270, 0, 0])
                union() {
                    cylinder(d=Screw_Hole_Diameter, h=Comb_Thickness);
                    cylinder(d=Screw_Hole_Diameter * 2,h=Comb_Thickness / 2);
            }
    }
    if (Center_Screw_Hole == true) {
        translate([0, Comb_Depth - Comb_Thickness / 2, Back_Height/2])
        rotate([270, 0, 0])
            union() {
                cylinder(d=Screw_Hole_Diameter, h=Comb_Thickness);
                cylinder(d=Screw_Hole_Diameter * 2,h=Comb_Thickness / 2);
            }
    }
}

module body() {
    // Back
    translate([
        0,
        Comb_Depth,
        Back_Height / 2
    ])
        cube([Comb_Width, Comb_Thickness, Back_Height], center=true);
    // Comb
    translate([
        0,
        (Comb_Depth / 2),
        Comb_Thickness / 2
    ])
        cube([Comb_Width, Comb_Depth, Comb_Thickness], center=true);
    // Lip
    rotate([-Lip_Angle, 0, 0])
        translate([-Comb_Width / 2, -Lip_Depth, 0])
            rotate([0, 90, 0])
                rotate([0, 0, 90])
                    linear_extrude(height = Comb_Width)
                        union(){
                            polygon([
                                [1, 0],
                                [Lip_Depth, 0],
                                [Lip_Depth, Comb_Thickness],
                                [1, Comb_Thickness]
                            ]);
                            offset(r=+0.8,$fn=24) offset(delta=-0.8,$fn=24)
                                polygon([
                                    [0, 0],
                                    [Lip_Depth, 0],
                                    [Lip_Depth, Comb_Thickness],
                                    [0, Comb_Thickness]
                                ]);
                        }
}

module cutout() {
    Cutout_Depth = (Lip_Depth * cos(Lip_Angle)) + Comb_Depth - Cutout_Margin;
    Cutout_Height = Lip_Depth + Comb_Thickness + 2;
    // Slot
    translate([
        -Slot_Width / 2,
        0,
        0
    ])
        cube([Slot_Width, Cutout_Depth - (Lip_Depth * cos(Lip_Angle)), Cutout_Height]);
    // Rounded end
    translate([
        0,
        Cutout_Depth - (Lip_Depth * cos(Lip_Angle)),
        0
    ])
        cylinder(h=Cutout_Height, r=Slot_Width / 2);
    // Chamfered end
    linear_extrude(height = Cutout_Height)
        polygon(points=[
            [Slot_Width / 2, 0],
            [(Slot_Width / 2) + Chamfer_Depth, -(Lip_Depth * cos(Lip_Angle))],
            [-((Slot_Width / 2) + Chamfer_Depth), -(Lip_Depth * cos(Lip_Angle))],
            [-Slot_Width / 2, 0],
        ]);
}


$fa = 1;
$fs = 0.4;

difference() {
    body();
    if(Cable_Slots % 2 == 0) {
        for (i=[0:1:Cable_Slots - 1]){
            translate([i * (Slot_Width + Cutout_Margin) - ((Slot_Width + Cutout_Margin) * (Cable_Slots / 2) - ((Slot_Width + Cutout_Margin) / 2)), 0, 0])
                cutout();
        }
    }
    else {
        for (i=[0:1:Cable_Slots - 1]){
            translate([i * (Slot_Width + Cutout_Margin) - (Slot_Width + Cutout_Margin) * ((Cable_Slots - 1) / 2), 0, 0])
                cutout();
        }
    }
    screw_holes();
}
