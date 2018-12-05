$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

// S-Hook Parametric design tool
// (c) 2011
// Adam Milner
// carmiac@gmail.com
// Released under Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0))
// Updated by William Adams for simplicity and hook opening beyond 180 degrees


// User adjustable parameters
hook_thickness = 5;  // How thick the body of the hok should be
width =  5;			// How wide the hook should be

top_hook_radius = 26;  // outer radius of the top hook
top_hook_opening = 110; // opening in degrees, does not include rounded end

bottom_hook_radius = 20/2; // outer radius of the bottom hook
bottom_hook_opening = 100; // opening in degrees, does not include rounded end


// Useful constants
goldenratio = 1.61803399;
joinfactor = 0.125;

s_hook(width, hook_thickness);

module wedge(angle, radius, thickness)
{
	degreesperslice = 5;
	numberofslices = angle / degreesperslice;
	side = radius*goldenratio;

	rotate([0, 0, 180])
	// To make a wedge, we use increments of 5 degrees and just generate
	// triangles, rotated appropriately
	for(slice=[0:numberofslices-1])
	{
		rotate([0, 0, slice*degreesperslice])
		linear_extrude(height =  thickness, center=true)
		polygon(points = [
			[0,0], 
			[0,side],
			[- side*sin(degreesperslice*1.01), side*cos(degreesperslice*1.01)]
		]);
	}
}

 module hook(width, hook_thickness, radius, opening, reflect) 
{
	flip = 1;

	if (reflect ==1)
		assign(flip = -1);

	union()
	{
		difference()
		{
			// Basic cylinder
			cylinder( h = width, r = radius, center = true);	
		
			// Remove the center
			cylinder( h = width+2*joinfactor, r = radius-hook_thickness, center = true);

			// Open it up with a wedge
			wedge(opening, radius, width+2*joinfactor);
		}
		
		// Put a rounded tip on the opening
		translate(v = [(radius - 0.5 * hook_thickness) * sin(opening),-1 * (radius - 0.5 * hook_thickness) * cos(opening),0])
		{
			cylinder( h = width, r = hook_thickness/2, center = true);
		}
	}
}


module s_hook(width, thickness)
{
	union(){	
		hook(width, thickness, top_hook_radius, top_hook_opening);
	
		translate(v = [0,-1 * (bottom_hook_radius + top_hook_radius - hook_thickness),0])
		{
			//bottom_hook();
			rotate([0,0,180])
			hook(width, thickness, bottom_hook_radius, bottom_hook_opening, 1);
		}
	}
}