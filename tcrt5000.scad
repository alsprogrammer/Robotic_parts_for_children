include <parts.scad>;

// fillet radius
mink_r_ = 2;

// sensor dimensions
plate_length = 32.5;
plate_width = 14.5;
plate_height = 1.5;
whole_plate_height = 7.5;
wall_thikness = mink_r_;
sensor_hole_length = 10;
sensor_hole_width = 5.6;
smd_height = 0.5;
connector_pin_width = 3.5;

luft = 0.5;

// connector sizes
dupont_length = 14;

// fastener properties
cap_r = 3;
top_diam = 3;
bottom_diam = 2.1;
fastener_x_position = 10;
fastener_y_position = 28;

//cable properties
cable_width = 6;
cable_hole_deep = 2;

// cover properties
cover_height = 0.3;
cover_inner_height = 4.5;

//potensiometer properties
poten_side = 7;
poten_height = whole_plate_height - plate_height;
poten_legs_height = 1.5;
poten_x_position = 18.7 - poten_side;

// fastener properties
fast_hole_diam = 3.3;
fast_hole_x_pos = 23 + fast_hole_diam / 2;
tide_fast_hole_diam = 2.9;

// stands properties
stand_side = 1.5;

module tcrt5000_bottom_case() {
    difference() {
        //main case
        minkowski() {
            cube([plate_length + dupont_length + luft, plate_width + luft, whole_plate_height]);
                
            difference () {
                sphere(r=mink_r_, $fn=45);
                translate ([-mink_r_, -mink_r_, 0])
                    cube([2 * mink_r_, 2 * mink_r_, 2 * mink_r_]);
            }
        }
        
        // plate hole
        cube([plate_length + luft, plate_width + luft, whole_plate_height]);
        // dupont hole
        translate([plate_length + luft, 0, plate_height])
            cube([dupont_length, plate_width + luft, whole_plate_height - plate_height]);
        // sensor hole
        translate([0, (plate_width - sensor_hole_length) / 2, - wall_thikness])
            cube([sensor_hole_width + luft, sensor_hole_length + luft, wall_thikness]);
        // potensiometer legs hole
        translate([poten_x_position, plate_width - poten_side - luft / 2, - poten_legs_height])
            cube([poten_side + luft, poten_side + luft, poten_legs_height]);
        // cable hole
        translate([plate_length + dupont_length + luft, (plate_width - cable_width - luft) / 2, whole_plate_height - cable_hole_deep])
            cube([wall_thikness + luft, cable_width, cable_hole_deep]);
        // fastener hole
        translate([fast_hole_x_pos + luft / 2, (plate_width - fast_hole_diam) / 2 + fast_hole_diam / 2 + luft / 2, - wall_thikness])
            cylinder(r = fast_hole_diam / 2 + luft / 2, h = wall_thikness);
        // cabel connector hole
        translate([plate_length + luft - connector_pin_width, 0, - poten_legs_height])
            cube([connector_pin_width, plate_width + luft, poten_legs_height]);
    }        
}

module tcrt5000_cover_case() {
    difference() {
        union() {
            // cover plate
            minkowski() {
                cube([plate_length + dupont_length + luft, plate_width + luft, cover_height]);
                
                difference () {
                    sphere(r=mink_r_, $fn=45);
                    translate ([-mink_r_, -mink_r_, 0])
                        cube([2 * mink_r_, 2 * mink_r_, 2 * mink_r_]);
                }
            }
            
            // stands
            translate([luft / 2, luft / 2, cover_height])
                cube([stand_side, stand_side, whole_plate_height - wall_thikness - cover_height - plate_height]);
            translate([luft / 2, plate_width - stand_side + luft / 2, cover_height])
                cube([stand_side, stand_side, whole_plate_height - wall_thikness - cover_height - plate_height]);
            translate([plate_length + dupont_length - stand_side + luft / 2, luft / 2, cover_height])
                cube([stand_side, stand_side, whole_plate_height - wall_thikness - cover_height - plate_height]);
            translate([plate_length + dupont_length - stand_side + luft / 2, plate_width - stand_side + luft / 2, cover_height])
                cube([stand_side, stand_side, whole_plate_height - wall_thikness - cover_height - plate_height]);
            
            // fastener hole
            translate([fast_hole_x_pos + luft / 2, (plate_width - fast_hole_diam) / 2 + fast_hole_diam / 2 + luft / 2, 0])
                cylinder(r = fast_hole_diam, h = whole_plate_height - plate_height - smd_height);
        }
        
        // potensiometer hole
        translate([poten_x_position, 0, - wall_thikness])
            cube([poten_side + luft, poten_side + luft, wall_thikness + cover_height]);
            // fastener hole
        translate([fast_hole_x_pos + luft / 2, (plate_width - fast_hole_diam) / 2 + fast_hole_diam / 2 + luft / 2, 0])
            cylinder(r = tide_fast_hole_diam / 2, h = whole_plate_height);
    }        
}

module tcrt5000_lego_bottom_case() {
    union() {
        translate([0, (3 * beam_width - (plate_width + luft + 2 * wall_thikness)) / 2, 0])
            tcrt5000_bottom_case();
        translate([plate_length + luft + wall_thikness, (3 * beam_width - (plate_width + luft + 2 * wall_thikness)) / 2 - beam_width / 2 -  2 * luft, - wall_thikness])
            cube([dupont_length, 3 * beam_width + 2 * luft, wall_thikness]);
        translate([30, - wall_thikness - beam_width / 2, - wall_thikness])
            rounded_beam(5);
        translate([30, - wall_thikness - beam_width / 2 + 4 * beam_width, - wall_thikness])
            rounded_beam(5);
        translate([30 + beam_width * 4, - wall_thikness - beam_width / 2 + 4 * beam_width, - wall_thikness])
            rotate([0, 0, 270])
                rounded_beam(5);
    }
}
    
//tcrt5000_bottom_case();

translate([0, 20, 0])
    tcrt5000_cover_case();

translate([0, 50, 0])
    tcrt5000_lego_bottom_case();