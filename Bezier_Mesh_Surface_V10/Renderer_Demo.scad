//===================================== 
// This is public Domain Code
// Contributed by: William A Adams
// 25 May 2011
//=====================================

include <Renderer.scad>

function offsetted_curve(i) = [[0,0,0+i], [1,-1,0+i], [2,-1,0+i], [2.5,0.5,0+i]]; 


// This one does not do so well because it is 'vertical', so it folds
// on itself when doing a z-axis extrusion
// It cam be easily improved by laying out the vertices such that
// the z-axis extrusion is more clear
//DisplayBezSurface([cp1,cp2,cp3,cp4], 
//	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
//	steps=16, thickness=2);


// This one does fine as it is mostly 'flat' with respect to the 
// x-y plane
DisplayBezSurface([offsetted_curve(0), offsetted_curve(1), offsetted_curve(2), offsetted_curve(3)], 
	colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]],
	steps=16);


