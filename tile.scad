/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

include <common.scad>
include <block.scad>

tile(2, 2);

// there is a small groove on the bottom of tiles that helps pry them up
groove_depth = 0.50;
groove_height = 0.50;


module tile(width, length) {
  // tiles are locked to 1/3 height
  height = 1/3;
  
  // calculate real dimensions based on stud count
  real_height = max(1/3, height);
  real_length = max(width, length);
  real_width = min(width, length);
  overall_length = (real_length * stud_spacing) - (2 * wall_play);
  overall_width = (real_width * stud_spacing) - (2 * wall_play);
  
  // flip tile upside down
  translate([overall_length, 0, block_height * height]) // put tile at 0 0 once flipped
  rotate([0, 180, 0]) // flip tiles upside down
  difference() {
    // basic rectangle brick
    block(width, length, height);
    
    // remove groove around bottom of brick, so easier to remove (newer style tile)
    cube([groove_depth, overall_width, groove_height]);
    cube([overall_length, groove_depth, groove_height]);
    translate([overall_length - groove_depth, 0, 0])
    cube([groove_depth, overall_width, groove_height]);
    translate([0, overall_width - groove_depth, 0])
    cube([overall_length, groove_depth, groove_height]);
  }
}
