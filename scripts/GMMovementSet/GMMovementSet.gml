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
		
		__GMMConfig.config.walk_speed_max = _max;
		__GMMConfig.config.walk_speed_acc = _acceleration;
		__GMMConfig.config.walk_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Run config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static run = function(_max, _acceleration, _deceleration) {
		__GMMConfig.config.run_speed_max = _max;
		__GMMConfig.config.run_speed_acc = _acceleration;
		__GMMConfig.config.run_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Dash config - Adds set amount to the current speed.
	* @param {real} _amount		 Speed.
	* @param {real} _cooldown	 Cooldown in seconds.
	*/
	static dash = function(_amount, _cooldown = GMM_dash_cooldown) {
		__GMMConfig.config.dash_speed	 = _amount;
		__GMMConfig.config.dash_cooldown = _cooldown;
		return GMMSet();
	}
		
	/**
	* Jump config.
	* @param {real} _max		  Max speed.
	* @param {real} _deceleration Deceleration speed. 0-1.
	* @param {bool} _grounded	  Must be grounded to jump.
	*/
	static jump = function(_max, _deceleration, _grounded = GMM_jump_grounded) {
		__GMMConfig.config.jump_speed	  = _max;
		__GMMConfig.config.jump_speed_dec = _deceleration;
		__GMMConfig.config.jump_grounded  = _grounded;
		return GMMSet();
	}
		
	/**
	* Fall config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed. 0-1.
	*/
	static fall = function(_max, _acceleration) {
		__GMMConfig.config.fall_speed_max = _max;
		__GMMConfig.config.fall_speed_acc = _acceleration;
		return GMMSet();
	}

	return static_get(GMMSet)
	
}

GMMSet();