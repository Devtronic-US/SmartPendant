$fn = 300;

SideButton(9.2, 5.6, 6.5); // 1
//SideButton(9, 5.4, 6.5); // 2

//Jig(9.2, 5.6, 6.5, 30);

// *******************************************************************
// ***   SideButton module   *****************************************
// *******************************************************************
module SideButton(L, DB, DL)
{
  // Button
  hull()
  {
    translate([-(L-DB)/2,0,0]) cylinder(d=DB, h=4);
    translate([+(L-DB)/2,0,0]) cylinder(d=DB, h=4);
  }
  // Button base
  hull()
  {
    translate([-(L-DB)/2,0,0]) cylinder(d=DL, h=4-2.8);
    translate([+(L-DB)/2,0,0]) cylinder(d=DL, h=4-2.8);
  }
}

// *******************************************************************
// ***   Jig module   ************************************************
// *******************************************************************
module Jig(L, DB, DL, H)
{
  // Button
  hull()
  {
    translate([-(L-DB)/2,0,0]) cylinder(d=DB, h=H);
    translate([+(L-DB)/2,0,0]) cylinder(d=DB, h=H);
  }
}