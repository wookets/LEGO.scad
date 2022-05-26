/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

include <common.scad>
include <posts.scad>

block(2, 3, 1);

module block(width, length, height) {
  // calculate real dimensions based on stud count
  real_height = max(1/3, height);
  real_length = max(width, length);
  real_width = min(width, length);
  overall_length = (real_length * stud_spacing) - (2 * wall_play);
  overall_width = (real_width * stud_spacing) - (2 * wall_play);
  
  union() {
    difference() {
      // brick mass
      cube([overall_length, overall_width, real_height * block_height]);
      // curve out
      translate([wall_thickness, wall_thickness, -roof_thickness]) 
      cube([overall_length - wall_thickness * 2, overall_width - wall_thickness * 2, block_height * real_height]);
    }
    // underneath posts or pins
    posts(real_width, real_length, real_height, overall_width, overall_length);
  }
}

