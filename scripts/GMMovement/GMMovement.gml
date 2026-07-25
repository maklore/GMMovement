
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
	
	/**
	*
	* @param {real} _horizontal		Get reals from input check (Right - Left).
	* @param {real} _vertical		Get reals from input check (Down - Up).
	* @param {bool} _run  Optional. Trigger with input check.
	* @param {bool} _dash Optional. Trigger with input check.
	*/		
	static four_way = function(_horizontal, _vertical, _run = false, _dash = false) {
		
		static _get = __GMMConfig();
		
		var _input = _horizontal != 0 or _vertical != 0;
				
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
		
		_get.walk_speed_x = _vertical   == 0 ? _get.walk_speed * _horizontal : 0;
		_get.walk_speed_y = _horizontal == 0 ? _get.walk_speed * _vertical   : 0;
		
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
	
	/**
	* Press any movement input to exit auto movement after releasing
	* @param {real} _horizontal		Get reals from input check (Right - Left).
	* @param {real} _vertical		Get reals from input check (Down - Up).
	* @param {bool} _record			Optional. Hold input check to record movement input.
	*/		
	static grid = function(_horizontal, _vertical, _record = false) {
		
		static _get = __GMMConfig();
						
		if _record and !_get.grid_path_trigger and (_horizontal != 0 or _vertical != 0) {
			array_push(_get.grid_path_record, point_direction(0, 0, _horizontal, _vertical) div 90);
			_get.grid_path_length++;
			_get.grid_path_trigger = true;
		} else if _record and _get.grid_path_trigger and _horizontal == 0 and _vertical == 0 {
			_get.grid_path_trigger = false;
		}
		
		if _record { 
			exit; 
		} else if _get.grid_path_length > 0 and !_get.grid_path_running {
			_get.grid_path_running = true;
		}
		
		if _get.grid_path_running and _horizontal != 0 or _vertical != 0 {	
			array_resize(_get.grid_path_record, 0);
			_get.grid_path_length = 0;
			_get.grid_path_active = false;
			_get.grid_path_running = false;
		}
		
		if _get.grid_path_length != 0 and !_record and !_get.grid_path_active {
			
			switch(_get.grid_path_record[0]) {
				case 0:
					_horizontal = 1;
					_get.grid_path_active = true;
				break;
				case 1:
					_vertical = -1;
					_get.grid_path_active = true;
				break;
				case 2:
					_horizontal = -1;
					_get.grid_path_active = true;
				break;
				case 3:
					_vertical = 1;
					_get.grid_path_active = true;
				break;
			}
		}
				
		with (_get.player) {

			_get.collision_horiz  = instance_place(x + (_get.grid_distance * 0.5) * _horizontal, y, _get.collision);
			_get.collision_vert   = instance_place(x, y + (_get.grid_distance * 0.5) * _vertical, _get.collision);
		}
		
		if _get.grid_path_active and (_get.collision_horiz != noone or _get.collision_vert != noone) {
			array_resize(_get.grid_path_record, 0);
			_get.grid_path_length = 0;
			_get.grid_path_active = false;
			_get.grid_path_running = false;
		}
		
		if _get.collision_horiz == noone and _horizontal != 0 and !_get.grid_walking_x and !_get.grid_walking_y {
			_get.grid_previous_x = _get.player.x;
			_get.grid_target_x = _get.grid_previous_x + _get.grid_distance * _horizontal;
			_get.grid_walking_x = true;
		}
		
		if _get.collision_vert == noone and _vertical != 0  and !_get.grid_walking_x and !_get.grid_walking_y {
			_get.grid_previous_y = _get.player.y;
			_get.grid_target_y = _get.grid_previous_y + _get.grid_distance * _vertical;
			_get.grid_walking_y = true;
		}
		
		if _get.grid_walking_x {
			_get.grid_int_x = _get.grid_int_x < 1 ? _get.grid_int_x + _get.grid_speed : 1;
			_get.grid_x = lerp(_get.grid_previous_x, _get.grid_target_x, _get.grid_int_x);
			_get.player.x = (_get.grid_x);
			if _get.grid_int_x >= 1 {
				_get.grid_previous_x = _get.player.x;
				_get.grid_int_x = 0;
				_get.grid_walking_x = false;
				if _get.grid_path_active {
					array_shift(_get.grid_path_record);
					_get.grid_path_length--;
					_get.grid_path_active = false;
					if _get.grid_path_length == 0 {
						_get.grid_path_running = false;
					}
				}
			}
		}
			
		if _get.grid_walking_y {
			_get.grid_int_y = _get.grid_int_y < 1 ? _get.grid_int_y + _get.grid_speed : 1;
			_get.grid_y = lerp(_get.grid_previous_y, _get.grid_target_y, _get.grid_int_y);
			_get.player.y = (_get.grid_y);
			if _get.grid_int_y >= 1 {
				_get.grid_previous_y = _get.player.y;
				_get.grid_int_y = 0;
				_get.grid_walking_y = false;
				if _get.grid_path_active {
					array_shift(_get.grid_path_record);
					_get.grid_path_length--;
					_get.grid_path_active = false;
					if _get.grid_path_length == 0 {
						_get.grid_path_running = false;
					}
				}
			}
		}
	}
	
	/**
	* 
	* @param {real} _turn			Get reals from input check (Right - Left).
	* @param {real} _move			Get reals from input check (Down - Up).
	* @param {bool} _booster		Optional. Hold input check to increase max speed.
	*/		
	static motion = function(_turn, _move, _booster = false) {
		
		static _get = __GMMConfig();
				
		var _motion_int		  = _move	 ? _get.motion_speed_acc	 : _get.motion_speed_dec;
		var _motion_speed_max = _booster ? _get.motion_speed_boosted : _get.motion_speed_max;
		
		static _image_direction = _get.player.image_angle;
		
		_get.motion_speed = lerp(_get.motion_speed, _motion_speed_max * _move, _motion_int);
		
		_get.motion_direction = _get.motion_speed != 0 ? (_get.motion_direction + _get.motion_speed_rotate * -_turn) mod 360 : _get.motion_direction;
				
		with _get.player {
			
			var _check_x = lengthdir_x(_get.motion_speed, _get.motion_direction);
			var _check_y = lengthdir_y(_get.motion_speed, _get.motion_direction);
			
			var _collision = instance_place(x + _check_x, y + _check_y, _get.collision);
			
			if _collision != noone {
				
				var _distance = distance_to_object(_collision);
				
				_get.motion_speed = _distance * _move;
				
			}
			
		}
		
		_get.player.image_angle = _get.motion_direction;
		
		_get.motion_direction_x = lengthdir_x(_get.motion_speed, _get.motion_direction);
		_get.motion_direction_y = lengthdir_y(_get.motion_speed, _get.motion_direction);	
		
		_get.player.x += _get.motion_direction_x;
		_get.player.y += _get.motion_direction_y;
		
	}
	
	
	return static_get(GMMovement);

}

GMMovement();