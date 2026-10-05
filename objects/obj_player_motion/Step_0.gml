if !is_active { exit; }

var _hor  = GMControls.key_press("right") - GMControls.key_press("left");
var _ver  = GMControls.key_press("down") - GMControls.key_press("up");
var _run  = GMControls.key_press("run");
var _dash = GMControls.key_pressed("dash");

GMM.motion(_hor, _ver, _run, _dash);

