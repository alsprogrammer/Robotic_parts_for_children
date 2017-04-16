include <parts.scad>;

// fillet radius
mink_r_ = 1.8;

wall_thikness = mink_r_;

luft = 0.5;

// main plate sizes
main_plate_length = 95.5;
main_plate_width = 53.5;

// battery holder properties
battery_holder_length = 64;
battery_holder_width = 57;
battery_holder_height = 10;

battery_compartment_cover_whole_height = 4;

//switch 
switch_width = 14;
switch_height = 9;
switch_y_position = 40;
switch_z_position = 3;

// RPi sizes
rpi_length = 68;
rpi_width = 31;

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
                translate([rpi_width + luft, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2, 0])
                    cube([battery_holder_length + 2 * wall_thikness, battery_holder_width + 2 * wall_thikness, battery_holder_height + battery_compartment_cover_whole_height + luft]);
            }
            
            // switch hole
            translate([bottom_part_length, switch_y_position, switch_z_position])
                cube([wall_thikness, switch_width, switch_height]);

            // battery compartment hole
                translate([rpi_width + luft + wall_thikness, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness, - wall_thikness])
                    cube([battery_holder_length, battery_holder_width, battery_holder_height + battery_compartment_cover_whole_height + luft + wall_thikness]);
            
            // wires hole
                translate([battery_holder_length + rpi_width + luft + wall_thikness, (bottom_part_width - (battery_holder_width + 2 * wall_thikness)) / 2 + wall_thikness, battery_holder_height + battery_compartment_cover_whole_height + luft - wall_thikness])
                    cube([wall_thikness, wall_thikness, wall_thikness]);
        }
    }
}

bottom_part();
//    bottom_part_length = 14.5 * beam_width - 2 * wall_thikness;
//            translate([beam_width / 2 + wall_thikness + bottom_part_length, 50, 4])
//                cube([wall_thikness, switch_width, switch_height]);
