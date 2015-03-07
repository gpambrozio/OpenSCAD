//=====================================
// This is public Domain Code
// Contributed by: William A Adams
// 11 May 2011
//=====================================
include <maths.scad>
include <bezier.scad>



//=======================================
//
// 				Tests
//
//=======================================

//gcp1 = [[0,0,0], [1,-1,0], [2,-1,0], [2.5,0.5,0]]; 
//gcp2 = [[0,1,1], [1,1,2], [2,1,2], [3,1,1]]; 
//gcp3 = [[0,2,1], [1,2,2], [2,2,2], [3,2,1]]; 
//gcp4 = [[0,3,0], [1,4,0], [2,4,0], [3,3,0]]; 

//gcp4 = [[0,3,0], [1,4,0], [2,4,0], [3,3,0]]; 
//gcp3 = [[0,2,1], [1,2,2], [1.5,2.5,1.5], [2,2,0.5]]; 
//gcp2 = [[0,1,1], [1,1,2], [1.5,0.5,1.5], [2,1,0.5]]; 
//gcp1 = [[0,0,0], [1,-1,0], [2,-1,0], [3,0,0]]; 

gcp4 = [[0,30,0], [10,40,0], [20,40,0], [30,30,0]]; 
gcp3 = [[5,20,10], [10,20,20], [15,25,15], [20,20,5]]; 
gcp2 = [[5,10,10], [10,10,20], [15,5,15], [20,10,5]]; 
gcp1 = [[0,0,0], [10,-10,0], [20,-10,0], [30,0,0]]; 

//DisplayBezCurvePoints(gcp1, steps=18, $fn=12);
//DisplayBezCurvePoints(gcp2, steps=36, $fn=12);
//DisplayBezCurvePoints(gcp3, steps=54, $fn=12);
//DisplayBezCurve(gcp1, steps=72, $fn=12);

//DisplayBezMeshPoints([gcp1, gcp2, gcp3, gcp4], steps=36, $fn=12);

//PlaceLine([[0,0,0], [10,10,10]], $fn=12);

//DisplayBezControlFrame([gcp1, gcp2, gcp3, gcp4], $fn=3);
DisplayBezCurveFrame([gcp1, gcp2, gcp3, gcp4], steps=24, $fn=6);

//DisplayBezControlFrame([gcp1, gcp2, gcp3, gcp4], $fn=3);
//DisplayBezSurface([gcp1, gcp2, gcp3, gcp4], steps=16, thickness=3);


//=======================================
//
// 				Functions
//
//=======================================

function parseSeg(seg) = [ 
	seg[0], 
	LineRotations(seg[1]-seg[0]), 
	VMAG(seg[1]-seg[0])
	];

function sNorm(tri) = VUNIT(VCROSS(tri[2]-tri[1],  tri[0]-tri[1]));

function triNormals(tri) = [sNorm([tri[2],tri[0],tri[1]]), 
				sNorm([tri[0],tri[1],tri[2]]), 
				sNorm([tri[1],tri[2],tri[0]])];

function quadtrans(quad, trans) = [
	VSUM(quad[0], trans), 
	VSUM(quad[1], trans),
	VSUM(quad[2], trans),
	VSUM(quad[3], trans)];

//=========================================
//		Modules
//=========================================
module PlaceLine(seg, radius=0.025) 
{
	params = parseSeg(seg);

//echo("Segment: ", params,r);

	origin = params[0];
	rot = params[1];
	len = params[2];

//echo("ORIGIN ", params[0]);
//echo("ROTATION: ", rot);
//echo("LENGTH: ",len);

	translate(origin)
	rotate(rot)
	cylinder(r=radius, h=len, $fn=12);
	//cube(size=[radius, radius, len]);
}

//module PlaceTriangle(verts, reverse = 0)
//{
//	if (reverse == true)
//	{
//		polyhedron(points=[verts[0], verts[1],verts[2]], 
//			triangles=[[0,1,2]]);
//	} else		
//	{
//		polyhedron(points=[verts[0], verts[1],verts[2]], 
//			triangles=[[2,1,0]]);
//	}
//}
//
//module PlaceQuad(quad) 
//{
//	PlaceTriangle([quad[0], quad[1], quad[2]]);
//	PlaceTriangle([quad[0], quad[2], quad[3]]);
//}



