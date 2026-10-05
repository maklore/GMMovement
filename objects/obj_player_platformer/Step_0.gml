if !is_active { exit; }

var _hor  = GMControls.key_press("right") - GMControls.key_press("left");
var _jump = GMControls.key_press("jump");
var _run  = GMControls.key_press("run");
var _dash = GMControls.key_pressed("dash");

GMM.platformer(_hor, _jump, _run, _dash);

