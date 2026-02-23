$fn=50;
T = 2.4;

DBW = 55; // Display Board Width
DBL = 96; // Display Board Length
BT = 1.6; // Board thickness
EDB = 9.4-2.54*2;  // Distance betweeen encoder edge and screen board
ED = EDB+1.85; // Distance betweeen encoder edge and screen glass
DBH = 0.4; // Distance between display board and hole in prototype board

CP = 105.6; // MicroSD card placement

BOTTOM_H = T+2+BT;
LOCK_H = 1.6;

R = 3;
W = 60;
L = W+DBL+EDB+R*2-0.6;//171;//172.45;
H = 20 - BOTTOM_H;

PEG_D = 7;

LAYER_H = 0.2;

// Disable parts for fast update during development
FOR_PRINT = 0;
DRAW_BUTTONS = 0;
DRAW_BUTTON_HOLES = 1;

//rotate([0,180,0]) scale([0.98,0.98,1]) Button(0.98);
Top();
//Bottom();
//translate([75,0,0]) Bottom();
//translate([0,0,H+BOTTOM_H]) rotate([0,180,0]) Bottom();

//rotate_extrude(convexity = 10) translate([(3.5+T)/2, 0, 0]) circle(d = T);

module Button(S)
{
  difference()
  {
    union()
    {
      translate([0,0,0]) ButtonBase(1, 3.6, 1.2);
      translate([0,0,1]) ButtonBase(2.4, 2.3, 0);
    }
    // Left button
    translate([-7.3/S/2,-7.3/S/2,-0.1]) cube([7.3/S,7.3/S,1+2.4-1.2+0.1]);
    translate([0,0,0]) cylinder(d=4/S, h=1+2.4-0.6);
  }
  //translate([0,0,2+2.4-1.5]) ButtonBase(LAYER_H, 2.3, 0);
}
      
module ButtonBase(T, D, DR)
translate([-(+2.54*9)-0.3,-(W/2+EDB-DBH-2.54*2)-0.3,0]) difference()
{
  H = 4;
  X1 = RotateX(0,W/2+H,42);
  Y1 = RotateY(0,W/2+H,42);
  X2 = RotateX(0,W/2+H,30);
  Y2 = RotateY(0,W/2+H,30);
  hull()
  {
    translate([X1,Y1,0]) cylinder(d=D, h=T);
    translate([X2,Y2,0]) cylinder(d=D, h=T);
    translate([(DBW-3)/2,Y1,0]) cylinder(d=D, h=T);
    translate([(DBW-3)/2,W/2+ED-2.4-D/2+DR/2,0]) cylinder(d=D, h=T);
    translate([X2,W/2+ED-2.4-D/2+DR/2,0]) cylinder(d=D, h=T);
  }
  translate([0,0,-0.1]) cylinder(d=W+H*2-R-DR, h=T+0.2);
}

