use<write.scad>
translate([-2,-14,-2])
cube([50,32,2]);
color([.5,.5,.5])
write("Black Rose Font @ :) ",font="blackrose.dxf",space=.8);
translate([0,6,0])
color([1,0,0])
write("Orbitron Font",font="orbitron.dxf");
translate([0,-6,0])
color([0,1,0])
write("KneWave Font",font="knewave.dxf");
translate([0,-12,0])
color([0,0,1])
write("Letters Font",font="letters.dxf");
translate([0,12,0])
color([1,1,0])
write("Braille Font",font="braille.dxf",space=1.25);