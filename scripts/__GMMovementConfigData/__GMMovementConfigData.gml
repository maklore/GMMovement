/**
* @returns {struct.__GMMConfig}
*/
function __GMMConfig() {
	
	static config = {
		
		player			: noone,
		collision		: noone,
		
		walk_speed		: 0,
		walk_speed_max	: GMM_walk_speed_max,
		walk_speed_acc	: GMM_walk_speed_acc,
		walk_speed_dec	: GMM_walk_speed_dec,
		
		run_speed		: 0,
		run_speed_max	: GMM_run_speed_max,
		run_speed_acc	: GMM_run_speed_acc,
		run_speed_dec	: GMM_run_speed_dec,
		
		dash_speed		: 0,
		dash_speed_max	: GMM_dash_speed_max,
		dash_speed_acc	: GMM_dash_speed_acc,
		dash_speed_dec	: GMM_dash_speed_dec,
		
		jump_speed		: 0,
		jump_speed_max	: GMM_jump_speed_max,
		jump_speed_acc	: GMM_jump_speed_acc,
		jump_speed_dec	: GMM_jump_speed_dec,
		
		fall_speed		: 0,
		fall_speed_max	: GMM_fall_speed_max,
		fall_speed_acc	: GMM_fall_speed_acc,
		fall_speed_dec	: GMM_fall_speed_dec
	
	}
	
	return static_get(__GMMConfig)
}

__GMMConfig();