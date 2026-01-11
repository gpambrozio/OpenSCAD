/*
 Knob for M3, M4 & M5 socket cap head screws
 By David Jenkins. (C) 2022
 
 This work is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License as published by the Free Software
 Foundation; version 2.

 This work is distributed in the hope that it will be useful, but WITHOUT ANY
 WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 A PARTICULAR PURPOSE. See the version 2 of the GNU General Public License for
 more details.
*/

include <chamfer.scad>

// M3 sizes
m3ThreadDiam = 3.4;     // to suit M3 screw
m3HeadDiam = 6;         // to fit screw head
m3HeadHeight = 2.9;     // thickness of screw head
m3NutDiam = 6.8;        // to form a 6-sided hole for M3 nut
m3NutHeight = 2.5;      // thickness of M3 nut
m3NylocHeight = 4;      // thickness of nyloc M3 nut
m3KnobDiam = 12;        // outside knob diam
m3IndentDiam = 2;       // size of the grip indents
m3IndentDepth = 0.25;   // depth of grip indents

// M4 sizes
m4ThreadDiam = 4.5;     // to suit M4 screw
m4HeadDiam = 7.4;       // to fit screw head
m4HeadHeight = 4;       // thickness of screw head
m4NutDiam = 8.5;        // to form a 6-sided hole for M3 nut
m4NutHeight = 3.2;      // thickness of standard M4 nut
m4NylocHeight = 5;      // thickness of nyloc M4 nut
m4KnobDiam = 14;        // outside knob diam
m4IndentDiam = 2.5;     // size of the grip indents
m4IndentDepth = 0.3;    // depth of grip indents

// M5 sizes
m5ThreadDiam = 5.4;     // to suit M5 screw
m5HeadDiam = 9;         // to fit screw head
m5HeadHeight = 5;       // thickness of screw head
m5NutDiam = 9.6;        // to form a 6-sided hole for M5 nut
m5NutHeight = 4;        // thickness of M5 nut
m5NylocHeight = 5;      // thickness of M5 nut
m5KnobDiam = 16;        // outside knob diam
m5IndentDiam = 2.8;     // size of the grip indents
m5IndentDepth = 0.35;   // depth of grip indents

indents = 10;           // number of indents on the knob surface

threadSize = "M4";
nylocNut = false;

module knob(threadDiam, headDiam, headHeight, nutDiam, nutHeight, knobDiam, indentDiam, indentDepth)
{
    knobHeight = headHeight + nutHeight + 3;
    
    difference()
    {
        // body
        chamferCylinder(knobHeight, knobDiam/2);
        
        // screw hole
        cylinder(d = threadDiam, h = knobHeight, $fn = 50);
        
        // screw-head hole
        translate( [0, 0, -0.1] )
            cylinder(d = headDiam, h = headHeight + 0.1, $fn = 50);
        
        // nut hole
        translate( [0, 0, knobHeight - nutHeight] )
            cylinder(d = nutDiam, h = nutHeight + 0.1, $fn = 6);
        
        // grip
        for (i = [0 : indents] )
        {
            rotate( ( i * 360 / (indents)) + 24)
                translate([0, knobDiam/2 + indentDepth, -0.1])
                    cylinder(d = indentDiam, h = knobHeight + 0.2, $fn = 50);
        }
    }
}

if(threadSize == "M3")
{
    if(nylocNut)
        knob(m3ThreadDiam, m3HeadDiam, m3HeadHeight, m3NutDiam, m3NylocHeight, m3KnobDiam, m3IndentDiam, m3IndentDepth);
    else
        knob(m3ThreadDiam, m3HeadDiam, m3HeadHeight, m3NutDiam, m3NutHeight, m3KnobDiam, m3IndentDiam, m3IndentDepth);
}
else if(threadSize == "M4")
{
    if(nylocNut)
        knob(m4ThreadDiam, m4HeadDiam, m4HeadHeight, m4NutDiam, m4NylocHeight, m4KnobDiam, m4IndentDiam, m4IndentDepth);
    else
        knob(m4ThreadDiam, m4HeadDiam, m4HeadHeight, m4NutDiam, m4NutHeight, m4KnobDiam, m4IndentDiam, m4IndentDepth);
}
else if(threadSize == "M5")
{
    if(nylocNut)
        knob(m5ThreadDiam, m5HeadDiam, m5HeadHeight, m5NutDiam, m5NylocHeight, m5KnobDiam, m5IndentDiam, m5IndentDepth);
    else
        knob(m5ThreadDiam, m5HeadDiam, m5HeadHeight, m5NutDiam, m5NutHeight, m5KnobDiam, m5IndentDiam, m5IndentDepth);
}
