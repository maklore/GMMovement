
/**
* @returns {struct.GMM}
*/
function GMMovement() {

	/**
	*
	* @param {real} _horizontal Get reals from input check (Right - Left).
	* @param {bool} _jump Optional. Trigger with input check.
	* @param {bool} _run  Optional. Trigger with input check.
	* @param {bool} _dash Optional. Trigger with input check.
	*/		
	static platformer = function(_horizontal, _jump = false, _run = false, _dash = false) {
		
		static _get = __GMMConfig();
				
		if !_run {
			var _walk_int = _horizontal != 0 ? _get.walk_speed_acc : _get.walk_speed_dec;
			_get.walk_speed = lerp(_get.walk_speed, _get.walk_speed_max * _horizontal, _walk_int);
		} else {
			var _run_int	= _horizontal != 0 ? _get.run_speed_acc : _get.run_speed_dec;
			_get.run_speed	= _get.walk_speed;
			_get.run_speed	= lerp(_get.run_speed, _get.run_speed_max * _horizontal, _run_int);
			_get.walk_speed = _get.run_speed;			
		}
		
		if _get.dash_countdown <= 0 and _horizontal != 0 and _dash {
			_get.walk_speed += _get.dash_speed * _horizontal;
			_get.dash_countdown = _get.dash_cooldown;
		}
		
		if _get.dash_countdown > 0 {
			_get.dash_countdown -= 1 / _get.gamespeed;
			if _get.dash_countdown <= 0 {
				_get.dash_countdown = 0;	
			}
		}
		
		if _jump and !_get.jump_ground_req {
			_get.fall_speed = -_get.jump_speed;
			_get.jump_triggered = true;
		} else if _jump and _get.jump_triggered == false and (_get.jump_grounded or _get.jump_coyote_active or (_get.jump_count < _get.jump_count_max)) {
			_get.fall_speed = -_get.jump_speed;
			_get.jump_triggered = true;
			_get.jump_coyote_active = false;
			_get.jump_count += 1;

		}
		
		if _get.jump_coyote_timer > 0 {
			_get.jump_coyote_timer -= 1 / _get.gamespeed;
			if _get.jump_coyote_timer <= 0 {
				_get.jump_coyote_timer = 0;
				_get.jump_coyote_active = false;
			}
		}
		
		if _get.jump_triggered and _get.fall_speed >= 0 {
			_get.jump_triggered = false;
		}
		
		var _fall_int = !_get.jump_triggered ? _get.fall_speed_acc : _get.jump_speed_dec;
		
		_get.fall_speed = lerp(_get.fall_speed, _get.fall_speed_max, _fall_int);
		
		with (_get.player) {

			_get.collision_horiz	  = instance_place(x + _get.walk_speed + _horizontal, y, _get.collision);
			_get.collision_vert   = instance_place(x, y + _get.fall_speed, _get.collision);
			_get.collision_ground = instance_place(x, y + sign(_get.fall_speed) + 1, _get.collision);
			
			if _get.collision_ground != noone {
				_get.jump_grounded = true;
				_get.jump_coyote_timer = 0;
				_get.jump_count = 0;
			} else if _get.jump_grounded != false {
				_get.jump_grounded = false;
				if _get.fall_speed >= 0 {
					_get.jump_coyote_timer = _get.jump_coyote_time;
					_get.jump_coyote_active = true;
				}
			}
			
			if _get.collision_horiz != noone {
				
				var _distance_side = distance_to_object(_get.collision_horiz);
				
				_get.walk_speed = _distance_side * _horizontal;
			}
			if _get.collision_vert  != noone {
				
				var _distance_vert = distance_to_object(_get.collision_vert);
				
				_get.fall_speed = _distance_vert * sign(_get.fall_speed);
			}
		}
		
		//Actual change in movement.
		if _get.walk_speed != 0 {
			_get.player.x += _get.walk_speed;
		}
		if _get.fall_speed != 0 {
			_get.player.y += _get.fall_speed;
		}
	}
	
	
	/**
	*
	* @param {real} _horizontal		Get reals from input check (Right - Left).
	* @param {real} _vertical		Get reals from input check (Down - Up).
	* @param {bool} _run  Optional. Trigger with input check.
	* @param {bool} _dash Optional. Trigger with input check.
	*/		
	static eight_way = function(_horizontal, _vertical, _run = false, _dash = false) {
		
		static _get = __GMMConfig();
		
		var _input = _horizontal != 0 or _vertical != 0;
		
		if _input {
			_get.direction_last = point_direction(0, 0, _horizontal, _vertical);
		}
		
		if !_run {
			var _walk_int = _input ? _get.walk_speed_acc : _get.walk_speed_dec;
			_get.walk_speed = lerp(_get.walk_speed, _get.walk_speed_max * _input, _walk_int);
		} else {
			var _run_int	= _input ? _get.run_speed_acc : _get.run_speed_dec;
			_get.run_speed	= _get.walk_speed;
			_get.run_speed	= lerp(_get.run_speed, _get.run_speed_max * _input, _run_int);
			_get.walk_speed = _get.run_speed;			
		}
		
		if _get.dash_countdown <= 0 and _input and _dash {
			_get.walk_speed += _get.dash_speed;
			_get.dash_countdown = _get.dash_cooldown;
		}
		
		if _get.dash_countdown > 0 {
			_get.dash_countdown -= 1 / _get.gamespeed;
			if _get.dash_countdown <= 0 {
				_get.dash_countdown = 0;
			}
		}	
		
		_get.walk_speed_x = lengthdir_x(_get.walk_speed, _get.direction_last);
		_get.walk_speed_y = lengthdir_y(_get.walk_speed, _get.direction_last);
		
		with (_get.player) {

			_get.collision_horiz  = instance_place(x + _get.walk_speed_x, y, _get.collision);
			_get.collision_vert   = instance_place(x, y + _get.walk_speed_y, _get.collision);
						
			if _get.collision_horiz != noone {
				
				var _distance_side = distance_to_object(_get.collision_horiz);
								
				_get.walk_speed_x = _distance_side * sign(_get.walk_speed_x);
			}
			if _get.collision_vert  != noone {
				
				var _distance_vert = distance_to_object(_get.collision_vert);
								
				_get.walk_speed_y = _distance_vert * sign(_get.walk_speed_y);
			}
		}
		
		//Actual change in movement.
		if _get.walk_speed_x != 0 {
			_get.player.x += _get.walk_speed_x;
		}
		if _get.walk_speed_y != 0 {
			_get.player.y += _get.walk_speed_y;
		}
	}
	
	
	
	return static_get(GMMovement);

}

GMMovement();