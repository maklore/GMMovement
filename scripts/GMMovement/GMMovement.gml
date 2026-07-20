
/**
* @returns {struct.GMM}
*/
function GMM(_player_object, _collision_instance) {
		
	__GMMConfig.config.player = _player_object;
	__GMMConfig.config.collision = _collision_instance;
	__GMMConfig.config.gamespeed = game_get_speed(gamespeed_fps);
			
	static platformer = function(_horizontal, _jump, _run = undefined, _dash = undefined) {
		
		static _get = __GMMConfig.config;
		static _dash_cd = 0;
		static _jumped = false;
		static _ground_req = _get.jump_grounded;
		static _grounded = false;
				
		if !_run {
			var _walk_int = _horizontal != 0 ? _get.walk_speed_acc : _get.walk_speed_dec;
			_get.walk_speed = lerp(_get.walk_speed, _get.walk_speed_max * _horizontal, _walk_int);
		} else {
			var _run_int	= _horizontal != 0 ? _get.run_speed_acc : _get.run_speed_dec;
			_get.run_speed	= _get.walk_speed;
			_get.run_speed	= lerp(_get.run_speed, _get.run_speed_max * _horizontal, _run_int);
			_get.walk_speed = _get.run_speed;			
		}
		
		if _dash_cd <= 0 and _dash {
			_get.walk_speed += _get.dash_speed * _horizontal;
			_dash_cd = _get.dash_cooldown;
			show_debug_message(_dash_cd)
		}
		if _dash_cd > 0 {
			_dash_cd -= 1 / _get.gamespeed;
			if _dash_cd <= 0 {
				_dash_cd = 0;	
			}
			//show_debug_message(_dash_cd)
		}
		
		if !_ground_req and _jump {
			_get.fall_speed = -_get.jump_speed;
			_jumped = true;
		} else if _jump and _grounded {
			_get.fall_speed = -_get.jump_speed;
			_jumped = true;
		}
		
		if _jumped and _get.fall_speed <= 0 {
			_jumped = false;
		}
		var _fall_int = !_jumped ? _get.fall_speed_acc : _get.jump_speed_dec;
		
		_get.fall_speed = lerp(_get.fall_speed, _get.fall_speed_max, _fall_int);
		
		with (_get.player) {

			var _side_collision = instance_place(x + _get.walk_speed + _horizontal, y, _get.collision);
			var _vert_collision = instance_place(x, y + _get.fall_speed, _get.collision);
			var _ground_collision = instance_place(x, y + 1, _get.collision);
			
			if _ground_collision != noone {
				_grounded = true;
			} else if _grounded != false {
				_grounded = false;
			}
			
			if _side_collision != noone {
				
				var _distance_side = distance_to_object(_side_collision);
				
				_get.walk_speed = _distance_side * _horizontal;
			}
			if _vert_collision != noone {
				
				var _distance_vert = distance_to_object(_vert_collision);
				
				_get.fall_speed = _distance_vert;
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
		
	static fourway = function(_horizontal, _vertical, _run = undefined, _dash = undefined) {
		
	}
	
	return static_get(GMM);

}