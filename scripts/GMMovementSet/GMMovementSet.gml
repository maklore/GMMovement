/**
* Set the speed for various variables using the . accessor.
* @returns {struct.GMMSet}
*/
function GMMSet() {
		
	/**
	* Walk speed config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static walk_speed = function(_max, _acceleration, _deceleration) {
		
		__GMMConfig.config.walk_speed_max = _max;
		__GMMConfig.config.walk_speed_acc = _acceleration;
		__GMMConfig.config.walk_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Run speed config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static run_speed = function(_max, _acceleration, _deceleration) {
		__GMMConfig.config.run_speed_max = _max;
		__GMMConfig.config.run_speed_acc = _acceleration;
		__GMMConfig.config.run_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Adds set amount to the current speed.
	* @param {real} _amount		 Speed.
	*/
	static dash_speed = function(_amount) {
		__GMMConfig.config.dash_speed_max = _amount;
		return GMMSet();
	}
		
	/**
	* Jump speed config.
	* @param {real} _max		  Max speed.
	* @param {real} _deceleration Deceleration speed.
	*/
	static jump_speed = function(_max, _deceleration) {
		__GMMConfig.config.jump_speed_max = _max;
		//__GMMConfig.config.jump_speed_acc = _acceleration;
		__GMMConfig.config.jump_speed_dec = _deceleration;
		return GMMSet();
	}
		
	/**
	* Fall speed config.
	* @param {real} _max		  Max speed.
	* @param {real} _acceleration Acceleration speed.
	*/
	static fall_speed = function(_max, _acceleration) {
		__GMMConfig.config.fall_speed_max = _max;
		__GMMConfig.config.fall_speed_acc = _acceleration;
		//__GMMConfig.config.fall_speed_dec = _deceleration;
		return GMMSet();
	}

	return static_get(GMMSet)
	
}

GMMSet();