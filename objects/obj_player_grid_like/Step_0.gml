if !is_active { exit; }

var _hor  = GMControls.key_press("right") - GMControls.key_press("left");
var _ver  = GMControls.key_press("down") - GMControls.key_press("up");
var _rec  = GMControls.key_press("run");

GMM.grid(_hor, _ver, _rec);

