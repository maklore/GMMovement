/**
* Set the speed for various variables using the . accessor.
* @returns {struct.GMMSet}
*/
function GMMSet() {
		
	/**
	* Walk config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static walk = function(_max, _acceleration, _deceleration) {
		
		__GMMConfig.walk_speed_max = _max;
		__GMMConfig.walk_speed_acc = _acceleration;
		__GMMConfig.walk_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Run config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static run = function(_max, _acceleration, _deceleration) {
		__GMMConfig.run_speed_max = _max;
		__GMMConfig.run_speed_acc = _acceleration;
		__GMMConfig.run_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Dash config - Adds set amount to the current speed.
	* @param {real} _amount		 Speed.
	* @param {real} _cooldown	 Cooldown in seconds.
	*/
	static dash = function(_amount, _cooldown = GMM_dash_cooldown) {
		__GMMConfig.dash_speed	 = _amount;
		__GMMConfig.dash_cooldown = _cooldown;
		return GMMSet();
	}
		
	/**
	* Jump config.
	* @param {real} _max		  Max speed.
	* @param {real} _deceleration Deceleration speed. 0-1, percent of max speed.
	* @param {bool} _grounded	  Require ground to jump.
	* @param {real} _coyote_time  Seconds after leaving ground to jump, requires grounded to be enabled.
	* @param {real} _count		  Amount of jumps allowed, requires grounded to be enabled.
	*/
	static jump = function(_max, _deceleration, _grounded = GMM_jump_grounded, _coyote_time = GMM_jump_coyote_time, _count = GMM_jump_count_max) {
		__GMMConfig.jump_speed		  = _max;
		__GMMConfig.jump_speed_dec	  = _deceleration;
		__GMMConfig.jump_ground_req   = _grounded;
		__GMMConfig.jump_coyote_time  = _coyote_time;
		__GMMConfig.jump_count_max	  = _count;
		return GMMSet();
	}
		
	/**
	* Fall config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed. 0-1.
	*/
	static fall = function(_max, _acceleration) {
		__GMMConfig.fall_speed_max = _max;
		__GMMConfig.fall_speed_acc = _acceleration;
		return GMMSet();
	}
	
	/**
	* Grid config.
	* @param {real} _speed			  Speed. Pixels per frame.
	* @param {real} _distance		  Distance to move.
	*/
	static grid = function(_speed, _distance) {
		__GMMConfig.grid_speed		= _speed * (1 / game_get_speed(gamespeed_fps));
		__GMMConfig.grid_distance	= _distance;
		__GMMConfig.grid_previous_x = __GMMConfig.player.x;
		__GMMConfig.grid_previous_y = __GMMConfig.player.y;
		return GMMSet();
	}




	return static_get(GMMSet)
	
}

GMMSet();