$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

text_depth = 9;
text_base = 5;

w = 138;
h = 88;
d = 0.6;

border_h = 4;

union() {
    
    difference() {
        scale(1.2157) import("/Users/gustavoambrozio/Dropbox/MyDocuments/3DModels/Hawaii.STL", convexity=3);
        union() {
            translate([w/2+9, 0, 10+border_h]) cube([20, 100, 20], center = true);
            translate([-w/2-9, 0, 10+border_h]) cube([20, 100, 20], center = true);
            translate([0, h/2+9, 10+border_h]) cube([200, 20, 20], center = true);
            translate([0, -h/2-9, 10+border_h]) cube([200, 20, 20], center = true);
        }
    }
    //translate([0, 0, d/2]) cube([w, h, d], center = true);

    name("Hawaii", 0.6, [29, -40, 0]);

    name("Maui", 0.6, [32, 0, 0]);
    
    name("Molokai", 0.6, [11, 15, 0]);
    
    name("Oahu", 0.6, [-15, 3, 0]);
    
    name("Kauai", 0.6, [-39, 31, 0]);

    name("Niihau", 0.6, [-50, 11, 0]);
}

module name(text, scale, offset) {
    translate(offset)
    union() {
        
        hull() {
            linear_extrude(height=text_base) 
            scale(scale) 
            text(text, valign = "bottom", halign = "center");
        }
        
        linear_extrude(height=text_depth) 
        scale(scale)
        text(text, valign = "bottom", halign = "center");
    }
}