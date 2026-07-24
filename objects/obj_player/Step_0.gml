
var _hor  = GMControls.key_press("right") - GMControls.key_press("left");
var _ver  = GMControls.key_press("down") - GMControls.key_press("up");
var _jump = GMControls.key_press("jump");
var _run  = GMControls.key_press("run");
var _dash = GMControls.key_pressed("dash");

//var _time = get_timer();

//GMMovement.platformer(_hor, _jump, _run, _dash);
//GMMovement.eight_way(_hor, _ver, _run, _dash);
//GMMovement.four_way(_hor, _ver, _run, _dash);
//GMMovement.grid(_hor, _ver, _run);
GMMovement.motion(_hor, _ver, _run);


//show_debug_message($"{string_format((get_timer() - _time) / 1000, 1, 2)}ms")
