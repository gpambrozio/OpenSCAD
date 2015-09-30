// preview[view:south, tilt:top]

/* [Image] */

// Simple photos with many shades of light/dark areas work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface.dat"; // [image_surface:72x72]

// What layer height will you slice this at?  The thinner the better.
layer_height = 0.2;

// The lower the layer height, the more layers you can use.
number_of_layers = 20; // [8:20]

/* [Hidden] */

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
hole_radius = hole_diameter/2;
height = layer_height*number_of_layers;

lithopane(72, 72, 1, 1);

module lithopane(length, width, x_scale, y_scale) {
  union() {
    // take just the part of surface we want
    difference() {
      translate([0, 0, min_layer_height]) scale([x_scale,y_scale,height]) surface(file=image_file, center=true, convexity=5);
      translate([0,0,-(height+min_layer_height)]) linear_extrude(height=height+min_layer_height) square([length, width], center=true);
    }
    linear_extrude(height=layer_height*2) square([length+4, width+4], center=true);

    linear_extrude(height=height+min_layer_height) {
  	  difference() {
          square([length+4, width+4], center=true);
          square([length, width], center=true);
  	  }
    }
    
  }
}
