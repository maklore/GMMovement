show_debug_overlay(true)
surface_resize(application_surface, 1920, 1080);
display_set_gui_size(1920, 1080);
window_set_size(1280, 720)
camera = new GMCamera(1920, 1080);
camera.size(1280, 720);
camera.target(id, 1, 0.06);
camera.enable(true);

GMMInit(id, [obj_floor, obj_wall]);
//var _time = get_timer();
//GMMSet.walk(6, 0.16, 0.1).fall(20, 0.05).jump(20, 0.05, true, 1, 2).run(10, 0.2, 0.1).dash(20, 1);
//GMMSet.walk(6, 0.16, 0.1).jump(20, 0.05, true, 1).run(10, 0.2, 0.1).dash(20, 1);
//GMMSet.grid(2, sprite_width);
GMMSet.motion(3, 0.05, 0.06, 3, 6);
//show_debug_message($"{(get_timer() - _time) / 1000}ms")

__GMMDebug(true);
