$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

border_diameter = 28;
border_thickness = 2;
outside_diameter = 24;
lips_width = 1.8;
inside_diameter = 22;
height = 17;
head_height = 3;
shaft_diameter = 6.2;
shaft_notch = 2.5;
shaft_height = 11;

sensor_notch = 2;

difference() {
	intersection() {
		union() {
			cylinder(d=border_diameter, h=border_thickness);
			cylinder(d=inside_diameter, h=height+head_height);
			
			intersection() {
				cylinder(d=outside_diameter, h=height+head_height);
				union() {
					translate([0,0,(height+head_height)/2]) cube([outside_diameter+2, lips_width, height + head_height + 2], center=true);
					rotate([0,0,90]) translate([0,0,(height+head_height)/2]) cube([outside_diameter+2, lips_width, height + head_height + 2], center=true);
				}
			}
		}
		
		
		union() {
			translate([0,0,height]) cylinder(d=outside_diameter, d2 = outside_diameter/2, h=head_height);
			translate([0,0,height/2]) cube([border_diameter+2, border_diameter+2, height], center=true);
		}
	}
	
	translate([0,0,-1]) 
		difference() {
			union() {
				cylinder(d=shaft_diameter, h=shaft_height + 1);
				translate([0,0,shaft_height+1]) cylinder(d=shaft_diameter, d2 = 1, h=2);
			}
			translate([-shaft_diameter/2-1,shaft_notch,-1]) cube([shaft_diameter+2, shaft_diameter + 2, shaft_height + 3]);
	}
}

intersection() {
	cylinder(d=border_diameter + 2 * sensor_notch, h=border_thickness);
	translate([border_diameter/3,-sensor_notch/2,-1]) cube([border_diameter / 4 + sensor_notch, sensor_notch, border_thickness + 2]);
}
translate([sensor_notch + border_diameter/2,sensor_notch/2,0]) rotate([0,0,135]) cube([border_diameter / 2, sensor_notch, border_thickness]);
scale([1,-1,1]) translate([sensor_notch + border_diameter/2,sensor_notch/2,0]) rotate([0,0,135]) cube([border_diameter / 2, sensor_notch, border_thickness]);
