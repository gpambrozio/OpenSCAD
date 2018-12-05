
$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm


difference() {
    scale([.15, .15, .1])
        surface(file = "VanLifeLogo.png", center = true, invert = true);
  
    translate([-150, -150, -29]) cube([300, 300, 20]);
}
