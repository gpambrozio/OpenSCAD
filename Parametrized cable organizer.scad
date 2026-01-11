


// external radius of base hexagon
w = 28;
// height of base hexagon
h = 80;
// base thickness
baseThickness = 1;
// border thickness
thickness = 1;

// number of hexagon on a horizontal row
xRow = 4;
// number of hexagon on a vertical row
yRow = 3;

// if true evry 2nd row had an additional hexagon so that the grid is simmetric
middleLineAddOne = true;

r = w / 2 / cos(30);
tt = thickness / cos(30);

module hexagon() {
  difference() {
    cylinder(r=r, h=h, $fn=6);
    translate([0,0,baseThickness]) {
      cylinder(r=r-tt, h=h, $fn=6);
    }
  }
}

for(j =[0:1:yRow-1]){
  if(j % 2 == 0){
    for(i =[0:1:xRow-1]){
      translate([r*j+w/4*j,(w-thickness)*i,0]){
        hexagon();
      }
    }
  } else {
    for(i =[(middleLineAddOne?-1:0):1:xRow-1]){
      translate([(3*r/2-tt)*j, (w-thickness)/2+(w-thickness)*i,0]){
        hexagon();
      }
    }
  }
}