// Display a polyhedron with some thickness
module DisplayTriShard(shard)
{
	polyhedron(
		points=[
			shard[0][0], shard[0][1],shard[0][2], 		// Top
			shard[1][0], shard[1][1], shard[1][2]],		// Bottom
		triangles=[
				[0,2,1],
				[3,4,5],
				[1,5,4],
				[1,2,5],
				[2,3,5],
				[2,0,3],
				[0,4,3],
				[0,1,4]
				]);
}

//module DisplayTriangle(verts, thickness=1)
//{
//	// get the normals for each of the corners
//	tNorms = triNormals(verts);
//	stems = [
//			verts[0]+tNorms[0]*thickness*-1,
//			verts[1]+tNorms[1]*thickness*-1,
//			verts[2]+tNorms[2]*thickness*-1
//			];
//
////echo("NORMALS: ", tNorms);
////echo("STEMS: ", stems);
// 
//	DisplayShard([verts,stems]);
//}
//

module DisplayQuadShard(quad, thickness=1) 
{
	lowquad = quadtrans(quad, [0,0,-thickness]);
//echo("QUAD: ", quad);
//echo("LOW QUAD: ", lowquad);

	DisplayTriShard([[quad[0],quad[1],quad[2]],
		[lowquad[0], lowquad[1], lowquad[2]]]);

	DisplayTriShard([[quad[0],quad[2],quad[3]],
		[lowquad[0], lowquad[2], lowquad[3]]]);
}

module DisplayBezControlPoints(cps)
{
	side = 0.125;

	for(pt = cps)
	{
		translate(pt)
		color([0,0,1])
		sphere(r=side);
	}
}

module DisplayBezCurvePoints(cps, steps=3)
{
	side = 0.25*(3/steps);

	for (astep=[0:steps])
	{
		assign(pt = PtOnBez(cps, astep/steps))
		{
			translate(pt)
			//cube(size=[side, side, side]);
			sphere(r=side);
		}
	}
}


module DisplayQuadFrame(quad, radius=0.125)
{
//echo("QUAD: ", quad);

	PlaceLine([quad[0], quad[1]], radius);
	PlaceLine([quad[1], quad[2]], radius);
	PlaceLine([quad[2], quad[3]], radius);
	PlaceLine([quad[3], quad[0]], radius);
}

module DisplayBezCurve(cps, steps=6)
{
	DisplayBezControlPoints(cps);
	DisplayBezCurvePoints(cps, steps);
}

module DisplayBezMeshPoints(mesh, steps=6)
{
	side = 1.25*(6/steps);
	DisplayBezControlPoints(mesh[0]);
	DisplayBezControlPoints(mesh[1]);
	DisplayBezControlPoints(mesh[2]);
	DisplayBezControlPoints(mesh[3]);

	for (ustep = [0:steps]) 
	{
		for(vstep=[0:steps])
		{
			assign(vpt = PtOnBezMesh(mesh, [ustep/steps, vstep/steps]))
			translate(vpt)
			sphere(r=side);
		}
	}
}

module DisplayBezControlFrame(mesh, radius=0.125)
{
	for (row=[0:2])
		for (column=[0:2])
		{
			color([0,1,1])
			DisplayQuadFrame(GetControlQuad(mesh, [row,column]), radius);
		}
}

module DisplayBezCurveFrame(mesh, 
	colors=[[1,1,0],[1,1,0],[1,1,0],[1,1,0]], 
	steps=4)
{
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			assign(ufrac1 = ustep/steps)
			assign(ufrac2 = (ustep+1)/steps)
			assign(vfrac1=vstep/steps)
			assign(vfrac2=(vstep+1)/steps)
			assign(quad = GetCurveQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]))
			{
				DisplayQuadFrame(quad, 36);
			}
		}
	}
}

module DisplayBezSurface(mesh, 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]], 
	steps=4, thickness=1)
{
	for (ustep = [0:steps-1])
	{
		for (vstep=[0:steps-1])
		{
			assign(ufrac1 = ustep/steps)
			assign(ufrac2 = (ustep+1)/steps)
			assign(vfrac1=vstep/steps)
			assign(vfrac2=(vstep+1)/steps)
			assign(quad = GetCurveQuad(mesh, [ufrac1,vfrac1], [ufrac2,vfrac2]))
			{
				assign(acolor = PtOnBez(colors, vfrac1))
				{
					echo("COLOR: ", acolor);
					color([acolor[0], acolor[1], acolor[2], ufrac1/vfrac2])
					DisplayQuadShard(quad, thickness=thickness);
				}
			}
		}
	}
}