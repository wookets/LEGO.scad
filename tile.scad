/**
 * Derived from http://www.thingiverse.com/thing:5699
 *
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

tile(2, 4);

// LEGO standard dimensions - (no duplos)
block_height = 9.6;
cylinder_precision = 0.1;
post_diameter = 6.3;
post_wall_thickness = 0.45;
roof_thickness = 1;
stud_spacing = 8;
wall_play = 0.1;
wall_thickness = 1.45;


module tile(width, length) {
  // tiles are locked to 1/3 height
  height = 1/3;
    
  // calculate real dimensions based on stud count
  real_height = max(1/3, height);
  real_length = max(width, length);
  real_width = min(width, length);
  
  overall_length = (real_length * stud_spacing) - (2 * wall_play);
  overall_width = (real_width * stud_spacing) - (2 * wall_play);
  
  // LEGO standard dimensions, but adjusted for brick params
  total_posts_length = (post_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - post_diameter));
  total_posts_width = (post_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - post_diameter));
  
  //translate([0, 0, block_height_ratio * block_height]) 
  //rotate([0, 180, 0]) // flip tiles upside down
  union() {
    // basic rectangle brick
    difference() {
      // brick mass
      cube([overall_length, overall_width, real_height * block_height]);
      // curve out
      translate([wall_thickness, wall_thickness, -roof_thickness]) 
        cube([overall_length - wall_thickness * 2, overall_width - wall_thickness * 2, block_height * real_height]);
    }
    // underneath reinforcements and posts
    if (real_width > 1 && real_length > 1) {
      translate([post_diameter / 2, post_diameter / 2, 0]) {
        translate([(overall_length - total_posts_length)/2, (overall_width - total_posts_width)/2, 0]) {
          union() {
            // Posts
            for (ycount = [1 : real_width - 1]) {
              for (xcount = [1 : real_length - 1]) {
                translate([(xcount - 1) * stud_spacing, (ycount - 1) * stud_spacing, 0]) 
                  post(real_height);
              }
            }
          }
        }
      }
    }
  }
}

module post(real_height) {
  difference() {
    cylinder(r = post_diameter / 2, 
             h = real_height * block_height, 
             $fs = cylinder_precision);
    translate([0, 0, -0.5]) 
      cylinder(r = (post_diameter/2) - post_wall_thickness, 
               h = real_height * block_height + 1,
               $fs = cylinder_precision);
  }
}
