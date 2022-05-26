
include <common.scad>
use <block.scad>
include <stud.scad>

brick(22, 22, 1/3);

module brick(width, length, height) {
    
  // calculate real dimensions based on stud count
  real_height = max(1/3, height);
  real_length = max(width, length);
  real_width = min(width, length);
  overall_length = (real_length * stud_spacing) - (2 * wall_play);
  overall_width = (real_width * stud_spacing) - (2 * wall_play);
  
  total_studs_width = (stud_diameter * stud_rescale * real_width) + ((real_width - 1) * (stud_spacing - (stud_diameter * stud_rescale)));
  total_studs_length = (stud_diameter * stud_rescale * real_length) + ((real_length - 1) * (stud_spacing - (stud_diameter * stud_rescale)));
  
  union() {
    // basic rectangle brick
    block(width, length, height);
    // add studs on top
    translate([stud_diameter * stud_rescale / 2, stud_diameter * stud_rescale / 2, 0]) 
    translate([(overall_length - total_studs_length)/2, (overall_width - total_studs_width)/2, 0]) {
      for (ycount = [0 : real_width - 1]) {
        for (xcount = [0 : real_length - 1]) {
          translate([xcount * stud_spacing, ycount * stud_spacing, block_height * real_height]) 
          stud();
        }
      }
    }
  }
}
