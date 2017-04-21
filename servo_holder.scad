include <parts.scad>;

// fillet radius
mink_r_ = 1.8;

luft = 0.5;

bolt_diam = 4;

// servo size
servo_outer_length = 54;
servo_case_length = 40.4;
servo_case_width = 19.9;
servo_x_dist_between_holes = 48.6;
servo_y_dist_between_holes = 9.9;
beams_length = 9;

module servo_holder() {
    difference() {
        union() {
            // surrounding mount beams
            rounded_beam(beams_length);
            translate([0, beam_width * 4, 0])
                rounded_beam(beams_length);
    
            translate([(beams_length * beam_width - (servo_case_length + 2 * beam_width + luft)) / 2 - beam_width / 2, beam_width / 2, 0]) {
                // servo mount
                cube([beam_width, 3 * beam_width, beam_width]);
                translate([servo_case_length + beam_width + luft, 0, 0])
                    cube([beam_width, 3 * beam_width, beam_width]);
            }
        }
        // servo mounting holes
        translate([(beams_length * beam_width - (servo_case_length + 2 * beam_width + luft)) / 2, (beam_width * 4 - servo_y_dist_between_holes) / 2, 0]) {
            cylinder(d = bolt_diam, h = beam_height);
            translate([0, servo_y_dist_between_holes, 0])
                cylinder(d = bolt_diam, h = beam_height);
            translate([servo_x_dist_between_holes, 0, 0])
                cylinder(d = bolt_diam, h = beam_height);
            translate([servo_x_dist_between_holes, servo_y_dist_between_holes, 0])
                cylinder(d = bolt_diam, h = beam_height);
        }
    }
}

servo_holder();
