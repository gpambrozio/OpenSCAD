// preview[view:south, tilt:top]

/* [Image] */

// Simple photos with many shades of light/dark areas work best. Don't forget to click the Invert Colors checkbox!
image_file = "/Users/gustavo/Downloads/lithoplane.dat"; // [image_surface:72x72]
original_size = 512;

/* [Hidden] */

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
height = 3.2 - min_layer_height;

lithopane(72, 72, 1, 1);

module lithopane(length, width, x_scale, y_scale) {
  union() {
    translate([0, 0, min_layer_height]) 
      mirror([1, 0, 0]) 
      mirror([0, 1, 0]) 
      scale([length/original_size,width/original_size,height/256]) 
      surface(file=image_file, center=true, convexity=5);
    
    linear_extrude(height=min_layer_height) 
      square([length+4, width+4], center=true);

    linear_extrude(height=height+min_layer_height) {
  	  difference() {
          square([length+4, width+4], center=true);
          square([length, width], center=true);
  	  }
    }
    
  }
}
