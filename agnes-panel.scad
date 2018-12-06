$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

use <MCAD/boxes.scad>;

inch = 25.4;
tollerance = 0.1;

tft_h_hole_space = 1.55 * inch;
tft_v_hole_space = 1.50 * inch;
tft_h_size = 1.75 * inch;
tft_v_size = 1.70 * inch;
tft_h_screen_size = 1.13 * inch;
tft_v_screen_size = (1.3 - 2 * 0.11) * inch;
tft_screen_h_left_spacing = 0.3 * inch;
tft_screen_v_top_spacing = (tft_v_size - tft_v_screen_size) / 2;

tft_to_top_offset = 1;

tft_depth = 1.25 * inch;

arduino_top_margin = 1 / 8 * inch;

screw_d = 3 + tollerance;
screw_distance = 2;

button_size = 11 + 2 * tollerance; 
button_space = 4 - 2 * tollerance;

trellis = (button_size + button_space) * 4;
trellis_bottom_offset = screw_d + screw_distance + tollerance;
trellis_top_space = 0.25 * inch;

border = 2;

panel_w = trellis + 2 * border + 2 * tollerance;
panel_h = panel_w + tft_v_size + arduino_top_margin + border + trellis_bottom_offset;
panel_d = tft_depth + border;

usb_hole_w = 5 / 8 * inch;
usb_hole_h = 3 / 8 * inch;
usb_hole_d = 1 * inch;
usb_hole_from_tft_left = 1 * inch;

echo(panel_h);

// The center of the tft hole should be aligned with the center of the first button
tft_left_hole_center_offset = (button_size + button_space) / 2;

trellis_left = (panel_w - trellis) / 2;
trellis_bottom = trellis_left + trellis_bottom_offset;

arduino_bottom_from_tft_bottom = 1 * inch;
arduino_left_from_tft_left = 13 / 16 * inch;
arduino_base_w = 3 / 8 * inch;
arduino_base_h = 1 * inch;

round_r = 3;

//top();
bottom();

// Bottom
module bottom() {
    translate([-panel_w - 5, 0, 0])
    intersection() {
        difference() {
            union() {
                difference() {
                    translate([0, 0, 0]) cube([panel_w, panel_h, panel_d]);
                    color("white") translate([border, border, border + 1]) cube([panel_w -  2 * border, panel_h - 2 * border, panel_d - border + 1]);
                }
                
                // Corner screw pillars
                {
                    distance = screw_distance + screw_d / 2;
                    d = screw_d + screw_distance * 2;
                    translate([distance, distance , 0]) cylinder(d=d, h=panel_d);
                    translate([panel_w - distance, distance , 0]) cylinder(d=d, h=panel_d);
                    
                    translate([distance, panel_h - distance , 0]) cylinder(d=d, h=panel_d);
                    translate([panel_w - distance, panel_h - distance , 0]) cylinder(d=d, h=panel_d);
                }

                // To hold the trellis up
                size_w = trellis_left + border;
                translate([0, trellis_left + trellis + trellis_bottom_offset - border, 0]) cube([size_w, border + tollerance, panel_d - trellis_top_space]);
                translate([0, trellis_left + trellis + trellis_bottom_offset - border, 0]) cube([size_w - border - tollerance, border + tollerance, panel_d]);

                translate([panel_w - size_w, trellis_left + trellis + trellis_bottom_offset - border, 0]) cube([size_w, border + tollerance, panel_d - trellis_top_space]);
                translate([panel_w - size_w + border + tollerance, trellis_left + trellis + trellis_bottom_offset - border, 0]) cube([size_w - border - tollerance, border + tollerance, panel_d]);

                translate([0, trellis_left + trellis_bottom_offset, 0]) cube([size_w, border, panel_d - trellis_top_space]);
                translate([0, trellis_left + trellis_bottom_offset, 0]) cube([size_w - border - tollerance, border, panel_d]);
                
                translate([panel_w - size_w, trellis_left + trellis_bottom_offset, 0]) cube([size_w, border, panel_d - trellis_top_space]);
                translate([panel_w - size_w + border + tollerance, trellis_left + trellis_bottom_offset, 0]) cube([size_w - border - tollerance, border, panel_d]);

                translate([0, trellis_left + trellis + trellis_bottom_offset + tollerance, 0]) cube([size_w, border, panel_d - trellis_top_space + border]);
                translate([panel_w - size_w, trellis_left + trellis + trellis_bottom_offset + tollerance, 0]) cube([size_w, border, panel_d - trellis_top_space + border]);
                
                // To screw the tft
                difference() {
                    screw_x = trellis_left + tft_left_hole_center_offset;
                    screw_y = trellis + trellis_bottom + (tft_v_size - tft_v_hole_space) / 2;
                    union() {
                        d = screw_d + screw_distance * 2;
                        h = panel_d - border - tft_to_top_offset;
                        translate([screw_x, screw_y, 0]) cylinder(d=d, h=h);
                        translate([screw_x, screw_y + tft_v_hole_space, 0]) cylinder(d=d, h=h);
                        translate([0, screw_y-d/4, 0]) cube([screw_x, d/2,h]);
                        translate([0, screw_y-d/4+tft_v_hole_space, 0]) cube([screw_x, d/2,h]);
                    }
                    
                    union() {
                        d = screw_d;
                        translate([screw_x, screw_y, border]) cylinder(d=d, h=panel_d);
                        translate([screw_x, screw_y + tft_v_hole_space, border]) cylinder(d=d, h=panel_d);
                    }
                }
                
                // arduino base
                translate([trellis_left + tft_left_hole_center_offset + arduino_left_from_tft_left - (tft_h_size - tft_h_hole_space) / 2, trellis + trellis_bottom + tft_v_size / 2 - arduino_base_h / 2, 0]) cube([arduino_base_w, arduino_base_h, panel_d - border - arduino_bottom_from_tft_bottom]);
            }
            
            // corner screw holes
            {
                distance = screw_distance + screw_d / 2;
                d = screw_d;
                translate([distance, distance , border]) cylinder(d=d, h=panel_d);
                translate([panel_w - distance, distance , border]) cylinder(d=d, h=panel_d);
                
                translate([distance, panel_h - distance , border]) cylinder(d=d, h=panel_d);
                translate([panel_w - distance, panel_h - distance , border]) cylinder(d=d, h=panel_d);
            }

            // USB hole
            translate([trellis_left + tft_left_hole_center_offset + usb_hole_from_tft_left - (tft_h_size - tft_h_hole_space) / 2, panel_h - 1, panel_d - usb_hole_d]) rotate([90, 0, 0]) cube([usb_hole_w, usb_hole_h, border + 2], center = true);
            
        }
        translate([panel_w/2, panel_h/2, panel_d/2+round_r/2]) roundedBox([panel_w, panel_h, panel_d + round_r], radius = round_r);
    }
}