// *******************************************************************
// ***   Bottom module   *********************************************
// *******************************************************************
module Bottom()
{
  if(FOR_PRINT)
  {
    translate([0,L/2-W/2-2,0]) CubeR(W, L-7, LAYER_H, 10);
  }
  difference()
  {
    union()
    {
      // Case shell
      difference()
      {
        union()
        {
          Case(W+R*2, L, BOTTOM_H, R);
          translate([0,0,LOCK_H]) Case(W+R*2-T*2, L-T*2, BOTTOM_H, R-T);
        }
        translate([0,0,T])  Case(W+R*2-T*3, L-T*3, BOTTOM_H+T, R-T);
      }
      // Screw pegs
      rotate([0,0,180]) translate([0,(W-PEG_D)/2,0]) cylinder(d=6, h=BOTTOM_H);
      rotate([0,0,+90]) translate([0,(W-PEG_D)/2,0]) cylinder(d=6, h=BOTTOM_H);
      rotate([0,0,-90]) translate([0,(W-PEG_D)/2,0]) cylinder(d=6, h=BOTTOM_H);
      // Top Case mount
      translate([-W/2+T,L-W/2-6-T,T]) cylinder(d=6, h=BOTTOM_H-T);
      translate([+W/2-T,L-W/2-6-T,T]) cylinder(d=6, h=BOTTOM_H-T);
      // Board mount
      translate([45.72/2,L-W/2-6-T-3-3.81,0]) cylinder(d=7, h=T+2);
      translate([-45.72/2,L-W/2-6-T-3-3.81,0]) cylinder(d=7, h=T+2);
      translate([45.72/2,L-W/2-6-T-3-3.81-45.72,0]) cylinder(d=7, h=T+2);
      translate([-45.72/2,L-W/2-6-T-3-3.81-45.72,0]) cylinder(d=7, h=T+2);
      // USB-C connector
      translate([0,L-W/2-6-T-3,T+2+BT-3.2/2]) difference() 
      {
        rotate([-90,0,0]) hull()
        {
          translate([-4.5,0,0]) cylinder(d=8+T*2, h=6);
          translate([+4.5,0,0]) cylinder(d=8+T*2, h=6);
        }
        translate([-20,-1,-20-(2+BT-3.2/2)]) cube([40,40,20]);
      }
      // Display support
      hull()
      {
        translate([-10,W/2+DBL+EDB-4/2,T]) cylinder(d=4, h=H+BOTTOM_H-6-T);
        translate([-15,W/2+DBL+EDB-4/2,T]) cylinder(d=4, h=H+BOTTOM_H-6-T);
      }
      hull()
      {
        translate([+10,W/2+DBL+EDB-4/2,T]) cylinder(d=4, h=H+BOTTOM_H-6-T);
        translate([+15,W/2+DBL+EDB-4/2,T]) cylinder(d=4, h=H+BOTTOM_H-6-T);
      }
    }
    // Encoder screws
    rotate([0,0,180]) translate([0,(W-PEG_D)/2,0.6]) ScrewHoleUp(20);
    rotate([0,0,+90]) translate([0,(W-PEG_D)/2,0.6]) ScrewHoleUp(20);
    rotate([0,0,-90]) translate([0,(W-PEG_D)/2,0.6]) ScrewHoleUp(20);
    // Top Case mount
    translate([-W/2+T,L-W/2-6-T,LAYER_H*3]) ScrewHoleUp(20);
    translate([+W/2-T,L-W/2-6-T,LAYER_H*3]) ScrewHoleUp(20);
    // Board mount
    translate([45.72/2,L-W/2-6-T-3-3.81,0.6]) cylinder(d=3, h=BOTTOM_H);
    translate([-45.72/2,L-W/2-6-T-3-3.81,0.6]) cylinder(d=3, h=BOTTOM_H);
    translate([45.72/2,L-W/2-6-T-3-3.81-45.72,0.6]) cylinder(d=3, h=BOTTOM_H);
    translate([-45.72/2,L-W/2-6-T-3-3.81-45.72,0.6]) cylinder(d=3, h=BOTTOM_H);
    // USB-C connector hole
    translate([0,L-W/2-6-T-3+2,T+2+BT-3.2/2])
    {
      rotate([-90,0,0]) hull()
      {
        translate([-4.5,0,0]) cylinder(d=8, h=17);
        translate([+4.5,0,0]) cylinder(d=8, h=17);
      }
      translate([-(9+8)/2,0,-20]) cube([9+8,40,20]);
    }
    // USB-C connector
    translate([0,L-W/2-6-T-3-7,T+2+BT-3.2/2]) rotate([-90,0,0]) hull()
    {
      translate([-(5-3.2/2),0,0]) cylinder(d=3.2, h=5+10);
      translate([+(5-3.2/2),0,0]) cylinder(d=3.2, h=5+10);
    }
    // Buttons
    translate([0,L-W/2-6-T-3,-1]) 
    {
      translate([+2.325,-15,0]) cylinder(d=3, h=10);
      translate([-2.325,-15,0]) cylinder(d=3, h=10);
      translate([+2.325,-40.7,0]) cylinder(d=3, h=10);
      // LEDs
      translate([+5,-41.7,0]) cylinder(d=1, h=10);
      translate([-5,-41.7,0]) cylinder(d=1, h=10);
    }
    // Ligntening
    translate([0,0,1.2]) hull()
    {
      cylinder(d=44, h=10);
      translate([-(44-5)/2,64,0]) cylinder(d=5, h=10);
      translate([+(44-5)/2,64,0]) cylinder(d=5, h=10);
    }
  }
}

