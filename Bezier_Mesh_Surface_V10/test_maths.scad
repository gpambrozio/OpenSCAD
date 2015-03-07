//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// May 2011
//=====================================

include <maths.scad>


//=======================================
//	Functions
//=======================================
function LineRotations(v) = [atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]), 0, atan2(v[1], v[0])+90];

function parseSeg(seg) = [
	seg[0], 
	LineRotations(seg[1]-seg[0]), 
	VMAG(seg[1]-seg[0])
	];

//=======================================
// Test cases
//=======================================
testvector();
//testrotation();

//placeLine([[0,0,0], [0,10,0]]);
//testgetrot();

module testgetrot()
{
	v = [10,10,5];

	// Length
	phi = VMAG(v);

	// X - rotation
	rho = atan2(sqrt(v[0]*v[0]+v[1]*v[1]), v[2]);

	// Z - rotation
	theta = atan2(v[1], v[0]);

echo("PHI: ", phi);
echo("THETA: ", theta);
echo("RHO: ", rho);

	//rotate([45,0,90])
	//rotate([rho, 0, theta+90])
	rotate(getrot(v))
	cylinder(r=1, h=phi);
}

module placeLine(seg)
{
	params = parseSeg(seg);

echo("Segment: ", params);

	origin = params[0];
	rot = params[1];
	len = params[2];

//echo("ORIGIN ", params[0]);
echo("ROTATION: ", rot);
echo("LENGTH: ",len);

	translate(origin)
	rotate(rot)
	cylinder(r=1, h=len);
}

module testrotation()
{
	lowangle = 0;
	highangle = 45;
	steps = 1;
	len = 10;

	for (step = [0:steps])
	{
		assign(theta = lowangle +  (highangle-lowangle)*step/steps)
		{
			assign(x = len*sin(theta))
			assign(y = len*cos(theta))
			{
echo("X,Y: ", x, y);
echo("THETA: ", theta);
				//rotate([0,theta,0])
				//cylinder(r=1, h=len);

				placeLine([[0,0,0],[x,y,y]]);
			}
		}
	}
}

module testvector()
{
//	placeLine( [[2,2,2],[10,10,10]]);
//	placeLine( [[2,2,2],[5,10,10]]);

len = VMAG([0,10,0]);
echo("LEN: ", len);

	// Rotations in X-Z plane
	color([1,0,0]) placeLine([[0,0,0], [10,0,0]]);
//	color([1,0,0]) placeLine([[0,0,0], [10,0,10]]);

	color([0,1,0]) placeLine([[0,0,0], [0,10,0]]);
	color([0,0,1]) placeLine([[0,0,0], [0,0,10]]);

	placeLine([[2,2,2], [10,10,10]]);
//
//	echo("VANG x, [10,10,0]: ", VANG([1,0,0], [10,10,0]));
//
//	echo("VANG [0,0,0], [10,10,0]: ", VANG([0,0,0], [10,10,0]));
//
//	echo("VANG [1,1,1], [10,10,0]: ", VANG([1,1,1], [10,10,0]));

//	echo("VANG [1,0,0], [10,10,10]: ", VANG([1,0,0], [10,10,0]));
//	echo("VANG [0,1,0], [10,10,10]: ", VANG([0,1,0], [10,10,10]));
//	echo("VANG [0,0,1], [10,10,10]: ", VANG([0,0,1], [10,10,10]));

}
