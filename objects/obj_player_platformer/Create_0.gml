is_active = false;

GMMInit(id, [obj_floor, obj_wall]);

GMMSet.walk(6, 0.16, 0.1).fall(20, 0.05).jump(20, 0.035, true, 1, 2).run(10, 0.2, 0.1).dash(20, 1);

