$fn=100;

// Possible options(affect back panel only):
// 1.5 or less    - For versions with blackpill on the board
// 1.6 or greater - For version without blackpill
VERSION = 1.6;

// Generation code
if(VERSION < 1.6)
{
  cylinder(d=3, h=6.4);
  cylinder(d=3.8, h=0.8);
}
else
{
  cylinder(d=3, h=11.8);
  cylinder(d=3.8, h=0.8);
}
