$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

w = 60;
h = 5.08;

union() {
    
    rotate([90, 0, 0]) import("/Users/gustavoambrozio/Dropbox/MyDocuments/3DModels/OpenSCAD/Body1_Paddle_Holder_v2.STL");
    translate([0, 0, h/2]) cube([w, w, h], center = true);
}

