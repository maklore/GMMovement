
/**
 * @desc This is an input, and keybind system.
 * @returns {struct.GMControls}
 */
function GMControls() {

	static __keybind_list = __GMControlsKeyNames();

	static __key = {
		left			: [ord("A"),	vk_left],
		right			: [ord("D"),	vk_right],
		down			: [ord("S"),	vk_down],
		up				: [ord("W"),	vk_up],
		jump			: [vk_space,	-4],
		run				: [vk_shift,	-4],
		dash			: [vk_control,	-4],
		menu			: [vk_escape,	-4]
	}
	
	static __mouse = {
		left		: [mb_left,		-4],
		right		: [mb_right,	-4]
	}
		
	/**
	 * @desc Save the current state of keybinds to a file.
	 */
	static save_keybinds = function() {
		var _save_name = "keybinds.json";
		var _open_save = file_text_open_write(_save_name);
		var _bindings  = { key : __key, mouse : __mouse }
		var _json_keybinds = json_stringify(_bindings, true);
		file_text_write_string(_open_save, _json_keybinds);
		file_text_close(_open_save);
		return "Keybinds saved!"
	}
	
	/**
	 * @desc Load keybinds from save file if it exists.
	 */
	static load_keybinds = function() {
		var _save_name = "keybinds.json";
		if !file_exists(_save_name) {
			return "No keybinds file found!";
		}
		var _open_save = file_text_open_read(_save_name);
		var _save_string = "";
		while (!file_text_eof(_open_save)) {
			_save_string += file_text_readln(_open_save);	
		}
		var _load_save = json_parse(_save_string);
		__key = variable_clone(_load_save.key);
		__mouse = variable_clone(_load_save.mouse);
		file_text_close(_open_save);
		return "Keybinds loaded!"
	}
	
	/**
	 * @desc Check if set keys of the input variable are held down.
	 * @param {string} _name Name of the input variable.
	 */
	static key_press = function(_name) {
		var _key = __key[$ _name];
		return keyboard_check(_key[0]) or keyboard_check(_key[1]);
	}
	
	/**
	 * @desc Check if set keys of the input variable have been pressed.
	 * @param {string} _name Name of the input variable.
	 */
	static key_pressed = function(_name) {
		var _key = __key[$ _name];
		return keyboard_check_pressed(_key[0]) or keyboard_check_pressed(_key[1]);
	}
	
	/**
	 * @desc Check if set keys of the input variable have been released.
	 * @param {string} _name Name of the input variable.
	 */
	static key_released = function(_name) {
		var _key = __key[$ _name];
		return keyboard_check_released(_key[0]) or keyboard_check_released(_key[1]);
	}
	
	/**
	 * @desc Check if set mouse buttons of the input variable are held down.
	 * @param {string} _name Name of the input variable.
	 */
	static mouse_press = function(_name) {
		var _mouse = __mouse[$ _name];
		return mouse_check_button(_mouse[0]) or mouse_check_button(_mouse[1]);
	}
	
	/**
	 * @desc Check if set mouse buttons of the input variable have been pressed.
	 * @param {string} _name Name of the input variable.
	 */
	static mouse_pressed = function(_name) {
		var _mouse = __mouse[$ _name];
		return mouse_check_button_pressed(_mouse[0]) or mouse_check_button_pressed(_mouse[1]);
	}
	
	/**
	 * @desc Check if set mouse buttons of the input variable have been released.
	 * @param {string} _name Name of the input variable.
	 */
	static mouse_released = function(_name) {
		var _mouse = __mouse[$ _name];
		return mouse_check_button_released(_mouse[0]) or mouse_check_button_released(_mouse[1]);
	}
	
	/**
	 * @desc Check if a key is available.
	 * @param {any} _key Key to be checked.
	 */
	static free = function(_key) {
		var _free = true
		for (var i = 0; i < key_names_length; ++i) {
			if array_contains(__key[$ key_names[i]], _key) {
				_free = false;
				break;
			}
		}
		return _free
	}

	/**
	 * @desc Add an input variable and key(s) to be assigned.
	 * @param {string} _name Name of the input variable.
	 * @param {real} _primary Primary key to be set.
	 * @param {real} _secondary Optional. Default is -4.
	 */
	static add = function(_name, _primary, _secondary = -4) {
		if string_lettersdigits(_name) != _name { 
			return "Name cannot contain special characters!";
		}
		if struct_exists(__key, _name) {
			return "Name exists!";
		}
		if (_primary < 0 and _primary > 254) or (_secondary != -4 or (_secondary < 0 and _secondary > 254)) {
			return "Invalid key(s)!";
		}
		if !free(_primary) or (_secondary != -4 and !free(_secondary)) {
			return "Key(s) in use!";
		}
		var _name_lowercase = string_lower(_name);
		struct_set(__key, _name_lowercase, [_primary, _secondary]);
		return $"Input name : {_name_lowercase}\nPrimary key : {_primary}\nSecondary key : {_secondary}\nHave been added!"
	}
	
	/**
	 * @desc Remove input variable.
	 * @param {string} _name Name of the input variable.
	 */
	static remove = function(_name) {
		if _name == "" { 
			return "Name cannot be empty!"; 
		}
		if !struct_exists(__key, _name) { 
			return "Input does not exist!"; 
		}
		struct_remove(__key, _name);
		return "Input has been removed!"
	}
	/**
	 * @desc Assign key to primary or secondary of input variable.
	 * @param {string} _name Name of the input variable.
	 * @param {bool} _secondary Default is false.
	 */
	static assign = function(_name, _secondary = false) {
		if !free(keyboard_lastkey) { 
			return 0; 
		}
		var _get_key = keyboard_lastkey;
		keyboard_lastkey = -1;
		__key[$ _name][_secondary] = _get_key;
		return __keybind_list[_get_key];
	}
	
	/**
	 * @desc Unassign key from primary or secondary of input variable.
	 * @param {string} _name Name of the input variable.
	 * @param {bool} _secondary Default is false.
	 */
	static unassign = function(_name, _secondary = false) {
		var _index_name = _secondary == false ? "Primary" : "Secondary";
		if __key[$ _name][_secondary] == -4 {
			return $"{_index_name} input for '{_name}' is already unassigned!";
		}
		__key[$ _name][_secondary] = -4;
		return $"{_index_name} input for '{_name}' has been unassigned!"
	}
	
	return static_get(GMControls);
	
}

GMControls();
