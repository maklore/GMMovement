is_active = false;

GMMInit(id, [obj_floor, obj_wall]);

GMMSet.walk(6, 0.16, 0.1).run(10, 0.2, 0.1).dash(20, 1);

setmovevar = GMMSet();
setmovevar.walk(6, 0.16, 0.1).run(10, 0.2, 0.1).dash(20, 1);