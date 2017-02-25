include <bitbeam_constants.scad>;

module beam_hole() {
    union () {
	    cylinder(d=hole_diam, h=beam_height, $fn=30);
	    cylinder(d=outer_hole_diam, h=outer_hole_deep, $fn=30);
		translate ([0, 0, beam_height - outer_hole_deep])
	        cylinder(d=outer_hole_diam, h=outer_hole_deep, $fn=30);
	}
}

// Typical beam
module beam(length, width=1, start_x_hole=0, start_y_hole=0) {
    difference() {
        // the rounded cube
        translate([mink_r, mink_r, mink_r]) {
           minkowski() {
                cube([length*beam_element_length - 2*mink_r, width*beam_width - 2*mink_r, beam_height - 2*mink_r]);
                sphere(r=mink_r);
            };
        }
        // the holes
        for(x=[start_x_hole:1:length]) {
            for(y=[start_y_hole:1:width]) {
                union() {
                    translate([beam_element_length/2+x*hole_space, beam_width/2+y*hole_space, 0])
						beam_hole();
                    translate([beam_element_length/2+x*hole_space, beam_width+y*hole_space, beam_height/2]) 
                        rotate(a=[90, 0, 0])
						    beam_hole();
                }
            }
        }
    }
}

module ninty_angled_beam(length, width) {
    union() {
        beam(length);
        translate([beam_element_length, 0, 0])
            rotate(a=[0, 0, 90])
                beam(width);
    }
}

module more_90_angled_beam(length, width, angle=135) {
    union() {
        beam(length, start_x_hole=1);
        translate([-beam_element_length*cos(angle+90), -beam_element_length*sin(angle+90), 0])
            rotate(a=[0, 0, angle])
                beam(width, start_x_hole=1);
        translate([mink_r/2, mink_r, mink_r])
            cylinder(d=2*mink_r, h=beam_width-2*mink_r, $fn=30);
    }
}

module motor_wheel_adapter() {
    difference () {
        union() {
            translate([- beam_element_length, - beam_width / 2, 0])
                cube([2 * beam_element_length, beam_width, beam_height]);
            translate([- beam_element_length, 0, 0])
                cylinder(d=beam_width, h=beam_height, $fn=30);
            translate([beam_element_length, 0, 0])
                cylinder(d=beam_width, h=beam_height, $fn=30);
        }
        union() {
              translate([- hole_space, 0, 0])
                  beam_hole();
              translate([hole_space, 0, 0])
                  beam_hole();
              difference () {
                  cylinder(d = 3, h = beam_height, $fn = 30);
                  translate ([1, -1.5, 0])
                      cube ([1, 3, beam_height]);
              }
        }
    }
}

beam(5);
translate([0, 10, 0])
   beam(5);
translate([0, 20, 0])
   beam(5);
translate([0, 30, 0])
   beam(5);
translate([0, 40, 0])
   beam(7);
translate([0, 50, 0])
   beam(7);
translate([0, 60, 0])
   beam(7);
translate([0, 70, 0])
   beam(7);
//beam(9);
//beam(11);
//beam(13);
//beam(15);