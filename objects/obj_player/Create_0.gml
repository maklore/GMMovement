show_debug_overlay(true)

GMMSet.walk_speed(2, 0.16, 0.05).fall_speed(10, 0.05).jump_speed(10, 0.05).run_speed(5, 0.2, 0.1).dash_speed(15);
GMM(id, [obj_floor, obj_wall]);


show_debug_message(json_stringify(GMMGet(), true))