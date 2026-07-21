/**
* Create the camera system.
* @param {real} _game_width Base game width.
* @param {real} _game_height Base game height.
*/
function GMCamera(_game_width, _game_height) constructor {
	
	surface_resize(application_surface, _game_width, _game_height);
	display_set_gui_size(_game_width, _game_height);
	
	__cam = {
		id : camera_create(),
		port : 0,
		x : 0,
		y : 0,
		width : 0,
		height : 0,
		target : noone,
		style : 0,
		speed : 0
	}
	
	view_set_camera(__cam.port, __cam.id);
	view_enabled = true;
	
	/**
	* Returns the camera ID.
	*/
	static id_get = function() { return __cam.id; }
	
	/**
	* Set view size.
	* @param {real} _width Width of view.
	* @param {real} _height Height of view.
	*/
	static size = function(_width, _height) {
		__cam.width = _width;
		__cam.height = _height;
		camera_set_view_size(__cam.id, _width, _height);
	}
	
	/**
	* Set target for camera to be fixed to or following.
	* @param {id.instance} _instance Target.
	* @param {real} _style 0 = fixed, 1 = follow.
	* @param {real} _speed Follow speed (0-1).
	*/
	static target = function(_instance, _style = 0, _speed = 0.1) {
		if !instance_exists(_instance) { 
			show_debug_message($"Instance {_instance} does not exist."); 
			exit;
		}
		if _style != 0 and _style != 1 { 
			show_debug_message($"Invalid style chosen!")	
			exit; 
		}
		__cam.target = _instance;
		__cam.style = _style;
		__cam.speed = _speed;
	}
	
	/**
	* Enable or disable camera view.
	* @param {bool} _bool The bool.
	*/
	static enable = function(_bool = true) {
		if !instance_exists(__cam.target) { 
			show_debug_message($"Instance {__cam.target} does not exist!");
			exit;
		}
		
		if _bool {
			var _x = __cam.target.x - __cam.width  * 0.5;
			var _y = __cam.target.y - __cam.height * 0.5;
			camera_set_view_pos(__cam.id, _x, _y);
		}
		view_set_visible(__cam.port, _bool);
	}
	
	/**
	* Update the view position at object's End Step.
	*/
	static update = function() {
		if !instance_exists(__cam.target) { 
			show_debug_message($"Instance {__cam.target} does not exist!");
			exit;
		}
						
		switch __cam.style {
			case 0:
				__cam.x = __cam.target.x - __cam.width  * 0.5;
				__cam.y = __cam.target.y - __cam.height * 0.5;
			break;
			case 1:
				var _currentx = camera_get_view_x(__cam.id);
				var _currenty = camera_get_view_y(__cam.id);
				var _targetx = (__cam.target.x - __cam.width  * 0.5);
				var _targety = (__cam.target.y - __cam.height * 0.5);
				__cam.x = lerp(_currentx, _targetx, __cam.speed);
				__cam.y = lerp(_currenty, _targety, __cam.speed);
			break;
		}
		__camera_set_view_pos_subpixel(__cam.id, __cam.x, __cam.y);
	}
	
	static room_change = function() {
		view_set_camera(__cam.port, __cam.id);
		camera_set_view_size(__cam.id, __cam.width, __cam.height);
	}
	
	//Provided by PixelatedPope at:
	//github.com/PixelatedPope/HelpfulGMLScripts
	/// @ignore
	static __camera_set_view_pos_subpixel = function(_cam, _x, _y) {
		var	_sw = surface_get_width(application_surface),
			_vw = camera_get_view_width(_cam),
			_ratio = _vw/_sw;
		_x = round(_x/_ratio)*_ratio;
		_y = round(_y/_ratio)*_ratio;
		camera_set_view_pos(_cam,_x,_y);
	}
}