// Top
module top() {
    translate([panel_w, 0, border])
    rotate([0, 180, 0])
    intersection() {
        difference() {
            translate([0, 0, 0]) cube([panel_w, panel_h, border]);

            // Buttons
            translate([trellis_left, trellis_bottom, 0]) Buttons(4, 4, button_size, button_space, 11, 3);

            // TFT
            tft_hole_center_h_offset = (tft_h_size - tft_h_hole_space) /  2;
            tft_left = trellis_left + tft_left_hole_center_offset - tft_hole_center_h_offset + tft_screen_h_left_spacing;
            
            tft_bottom = trellis + trellis_bottom + (tft_v_size - tft_v_screen_size) / 2;

            translate([tft_left - tollerance, tft_bottom - tollerance, -1]) cube([tft_h_screen_size + 2 * tollerance, tft_v_screen_size + 2 * tollerance, border + 2]);

            // TFT housing
            translate([tft_left - tft_screen_h_left_spacing - tollerance, tft_bottom - 0.11 * inch - tollerance, -1]) cube([tft_h_screen_size + tft_screen_h_left_spacing + 3 + 2 * tollerance, tft_v_screen_size + 0.22 * inch + 2 * tollerance, border]);
            
            // Screws
            // Bottom
            distance = screw_distance + screw_d / 2;
            translate([distance, distance , -1]) cylinder(d=screw_d, h=border + 2);
            translate([panel_w - distance, distance , -1]) cylinder(d=screw_d, h=border + 2);
            
            // Top
            translate([distance, panel_h - distance , -1]) cylinder(d=screw_d, h=border + 2);
            translate([panel_w - distance, panel_h - distance , -1]) cylinder(d=screw_d, h=border + 2);
        }
        translate([panel_w/2, panel_h/2, border/2]) roundedBox([panel_w, panel_h, border], radius = round_r, sidesonly = true);
    }
}

module Button(size, radius, height) {
    
    offset = (size/2-radius);
    translate([size/2, size/2, 0])
        hull() {
            translate([-offset, -offset , 0]) cylinder(r=radius, h=height);
            translate([offset, -offset , 0]) cylinder(r=radius, h=height);
            translate([-offset, offset , 0]) cylinder(r=radius, h=height);
            translate([offset, offset , 0]) cylinder(r=radius, h=height); 
       }

}

module Buttons(x, y, buttonSize, buttonSpace, thickness, height) {
    // buttons matrix
    color("Aqua", 1.0) {
    
       for (i =[0:x-1]) {
            for (t =[0:y-1]) {
                translate([buttonSpace/2 + i*(buttonSize+buttonSpace), buttonSpace/2+t*(buttonSpace+buttonSize), height-thickness-.2]) 
                Button(buttonSize, buttonSize/8, thickness+4);
            }
        }
    } 
}
