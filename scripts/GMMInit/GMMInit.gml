/**
* Initialises player object and collision objects.
* @param {Id.Instance | Asset.GMObject} _player_object Player instance or object.
* @param {Id.Instance | Asset.GMObject | Array} _collision_object Collision instance, object, or array.
* @param {real} _gamespeed Set gamespeed in FPS.
*/
function GMMInit(_player_object, _collision_object, _gamespeed = game_get_speed(gamespeed_fps)) {
		
	__GMMConfig.player	 = _player_object;
	__GMMConfig.collision = _collision_object;
	__GMMConfig.gamespeed = _gamespeed;
	
}
