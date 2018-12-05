// Heart Gears
// Note: the assembly is animated

use <MCAD/involute_gears.scad>
//use <../pin2.scad>

assembly();
*plate();
*%cube([220,140,1],center=true);

//Numbers of teeth on gears
type=2;//[0:18 & 9,1:9 & 6,2:18 & 15]
//Space between gear teeth
Backlash=0.5;
// get heart.stl from emmett's Thing:6190
hs=100;// heart size (width)
hz=-10;// heart z-position (motion relative to 100mm original height)
rf1=60;// distance from center of cube to end of gear 1 (before clipping)
cp=0.22;// percentage of rf1 for the center block

R1=[[0,0,0],
	[0,0,180],
	[0,180,90],
	[0,180,-90]];

NR=[[18,9,0.7493,0.3746,1],
	[9,6,0.6860,0.4573,2],
	[18,15,0.6285,0.5238,5]];

Nr=NR[type];
n1=Nr[0];// number of teeth on gear 1
n2=Nr[1];// number of teeth on gear 2
r1=Nr[2];// these two numbers come from gearopt.m
r2=Nr[3];
nt=Nr[4];// number of turns per cycle
dc=rf1/sqrt(1-pow(r1,2));
theta=asin(1/sqrt(3));
pitch=360*r1*dc/n1;
rf2=sqrt(pow(dc,2)-pow(r2*dc,2));

module base()// This is the module for the outer shape
rotate([theta-90,0,0])rotate([0,0,30])scale(hs/100)translate([0,0,hz])
	render(convexity=4)import("heart.stl");

module plate(){
translate([-80,30,0])rotate([0,0,60])gear2(R1[0]);
translate([-30,30,0])rotate([0,0,30])gear1(R1[0]);
translate([80,40,0])rotate([0,0,60])gear2(R1[1]);
translate([30,40,0])rotate([0,0,30])gear1(R1[1]);
translate([80,-10,0])rotate([0,0,-150])gear1(R1[2]);
translate([30,-10,0])rotate([0,0,-120])gear2(R1[2]);
translate([-30,-30,0])rotate([0,0,-120])gear2(R1[3]);
translate([-80,-30,0])difference(){
	rotate([0,0,30])gear1(R1[3]);
	translate([0,-6,48-rf1*cp])rotate([35,0,0])rotate([0,0,180])monogram();
}
translate([10,-45,rf1*cp])center();
for(i=[0:7])translate([35+9*i,-45,0])pinpeg();
}

module assembly(){
center();
for(i=[0:3]){
	rotate(-[theta-90,0,0])rotate(R1[i])rotate(-[0,90-theta,0])
		rotate([0,0,nt*360*$t])translate([0,0,rf1*cp])gear1(R1[i]);
	rotate(-[theta-90,0,0])rotate(R1[i])rotate(-[90-theta,0,0])
		rotate([0,0,-nt*n1/n2*360*$t])translate([0,0,rf2*cp])gear2(R1[i]);
}}

module center(){
intersection(){
	box();
	rotate([2*(90-theta),0,0])box();
	rotate([2*(90-theta),0,120])box();
	rotate([2*(90-theta),0,-120])box();
}}

module box(){
render(convexity=4)
translate([0,0,(rf2-rf1)*cp/2])difference(){
	cube(size=[dc,dc,(rf1+rf2)*cp],center=true);
	translate([0,0,-(rf1+rf2)*cp/2])pinhole(fixed=true,fins=false);
	rotate([180,0,0])translate([0,0,-(rf1+rf2)*cp/2])pinhole(fixed=true,fins=false);
}}

module gear1(R){
intersection(){
	translate([0,0,-rf1*cp])rotate([0,90-theta,0])rotate(R)base();
	difference(){	
		translate([0,0,rf1*(1-cp)])rotate([180,0,180+180/n1])
		render(convexity=4)bevel_gear (number_of_teeth=n1,
			outside_circular_pitch=pitch,
			cone_distance=dc,
			face_width=dc*(1-cp),
			bore_diameter=0,
			backlash=Backlash,
			finish=0);	
		#pinhole(fixed=false);	
	}
}}

module gear2(R){
intersection(){
	translate([0,0,-rf2*cp])rotate([90-theta,0,0])rotate(R)base();
	difference(){
		translate([0,0,rf2*(1-cp)])rotate([180,0,-150])
		render(convexity=4)bevel_gear (number_of_teeth=n2,
			outside_circular_pitch=pitch,
			cone_distance=dc,
			face_width=dc*(1-cp),
			bore_diameter=0,
			backlash=Backlash,
			finish=0);
		#pinhole(fixed=false);
	}
}}

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[3,2.5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}

// Parametric Snap Pins (http://www.thingiverse.com/thing:213310)

module pin(r=3.5,l=13,d=2.4,slot=10,nub=0.4,t=1.8,space=0.3,flat=1)
translate(flat*[0,0,r/sqrt(2)-space])rotate((1-flat)*[90,0,0])
difference(){
	rotate([-90,0,0])intersection(){
		union(){
			translate([0,0,-0.01])cylinder(r=r-space,h=l-r-0.98);
			translate([0,0,l-r-1])cylinder(r1=r-space,r2=0,h=r-space/2+1);
			translate([nub+space,0,d])nub(r-space,nub+space);
			translate([-nub-space,0,d])nub(r-space,nub+space);
		}
		cube([3*r,r*sqrt(2)-2*space,2*l+3*r],center=true);
	}
	translate([0,d,0])cube([2*(r-t-space),slot,2*r],center=true);
	translate([0,d-slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
	translate([0,d+slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
}

module nub(r,nub)
union(){
	translate([0,0,-nub-0.5])cylinder(r1=r-nub,r2=r,h=nub);
	cylinder(r=r,h=1.02,center=true);
	translate([0,0,0.5])cylinder(r1=r,r2=r-nub,h=5);
}

module pinhole(r=3.5,l=13,d=2.5,nub=0.4,fixed=false,fins=true)
intersection(){
	union(){
		translate([0,0,-0.1])cylinder(r=r,h=l-r+0.1);
		translate([0,0,l-r-0.01])cylinder(r1=r,r2=0,h=r);
		translate([0,0,d])nub(r+nub,nub);
		if(fins)translate([0,0,l-r]){
			cube([2*r,0.01,2*r],center=true);
			cube([0.01,2*r,2*r],center=true);
		}
	}
	if(fixed)cube([3*r,r*sqrt(2),2*l+3*r],center=true);
}

module pinpeg(r=3.5,l=13,d=2.4,nub=0.4,t=1.8,space=0.3)
union(){
	pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
	mirror([0,1,0])pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
}