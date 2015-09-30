$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

////////////////////////////////////////////////////////////////////////////////
///
///  Knurled Coupling for Z-Axis of Mendel or i3
///  *******************************************
///
///  This is a parametrized coupling to connect the z-motor axis with the
///  threaded rod.  The diameters of the motor axis and the threaded rod
///  are parametrized, as is the outer size of the coupling.
///
///  Since I like to use the couplings also as "knobs" to manually mirco-adjust
///  the level and skewness of the hotend, I like the couplings to have a
///  good grip.  For this, I made the outside tp be "knurled".
///
///  The coupling is clamped to the motor axis and the threaded rod by
///  means of M3 grub screws.  The screws are hold by srcew nuts which are
///  sled into the provided nut cavities.
///
////////////////////////////////////////////////////////////////////////////////
///
///  2014-01-22 Heinz Spiess, Switzerland
///
///  released under Creative Commons - Attribution - Share Alike licence
////////////////////////////////////////////////////////////////////////////////


// The main module knurles_coupling() uses the following parameters:
// Di = [4,5];   // lower,upper inner diameter
// De = [19,20]; // lower,upper outer diameter
// Hi = [8,16];  // lower,upper inner height
// He = [16,10]; // lower,upper outer height
// H  = 28;      // overall height

// The following parameters can also be changed if needed:
Ds = 4.2;        // diameter of grub screw hole
Dn = 7.2;          // diameter of nut holding the grub screw
Hn = 3.1;        // thickness of nut holding the grub screw
Zs = 5;          // offset of grub screw from lower/upper end of coupling 
Ew = 1.2;       // extrusion width
pi = 3.14159;    // Pi - don't change!!!


////////////////////////////////////////////////////////////////////////////////
// constructs a knurled cone or cylinder
// r1,r2  start and end radius of cone
// h      height of cone
// k1,k2  start and end radius of knurls
// nk     number of knurls
// d      depth of knurl center (as a fraction of the radius)
module knurled_cone(r1,r2,h,k1=1,k2=1,nk=16,d=0.5){
  // main cylinder
  cylinder(r1=r1,r2=r2,h=h);
  // knurls
  for(a=[180/nk:360/nk:359.9])
    rotate(a-90)
      translate([r1-d*k1,0,0]) 
        multmatrix([[1,0,(r2-r1+d*(k1-k2))/h,0],[0,1,0,0],[0,0,1,0]]) // shearing xz!
          cylinder(r1=k1,r2=k2,h=h,$fn=12);
}
// shortcut for straight knurled cylinders
module knurled_cylinder(r,h,k=1,nk=12,d=0.5)
    knurled_cone(r1=r,r2=r,h=h,k1=k,k2=k,nk=nk,d=d);
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
module knurled_coupling(
	Di = [4,5],   // lower,upper inner diameter
 	De = [19,20], // lower,upper outer diameter
 	Hi = [8,16],  // lower,upper inner height
 	He = [16,10], // lower,upper outer height
 	H  = 28,      // overall height
	nk = 16,      // number of knurls
 	Ng = 1){      // number of grubscrews

   difference(){
     // outer body
     union(){ 
       // chamfered low end
       knurled_cone(r1=De[0]/2-1,r2=De[0]/2, h=1,k1=0,nk=nk);
       // lower main cylinder
       translate([0,0,0.99])knurled_cone(r1=De[0]/2,r2=De[0]/2, h=He[0]-0.98,nk=nk);
       // conical middle peace
       translate([0,0,He[0]-0.01])knurled_cone(r1=De[0]/2,r2=De[1]/2,h=H-He[0]-He[1]+0.02,nk=nk);
       // upper main cylinder
       translate([0,0,H-He[1]-0.01])knurled_cone(r1=De[1]/2,r2=De[1]/2,h=He[1]-0.99,nk=nk);
       // chamfered top end
       translate([0,0,H-1.01])knurled_cone(r1=De[1]/2,r2=De[1]/2-1,h=1.01,k2=0,nk=nk);
     }
     // lower cylindrical part of inner hole
     translate([0,0,-0.01])cylinder(r=Di[0]/2, h=Hi[0]+0.02,$fn=30);
     // conical middle part
     translate([0,0,Hi[0]-0.01])cylinder(r1=Di[0]/2,r2=Di[1]/2,h=H-Hi[0]-Hi[1]+0.02,$fn=30);
     // upper cylindrical part of inner hole
     translate([0,0,H-Hi[1]-0.01])cylinder(r=Di[1]/2,h=Hi[1]+0.02,$fn=30);

     // upper and lower screw holes and nut cavities
     for(ng = [0:Ng-1])rotate(ng*360/Ng)
       for(s=[[-1,Di[0]],[1,Di[1]]])
         translate([0,0,H/2]) // position on center height
           scale([1,1,s[0]])  // yes of no mirror on z-axis
	     translate([0,0,H/2-Zs]) // position grub screw hole Zs from top/bottom
               rotate([90,0,0]){     // cylinder direction parallel y-axis
	         // screw hole
                 cylinder(r=Ds/2,h=20); 
	         // nut cavity
	         hull()
	           for(z=[0,2*Zs]) // shift along z-axis
		     translate([0,z,s[1]/2+2*Ew]) // 2 extraction widths from screw hole
                       rotate(30) // rotate nut hexagone to optimal sliding position
		         cylinder(r=Dn/2/cos(30),h=Hn,$fn=6); // nut cavity
               }
   }
   %if(show_axes)color("gray",0.2){
     translate([0,0,-10])cylinder(r=Di[0]/2, h=Hi[0]+10,$fn=12);
     translate([0,0,H-Hi[1]])cylinder(r=Di[1]/2,h=Hi[1]+10,$fn=12);
   }
}

// Specific couplings for 4mm and 5mm motor axes and for 8mm (Mendel) and 5mm (i3) threaded rods

module knurled_coupling_5mm_5mm() //AUTO_MAKE_STL
    knurled_coupling(Di=[5.5,6.5],De=[26,26],Hi=[15,15],He=[15,15],H=32);

show_axes = 0;
knurled_coupling_5mm_5mm();
