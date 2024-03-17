$fn = 300;

D_CABLE = 4;

BT = 1.2;
T = 2.4;
UT = 1.2;

LAYER_H = 0.2;
LAYER_W = 0.4;

difference()
{
  union()
  {
    translate([-6,-6,0]) cube([12, 11-1.6, BT]);
    translate([-4,-5,BT]) cube([8, 10, T]);
    translate([-6,-6,BT+T]) cube([12, 12, UT]);
    translate([0,0,BT+T+UT]) cylinder(d1=10, d2 = D_CABLE+LAYER_W*2, h = 10);
    // Support middle cube
    difference()
    {
      translate([-4,-5,0]) cube([8, 10, BT]);
      translate([-4+LAYER_W,-5+LAYER_W,-1]) cube([8-LAYER_W*2, 10-LAYER_W*2, BT+2]);
    }
    // Support upper cube
    difference()
    {
      translate([-6,-6,0]) cube([12, 12, BT+T]);
      translate([-6+LAYER_W,-6+LAYER_W,-1]) cube([12-LAYER_W*2, 12-LAYER_W*2, BT+T+2]);
    }
    //// First layer
    //translate([-6,-6,0]) cube([12, 12, LAYER_H]);
  }
  translate([0,0,-1]) cylinder(d = D_CABLE, h = 100);
}