// *******************************************************************
// ***   Top module   ************************************************
// *******************************************************************
module Top()
{
  if(FOR_PRINT)
  {
    translate([0,L/2-W/2-2,0]) CubeR(W, L-7, LAYER_H, 10);
    difference()
    {
      translate([0,0,6]) cylinder(d=W+R*2-T*2, h=LAYER_H*2);
      translate([-80/2,PEG_D/2,-1]) cube([80,40,H+T*2+1]);
    }
  }
  // Case shell
  difference()
  {
    Case(W+R*2, L, H, R);
    translate([0,0,T])  Case(W+R*2-T*2, L-T*2, H, R-T);
    // Encoder
    translate([0,0,-1]) cylinder(d=W+0.2, h=H);
    // Display
    translate([-55/2,ED+W/2+0.8,-1]) cube([55,88,H]);
    // Board
    translate([-55/2,W/2+EDB,6-BT]) cube([DBW,DBL,BT]);
    translate([-60/2,4.25,6]) cube([60,40,BT]);
    // Cable hole
    translate([-W/3,EDB+DBL,6+3]) rotate([-90,0,0]) cylinder(d=3.5, h=100);
    // SD card
    translate([0,CP,6]) cube([30,15.6,BT]);
    hull()
    {
      translate([0,CP,6+BT/2]) rotate([0,90,0]) cylinder(d=7, h=100);
      translate([0,CP+15.6,6+BT/2]) rotate([0,90,0]) cylinder(d=7, h=100);
    }
    // Buttons
    if(DRAW_BUTTONS)
    {
      // Right button
      #translate([-2.54*9,W/2+EDB-DBH-2.54*2,-2])
      {
        translate([-3,-3,6-4]) cube([6,6,4]);
        translate([0,0,-1]) cylinder(d=3.6, h=5);
      }
      // Left button
      #translate([+2.54*9,W/2+EDB-DBH-2.54*2,-2])
      {
        translate([-3,-3,6-4]) cube([6,6,4]);
        translate([0,0,-1]) cylinder(d=3.6, h=5);
      }
    }
    // Buttons holes
    if(DRAW_BUTTON_HOLES || FOR_PRINT)
    {
      // Right button hole
      ButtonHole(2.4, 3);
      // Left button hole
      mirror([1,0,0]) ButtonHole(2.4, 3);
    }
    // Top Display mount
    translate([-49.5/2,W/2+EDB+DBL-2.8,T/2]) difference()
    {
      cylinder(d=2.5, h=7);
    }
    translate([+49.5/2,W/2+EDB+DBL-2.8,T/2]) difference()
    {
      cylinder(d=2.5, h=7);
    }
    // USB-C connector hole
    translate([0,L-W/2-6-T-3+2,H+BOTTOM_H-(T+2+BT-3.2/2)])
    {
      rotate([-90,0,0]) hull()
      {
        translate([-4.5,0,0]) cylinder(d=8, h=17);
        translate([+4.5,0,0]) cylinder(d=8, h=17);
      }
    }
  /*
    translate([0,W/2+EDB-DBH,0])
    {
      for(j = [-4 : 0])
      {
        for(i = [-9 : 10])
        {
          translate([2.54*i-1.27,2.54*j,-1]) cylinder(d=1, h=T+2);
        }
      }
    }
  */
  }
  // MicroSD slot
  difference()
  {
    D = 8;
    // Houter "pill"
    hull()
    {
      translate([DBW/2+D/2,CP,6+BT/2]) rotate([0,90,0]) sphere(d=D);
      translate([DBW/2+D/2,CP+15.6,6+BT/2]) rotate([0,90,0]) sphere(d=D);
    }
    // Inner "pill" coutout
    hull()
    {
      translate([DBW/2+D/2,CP,6+BT/2]) rotate([0,90,0]) sphere(d=D-2.4);
      translate([DBW/2+D/2,CP+15.6,6+BT/2]) rotate([0,90,0]) sphere(d=D-2.4);
    }
    // Rounded hole cutout
    hull()
    {
      translate([DBW/2+D/2,CP,6+BT/2]) rotate([0,90,0]) cylinder(d=D-2.4, h=100);
      translate([DBW/2+D/2,CP+15.6,6+BT/2]) rotate([0,90,0]) cylinder(d=D-2.4, h=100);
    }
    // Cube
    translate([W/2+R,CP-D/2,3]) cube([D,15.6+D,D]);
    // Card cutout
    translate([0,CP,6]) cube([30,15.6,BT]);
  }
    
