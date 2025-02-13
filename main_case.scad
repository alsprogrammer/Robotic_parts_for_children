include <parts.scad>;

// fillet radius
mink_r_ = 1.8;

wall_thikness = mink_r_;

luft = 0.5;

mink_c_h = 1;

mil = 0.001 * 25.4;

// main plate sizes
main_plate_length = 95.5;
main_plate_width = 53.5;
main_plate_whole_height = 10.3;
arduino_stand_height = 3;
arduino_stand_r = 2.5;
arduino_stand_hole_d = 3;

arduino_x_start_position = 10;
arduino_y_start_position = 5;

arduino_bl_hole_x = arduino_x_start_position + 550 * mil;
arduino_bl_hole_y = arduino_y_start_position + 100 * mil;
arduino_tl_hole_x = arduino_x_start_position + 600 * mil;
arduino_tl_hole_y = arduino_y_start_position + 2000 * mil;
arduino_br_hole_x = arduino_x_start_position + 2600 * mil;
arduino_br_hole_y = arduino_y_start_position + 300 * mil;
arduino_tr_hole_x = arduino_x_start_position + 2600 * mil;
arduino_tr_hole_y = arduino_y_start_position + 1400 * mil;

arduino_pins_b_pins_hole_length = (2500 - 1100) * mil + mil * 100;
arduino_pins_b_pins_hole_x = arduino_x_start_position + 1100 * mil - mil * 50;
arduino_pins_b_pins_hole_y = arduino_y_start_position + 100 * mil - mil * 50;
arduino_pins_t_pins_hole_length = (2500 - 740) * mil + mil * 100;
arduino_pins_t_pins_hole_x = arduino_x_start_position + 740 * mil - mil * 50;
arduino_pins_t_pins_hole_y = arduino_x_start_position + 2000 * mil - mil * 50;

// battery holder properties
battery_holder_length = 64;
battery_holder_width = 59.5;
battery_holder_height = 17;

battery_compartment_cover_whole_height =  2 * wall_thikness;
battery_compartment_cover_paw_height = wall_thikness;
battery_compartment_cover_paw_length = 10;
battery_compartment_cover_clicker_length = 10;

//switch 
switch_width = 14;
switch_height = 9;
switch_y_position = 40;
switch_z_position = 3;

// RPi sizes
rpi_length = 68;
rpi_width = 31;
rpi_stand_r = 3.5;
rpi_stand_h = 1;
rpi_stand_x_dist = 58;
rpi_stand_y_dist = 23;
rpi_stand_aligner_r = 1;
rpi_fastener_hole_d = 2.5;
rpi_usb_ext = 1.5;

// cover
cover_thikness = 0.3;

module bottom_part() {
    // surrounding mount beams
    rounded_beam(15);
    translate([0, beam_width * 10, 0])
        rounded_beam(15);
    
    bottom_part_width = max(rpi_length, main_plate_width) + luft;
    bottom_part_width_w_walls = bottom_part_width + 2 * wall_thikness;
    
//    bottom_part_length = main_plate_length + luft;
    bottom_part_length = 15 * beam_width - 2 * wall_thikness;
    bottom_part_length_w_walls = bottom_part_length + 2 * wall_thikness;
    switch_z_position = battery_holder_height + battery_compartment_cover_whole_height - switch_height;

