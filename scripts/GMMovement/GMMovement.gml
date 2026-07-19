
/**
* @returns {struct.GMM}
*/
function GMM(_player_object, _collision_instance) {
		
	__GMMConfig.config.player = _player_object;
	__GMMConfig.config.collision = _collision_instance;
			
	static platformer = function(_horizontal, _jump, _run = undefined, _dash = undefined) {
		
		static _get = __GMMConfig.config;
				
		if !_run {
			var _walk_int = _horizontal != 0 ? _get.walk_speed_acc : _get.walk_speed_dec;
			_get.walk_speed = lerp(_get.walk_speed, _get.walk_speed_max * _horizontal, _walk_int);
		} else {
			var _run_int	= _horizontal != 0 ? _get.run_speed_acc : _get.run_speed_dec;
			_get.run_speed	= _get.walk_speed;
			_get.run_speed	= lerp(_get.run_speed, _get.run_speed_max * _horizontal, _run_int);
			_get.walk_speed = _get.run_speed;			
		}
		
		if _dash {
			_get.walk_speed += _get.dash_speed_max * _horizontal;
		}
		
		if _jump {
			_get.fall_speed = -_get.jump_speed_max;
		}
		
		_get.fall_speed = lerp(_get.fall_speed, _get.fall_speed_max, _get.fall_speed_acc);
		
		with (_get.player) {

			var _side_collision = instance_place(x + _get.walk_speed + _horizontal, y, _get.collision);
			var _vert_collision = instance_place(x, y + _get.fall_speed + _get.jump_speed, _get.collision);
			
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