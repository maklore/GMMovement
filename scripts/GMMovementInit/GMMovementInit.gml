function GMMInit(_player_object, _collision_instance, _gamespeed = game_get_speed(gamespeed_fps)) {
		
	__GMMConfig.player	 = _player_object;
	__GMMConfig.collision = _collision_instance;
	__GMMConfig.gamespeed = _gamespeed;
	
}