    translate([- beam_width / 2 + wall_thikness, beam_width / 2 + wall_thikness, wall_thikness]) {
        difference() {
            union() {
                // main case
                difference() {
                    minkowski() {
                        cube([bottom_part_length, bottom_part_width, battery_holder_height + battery_compartment_cover_whole_height + luft]);
                
                        difference () {
                            sphere(r=mink_r_, $fn=45);
                            translate ([-mink_r_, -mink_r_, 0])
                                cube([2 * mink_r_, 2 * mink_r_, 2 * mink_r_]);
                        }
                    }
                
                    cube([bottom_part_length, bottom_part_width, battery_holder_height + battery_compartment_cover_whole_height + luft]);
                }
                
                // battery compartment
                translate([rpi_width + rpi_usb_ext + luft, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2, 0])
                    cube([battery_holder_length + 2 * wall_thikness, battery_holder_width + 2 * wall_thikness, battery_holder_height + battery_compartment_cover_whole_height + luft]);
                
                // RPi stands
                translate([rpi_stand_r + rpi_usb_ext + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_r, h = rpi_stand_h);
                translate([rpi_stand_r + rpi_usb_ext + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + rpi_stand_x_dist + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_r, h = rpi_stand_h);
                translate([rpi_stand_r + rpi_usb_ext + rpi_stand_y_dist + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_r, h = rpi_stand_h);
                translate([rpi_stand_r + rpi_usb_ext + rpi_stand_y_dist + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + rpi_stand_x_dist + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_r, h = rpi_stand_h);

                translate([rpi_stand_r + rpi_usb_ext + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_aligner_r, h = rpi_stand_h * 2);
                translate([rpi_stand_r + rpi_usb_ext + rpi_stand_y_dist + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_aligner_r, h = rpi_stand_h * 2);
                translate([rpi_stand_r + rpi_usb_ext + rpi_stand_y_dist + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + rpi_stand_x_dist + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_aligner_r, h = rpi_stand_h * 2);
                
                // fastener tube
                translate([bottom_part_length - rpi_stand_r, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(r = rpi_stand_r, h = battery_holder_height + battery_compartment_cover_whole_height + luft);
            }
            
            // switch hole
            translate([bottom_part_length, switch_y_position, switch_z_position])
                cube([wall_thikness, switch_width, switch_height + luft]);

            // battery compartment hole
                translate([rpi_width + rpi_usb_ext + luft + wall_thikness, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness, - wall_thikness])
                    cube([battery_holder_length, battery_holder_width, battery_holder_height + battery_compartment_cover_whole_height + luft + wall_thikness]);
            
            // wires hole
                translate([battery_holder_length + rpi_usb_ext + rpi_width + luft + wall_thikness, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness, battery_holder_height + battery_compartment_cover_whole_height + luft - wall_thikness])
                    cube([wall_thikness, wall_thikness, wall_thikness]);
            
            // fastener holes
                translate([rpi_stand_r + rpi_usb_ext + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + rpi_stand_x_dist + wall_thikness / 2, 0])
                    cylinder(d = rpi_fastener_hole_d, h = rpi_stand_h);
                translate([bottom_part_length - rpi_stand_r, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
                    cylinder(d = rpi_fastener_hole_d, h = battery_holder_height + battery_compartment_cover_whole_height + luft);
            
            // battery compartment cover holes
                translate([rpi_width + rpi_usb_ext + luft, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness, wall_thikness])
                cube([wall_thikness, battery_compartment_cover_paw_length + luft, wall_thikness  + luft]);
                translate([rpi_width + rpi_usb_ext + luft, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness + (battery_holder_width - (battery_compartment_cover_paw_length + luft)), wall_thikness])
                cube([wall_thikness, battery_compartment_cover_paw_length + luft, wall_thikness  + luft]);
                translate([rpi_width + rpi_usb_ext + luft + battery_holder_length + wall_thikness, (bottom_part_width - (battery_compartment_cover_paw_length + luft)) / 2, wall_thikness])
                cube([wall_thikness, battery_compartment_cover_paw_length + luft, wall_thikness  + luft]);
        }
    }
}

module middle_part() {
    bottom_part_width = max(rpi_length, main_plate_width) + luft;
    bottom_part_width_w_walls = bottom_part_width + 2 * wall_thikness;
    
    bottom_part_length = 15 * beam_width - 2 * wall_thikness;
    bottom_part_length_w_walls = bottom_part_length + 2 * wall_thikness;
    
    middle_part_height = wall_thikness + arduino_stand_height + main_plate_whole_height - wall_thikness - cover_thikness;

    difference() {
        union() {
            // main case
            difference() {
                minkowski() {
                    cube([bottom_part_length, bottom_part_width, middle_part_height]);
                    cylinder(r = mink_r_, h = mink_c_h);
                }
                
                translate([0, 0, wall_thikness])
                    cube([bottom_part_length, bottom_part_width, middle_part_height]);
            }
            
            // arduino stands
            translate([arduino_bl_hole_x, arduino_bl_hole_y, wall_thikness])
                cylinder(r = arduino_stand_r, h = arduino_stand_height);
            translate([arduino_tl_hole_x, arduino_tl_hole_y, wall_thikness])
                cylinder(r = arduino_stand_r, h = arduino_stand_height);
            translate([arduino_br_hole_x, arduino_br_hole_y, wall_thikness])
                cylinder(r = arduino_stand_r, h = arduino_stand_height);
            translate([arduino_tr_hole_x, arduino_tr_hole_y, wall_thikness])
                cylinder(r = arduino_stand_r, h = arduino_stand_height);
        }
        
        // fastener holes
        translate([rpi_stand_r + rpi_usb_ext + luft / 2, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + rpi_stand_x_dist + wall_thikness / 2, 0])
            cylinder(d = rpi_fastener_hole_d + 2 * luft, h = wall_thikness);
        translate([bottom_part_length - rpi_stand_r, (bottom_part_width - rpi_length) / 2 + luft / 2 + rpi_stand_r + wall_thikness / 2, 0])
            cylinder(d = rpi_fastener_hole_d + 2 * luft, h = wall_thikness);
            
        // arduino stands
        translate([arduino_bl_hole_x, arduino_bl_hole_y, wall_thikness])
            cylinder(d = arduino_stand_hole_d, h = arduino_stand_height);
        translate([arduino_tl_hole_x, arduino_tl_hole_y, wall_thikness])
            cylinder(d = arduino_stand_hole_d, h = arduino_stand_height);
        translate([arduino_br_hole_x, arduino_br_hole_y, wall_thikness])
            cylinder(d = arduino_stand_hole_d, h = arduino_stand_height);
        translate([arduino_tr_hole_x, arduino_tr_hole_y, wall_thikness])
            cylinder(d = arduino_stand_hole_d, h = arduino_stand_height);
        
        // power wires hole
        translate([0, 0, 0])
            cube([10, 10, wall_thikness]);
        
        // signal wires hole
        translate([bottom_part_length - (rpi_width + rpi_usb_ext), 5, 0])
            cube([6, 20, wall_thikness]);
    }
}

module cover_part() {
    bottom_part_width = max(rpi_length, main_plate_width) + luft;
    bottom_part_width_w_walls = bottom_part_width + 2 * wall_thikness;
    
    bottom_part_length = 15 * beam_width - 2 * wall_thikness;
    bottom_part_length_w_walls = bottom_part_length + 2 * wall_thikness;
    
    middle_part_height = wall_thikness + arduino_stand_height + main_plate_whole_height - wall_thikness - cover_thikness;

    difference() {
        union() {
            // main case
            minkowski() {
                cube([bottom_part_length, bottom_part_width, cover_thikness]);
                difference () {
                    sphere(r=mink_r_, $fn=45);
                    translate ([-mink_r_, -mink_r_, 0])
                        cube([2 * mink_r_, 2 * mink_r_, 2 * mink_r_]);
                }            
            }
        }
        
        // pin holes
        translate([arduino_pins_b_pins_hole_x - luft / 2, bottom_part_width - arduino_pins_b_pins_hole_y - luft / 2, - wall_thikness])
            cube([arduino_pins_b_pins_hole_length + luft, mil * 100 + luft, wall_thikness + cover_thikness]);
        translate([arduino_pins_t_pins_hole_x - luft / 2, bottom_part_width - arduino_pins_t_pins_hole_y - luft / 2, - wall_thikness])
            cube([arduino_pins_t_pins_hole_length + luft, mil * 100 + luft, wall_thikness + cover_thikness]);
    }
}
                
bottom_part();

//middle_part();

//cover_part();