  // Encoder
  difference()
  {
    union()
    {
      translate([0,0,T]) cylinder(d=W+R*2-T*2, h=6);
      translate([-(W+R*2-T*2)/2,0,T]) cube([W+R*2-T*2,W/2,6]);
      // Screw pegs
      rotate([0,0,180]) translate([0,(W-PEG_D)/2,6]) cylinder(d=PEG_D, h=H-6);
      rotate([0,0,+90]) translate([0,(W-PEG_D)/2,6]) cylinder(d=PEG_D, h=H-6);
      rotate([0,0,-90]) translate([0,(W-PEG_D)/2,6]) cylinder(d=PEG_D, h=H-6);
    }
    translate([0,0,0]) cylinder(d=W+0.2, h=6);
    translate([0,0,0]) cylinder(d=43, h=H);
    rotate([0,0,120]) translate([0,50.5/2,0]) cylinder(d=3.2, h=H);
    rotate([0,0,-120]) translate([0,50.5/2,0]) cylinder(d=3.2, h=H);
    // Board holder near encoder
    difference()
    {
      translate([0,0,0]) cylinder(d=W+0.2, h=H);
      translate([-80/2,PEG_D/2-40,-1]) cube([80,40,H+T*2+1]);
    }
    translate([-80/2,PEG_D/2+15,-1]) cube([80,40,H+T*2+1]);
    translate([-80/2,PEG_D/2,6]) cube([80,40,H]);
    // Screw holes
    rotate([0,0,180]) translate([0,(W-PEG_D)/2,T+6]) cylinder(d=3, h=H);
    rotate([0,0,+90]) translate([0,(W-PEG_D)/2,T+6]) cylinder(d=3, h=H);
    rotate([0,0,-90]) translate([0,(W-PEG_D)/2,T+6]) cylinder(d=3, h=H);
  }
  // Central support
  hull()
  {
    translate([-7,(W+4)/2,0]) cylinder(d=4, h=6);
    translate([+7,(W+4)/2,0]) cylinder(d=4, h=6);
  }
  // Top Display mount
  translate([-49.5/2,W/2+EDB+DBL-2.8,T]) difference()
  {
    cylinder(d=5, h=6-T-BT);
    translate([0,0,-0.1]) cylinder(d=2.5, h=7);
  }
  translate([+49.5/2,W/2+EDB+DBL-2.8,T]) difference()
  {
    cylinder(d=5, h=6-T-BT);
    translate([0,0,-0.1]) cylinder(d=2.5, h=7);
  }
  // Top Case mount
  translate([-W/2+T,L-W/2-6-T,H-7]) difference()
  {
    union()
    {
      cylinder(d=6, h=7);
      translate([-3,-3,0]) cube([3,6,7]);
      translate([-3,0,0]) cube([6,3,7]);
    }
    translate([0,0,LAYER_H]) cylinder(d=3, h=100);
  }
  translate([+W/2-T,L-W/2-6-T,H-7]) difference()
  {
    union()
    {
      cylinder(d=6, h=7);
      translate([0,-3,0]) cube([3,6,7]);
      translate([-3,0,0]) cube([6,3,7]);
    }
    translate([0,0,LAYER_H]) cylinder(d=3, h=100);
  }
  // Cable hole
  difference()
  {
    translate([-W/3,L-W/2-5/2-1,6+3]) sphere(d=7);
    translate([-W/3,EDB+DBL,6+3]) rotate([-90,0,0]) cylinder(d=3.5, h=100);
  }
}

// *******************************************************************
// ***   Rotate functions   ******************************************
// *******************************************************************
function RotateX(X, Y, A) = X*cos(A) + Y*sin(A);
function RotateY(X, Y, A) = X*sin(A) + Y*cos(A);

// *******************************************************************
// ***   Case module   ***********************************************
// *******************************************************************
module ButtonHole(DFG, D)
// Left button hole
difference()
{
  H = 4;
  X1 = RotateX(0,W/2+H,42);
  Y1 = RotateY(0,W/2+H,42);
  X2 = RotateX(0,W/2+H,30);
  Y2 = RotateY(0,W/2+H,30);
  hull()
  {
    translate([X1,Y1,-0.1]) cylinder(d=D, h=T+0.2);
    translate([X2,Y2,-0.1]) cylinder(d=D, h=T+0.2);
    translate([(DBW-3)/2,Y1,-0.1]) cylinder(d=D, h=T+0.2);
    translate([(DBW-3)/2,W/2+ED-DFG-D/2,-0.1]) cylinder(d=D, h=T+0.2);
    translate([X2,W/2+ED-DFG-D/2,-0.1]) cylinder(d=D, h=T+0.2);
  }
  translate([0,0,-0.2]) cylinder(d=W+H*2-R, h=T+0.4);
}
  
// *******************************************************************
// ***   Case module   ***********************************************
// *******************************************************************
module Case(W, L, H, R)
difference()
{
  translate([0,0,R]) minkowski()
  {
    hull()
    {
      translate([-W/2+R,L-W/2-R-10,0]) cube([W-R*2,10,H-R]);
      cylinder(d=W-R*2, h=H-R);
    }
    sphere(r=R);
  }
  translate([-W/2,-W/2,H]) cube([W,L,H]);
}

// *******************************************************************
// ***   Case module   ***********************************************
// *******************************************************************
module CubeR(W, L, H, R)
{
  hull()
  {
    translate([W/2,L/2,0]) cylinder(d=R, h=H);
    translate([-W/2,L/2,0]) cylinder(d=R, h=H);
    translate([W/2,-L/2,0]) cylinder(d=R, h=H);
    translate([-W/2,-L/2,0]) cylinder(d=R, h=H);
  }
}

module ScrewHole(h)
{
 translate([0,0,-1]) cylinder(d=3, h = h+2);
 translate([0,0,h-2.4]) cylinder(d2=6, d1=3, h = 2);
 translate([0,0,h-0.401]) cylinder(d=6, h = h);
}

module ScrewHoleUp(h)
{
 translate([0,0,2-0.001]) cylinder(d=3, h = h+2);
 translate([0,0,0]) cylinder(d2=3, d1=6, h = 2);
 translate([0,0,-h+0.001]) cylinder(d=6, h = h);
}