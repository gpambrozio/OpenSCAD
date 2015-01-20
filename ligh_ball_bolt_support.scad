
$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

bolt_height = 5.72;
wall_thickness = 2;
base_height = 6;

module side() {
    union() {
      translate([10, -10, -base_height/2]) cube([2, 20, bolt_height + wall_thickness + base_height/2]);
      translate([7,-10,bolt_height + wall_thickness]) cube([5, 20, 2]);
    }
}

module main() {
	difference() 
	{
	  cube([20, 20, base_height], center=true);
	  cylinder(r=4.6, h=10, center=true);
	  rotate([0,0,30]) cylinder(r=6.6, h=20, $fn=6);
	  translate([-11, -11, -base_height/2-1]) cube([11, 3, base_height + 2]);
	  translate([-11, 8, -base_height/2-1]) cube([11, 3, base_height + 2]);
	  translate([-11,7.9,-6]) cube([11, 0.1, 12]);
	  translate([-11,-8,-6]) cube([11, 0.1, 12]);
	}

	side();
}

module slide() {
	translate([-10, -10, -base_height/2]) cube([10, 2, base_height]);
	translate([-10, 8, -base_height/2]) cube([10, 2, base_height]);
	rotate([0,0,180]) side();
}

module make(what) {
	// rotation for better printing
	rotate([what=="main"?90:0,what=="main"?0:-90,0])
	difference() {
		if (what == "main") {
			main();
		} else {
			slide();
		}
		translate([-7.6,0,0]) rotate([90,0,0]) cylinder(d=what=="main" ? 2.7 : 3.1, h = 22, center=true);
	}	
}

make("main");
