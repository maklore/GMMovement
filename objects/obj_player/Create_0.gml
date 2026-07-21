surface_resize(application_surface, 1920, 1080);
display_set_gui_size(1920, 1080);

camera = new GMCamera(1920, 1080);
camera.size(960, 540);
camera.target(id, 1, 0.06);
camera.enable(true);

GMMInit(id, [obj_floor, obj_wall]);
//var _time = get_timer();
GMMSet.walk(2, 0.16, 0.1).fall(10, 0.05).jump(10, 0.05, true, 1).run(5, 0.2, 0.1).dash(15, 1);
//show_debug_message($"{(get_timer() - _time) / 1000}ms")

__GMMDebug(true);