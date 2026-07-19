
var _hor  = GMControls.key_press("right") - GMControls.key_press("left");
var _jump = GMControls.key_pressed("jump");
var _run  = GMControls.key_press("run");
var _dash = GMControls.key_pressed("dash");

//var _time = get_timer();
GMM.platformer(_hor, _jump, _run, _dash);
//show_debug_message($"{(get_timer() - _time) / 1000}ms")