// number of pegs
clip_count = 10; // [1:60]

// Width of one peg
clip_width = 16;

// Length of the pegs
clip_length = 30;

// Thickness of the peg walls 
clip_wall = 1.2;

// Height
clip_height = 4;
clip_distance = 3.5;
teeth_distance = 3.5;

// Space between the pegs.
gap = 0.2;

rod_diameter = 10; 
rod_wall = 2; // thickness of the rod clip wall

// Opening angle of the rod clip
alpha = 0; // [0.0:180.0]


$fn = 32;

// calculated
l = clip_count*clip_width + (clip_count-1)*(clip_distance + gap); // total length

// echo information
echo("total length is: ", l);

rotate([0, 0, 45])
difference() {
union() {

    // clips
    translate([0.5*clip_width, 0.5*rod_diameter + rod_wall, 0])
    for (i = [0:clip_count-1]) {
        dx = i*(clip_width+clip_distance+gap);
        
        translate([dx,0,0])
        difference() {
            
            // clip base
            union() {
                // clip shape
                translate([-0.5*clip_width,0,0])
                cube([clip_width, clip_length - 0.5*clip_width, clip_height]);                
                translate([0,clip_length - 0.5*clip_width,0]) 
                cylinder(h=clip_height, d=clip_width);
                
                // teeth
                translate([-0.5*clip_width, clip_length - 0.5*clip_width - 0.5*teeth_distance, 0]) 
                cylinder(h=clip_height, d=teeth_distance);
                translate([0.5*clip_width, clip_length - 0.5*clip_width - 0.5*teeth_distance, 0]) 
                cylinder(h=clip_height, d=teeth_distance);
                translate([-0.5*clip_width,0.5*(clip_length - 0.5*clip_width), 0]) 
                cylinder(h=clip_height, d=teeth_distance);
                translate([0.5*clip_width,0.5*(clip_length - 0.5*clip_width), 0]) 
                cylinder(h=clip_height, d=teeth_distance);
                
            }
            
            // clip inner pocket
            union() {
                translate([-0.5*clip_width+clip_wall,0,-0.5])
                cube([clip_width-2*clip_wall, clip_length - 0.5*clip_width, clip_height + 1]);
                
                translate([0,clip_length - 0.5*clip_width,-0.5]) 
                cylinder(h=clip_height + 1, d=clip_width-2*clip_wall);
            }
        }
    }

    // rod clip
    translate([0, 0, 0.5*rod_diameter+rod_wall])
    rotate([0, 90, 0])
    difference() {
        union() {
            // outer rod                
            cylinder(h=l, d=rod_diameter+2*rod_wall);                
            cube([0.5*rod_diameter + rod_wall, 0.5*rod_diameter + rod_wall, l]);
        }
        // rod hole
        translate([0, 0, -1])
        cylinder(h=l + 2, d=(rod_diameter));
        
        // opening
        translate([0,0,-1])
        linear_extrude(height=l+2) {
        polygon([
            [0,0],
            [-cos(0.5*alpha)*(0.5*rod_diameter + rod_wall),sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-(0.5*rod_diameter + rod_wall),sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-(0.5*rod_diameter + rod_wall),-sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)],
            [-cos(0.5*alpha)*(0.5*rod_diameter + rod_wall),-sin(0.5*alpha)*(0.5*rod_diameter + rod_wall)]
            ]);
        }
        
    }
}

translate([20, -10, 4])
cube([l - 40, 40, 20]);

translate([-1, 2, 4])
cube([l + 20, 6, 4]);
}