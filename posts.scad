/**
 * Derived from http://www.thingiverse.com/thing:5699
 * LEGO, the LEGO logo, the Brick, DUPLO, and MINDSTORMS are trademarks of the LEGO Group. 2012 The LEGO Group.
 */

include <common.scad>

module posts(real_width, real_length, real_height, overall_width, overall_length) {
  if (real_width > 1 && real_length > 1) {
    _posts(real_width, real_length, real_height, overall_width, overall_length);
  } else if (real_width == 1 && real_length > 1) {
    pins(real_width, real_length, real_height, overall_width, overall_length);
  }
}

module _posts(real_width, real_length, real_height, overall_width, overall_length) {
  
  // LEGO standard dimensions, but adjusted for brick params
  total_posts_length = (post_diameter * (real_length - 1)) + ((real_length - 2) * (stud_spacing - post_diameter));
  total_posts_width = (post_diameter * (real_width - 1)) + ((real_width - 2) * (stud_spacing - post_diameter));
  
  translate([post_diameter / 2, post_diameter / 2, 0]) {
    translate([(overall_length - total_posts_length) / 2, (overall_width - total_posts_width) / 2, 0]) {
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

module post(real_height) {
  difference() {
    cylinder(r = post_diameter / 2, 
             h = real_height * block_height, 
             $fs = cylinder_precision);
    // remove the inside
    translate([0, 0, -(post_wall_thickness + 0.05)]) 
    cylinder(r = (post_diameter / 2) - post_wall_thickness, 
             h = real_height * block_height + 1,
             $fs = cylinder_precision);
  }
}

module pins(real_width, real_length, real_height, overall_width, overall_length) {
  
  // LEGO standard dimensions, but adjusted for brick params
  total_pins_width = (pin_diameter * (real_width - 1)) + max(0, ((real_width - 2) * (stud_spacing - pin_diameter)));
  total_pins_length = (pin_diameter * (real_length - 1)) + max(0, ((real_length - 2) * (stud_spacing - pin_diameter)));

  translate([(pin_diameter / 2) + (overall_length - total_pins_length) / 2, overall_width / 2, 0]) {
    for (xcount = [1 : real_length - 1]) {
      translate([(xcount - 1) * stud_spacing, 0, 0]) 
      cylinder(r = pin_diameter / 2,
               h = block_height * real_height,
               $fs = cylinder_precision);
    }
  }
}
