/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

// LEGO standard dimensions - (no duplos)
// heights
block_height = 9.6;
plate_height = 9.6 / 3;

// pins and posts 
cylinder_precision = 0.1;
pin_diameter = 3.2;
post_diameter = 6.3;
post_wall_thickness = 0.45;

roof_thickness = 1;

stud_spacing = 8;

wall_play = 0.1;
wall_thickness = 1.45;


//
// cool hash function for structs
// dog = [
//  "fur", "black",
//  "legs", 4
// ];
// hash( dog, "legs")
//
function hash(h,k)= ( h[search([k], [for(i=[0:2:len(h)-2])h[i]])[0]*2+1] ); 
