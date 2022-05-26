
// Stud common dimensions
// shouldnt need to change unless tweaking for your printer

cylinder_precision = 0.1;

stud_diameter = 4.85;
stud_height = 1.8;
stud_spacing = 8;
    
hollow_stud_inner_diameter = 3.1;
    
    
// If your printer prints the blocks correctly except for the stud diameter, use this variable to resize just the studs for your printer. A value of 1.05 will print the studs 105% wider than standard.
stud_rescale = 1.00;
//stud_rescale = 1.0475 * 1; // Orion Delta, T-Glase
//stud_rescale = 1.022 * 1; // Orion Delta, ABS

// If you want stud tops to be curved, specify a value between 0 and 1, where 0 is no roundness and 1 is very round
stud_top_roundness = 0.4; // [0:0.01:1]

stud_top_height = 1;
stud_body_height = (stud_top_roundness != 0) ? (stud_height - stud_top_height) : stud_height;

// debug studs
//stud();
//translate([5, 5, 0])
//stud("hollow");

module stud(stud_type="solid") {
  difference() {
    union() {
      cylinder(r = (stud_diameter * stud_rescale) / 2,
               h = stud_body_height,
               $fs = cylinder_precision);
      if (stud_top_roundness != 0) {
        translate([0, 0, stud_body_height])
        rounded_stud_top(height = stud_top_height, 
                         radius = (stud_diameter * stud_rescale) / 2,
                         curve_height = stud_top_roundness);
      }
    }
    if (stud_type == "hollow") {
      // 0.5 is for cleaner preview; doesn't affect functionality.
      cylinder(r = (hollow_stud_inner_diameter * stud_rescale) / 2,
               h = stud_height + 0.5,
               $fs = cylinder_precision);
    }
  }
}

module rounded_stud_top(height, radius, curve_height) {
  assert(curve_height < (radius/2), "Curve height must be less than half the radius");
  assert(height >= curve_height, "Curve height must be greater than or equal to height");
  base_height=height-curve_height;
  union() {
    cylinder(h=base_height, r=radius, $fs=cylinder_precision);
    translate([0,0,base_height])
    difference() {
      union() {
        rotate_extrude($fs = cylinder_precision)
        hull() {
          translate([radius - curve_height, 0, 0])
          circle(curve_height, $fs = cylinder_precision);
        };
        cylinder(h = curve_height, r = (radius-curve_height), $fs = cylinder_precision);
      }
      translate([0, 0, -curve_height])
      cylinder(h = curve_height, r = (radius), $fs = cylinder_precision);
    }
  }
}
