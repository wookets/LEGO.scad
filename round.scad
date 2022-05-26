/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

include <common.scad>

// diameter: number
// type: plate, tile, brick
round(2, 2, "tile");

module round(width, length, type) {
  height = 1/3;
  groove_depth = 0.35;
  groove_height = 0.35;
  r = 5;
  h = 5;
    
  // calculate real dimensions based on stud count
  real_height = max(1/3, height);
  real_length = max(width, length);
  real_width = min(width, length);
  overall_length = (real_length * stud_spacing) - (2 * wall_play);
  overall_width = (real_width * stud_spacing) - (2 * wall_play);
  
  union() {
    // basic circle brick
    difference() {
      // block(real_height, overall_width, overall_length);
      difference() {
        // main circle part
        cylinder(r = post_diameter / 2, 
                 h = real_height * block_height, 
                 $fs = cylinder_precision);
        // carve out inside so stud can snap into it
        translate([0, 0, -0.5]) 
          cylinder(r = (post_diameter/2) - post_wall_thickness, 
                   h = real_height * block_height + 1,
                   $fs = cylinder_precision);
        
        cylinder(r = (post_diameter/2) - post_wall_thickness + .3, 
                 h = real_height * block_height + 1,
                 $fs = cylinder_precision);
      }
      
      // remove groove around bottom of brick, so easier to remove (newer style tile)
      cube([groove_depth, overall_width, groove_height]);
      cube([overall_length, groove_depth, groove_height]);
      translate([overall_length - groove_depth, 0, 0])
      cube([groove_depth, overall_width, groove_height]);
      translate([0, overall_width - groove_depth, 0])
      cube([overall_length, groove_depth, groove_height]);
    }
    // underneath posts or pins
    // posts(real_width, real_length, real_height, overall_width, overall_length);
  }
}
