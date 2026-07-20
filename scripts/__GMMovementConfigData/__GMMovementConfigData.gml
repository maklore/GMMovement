/**
* @returns {struct.__GMMConfig}
*/
function __GMMConfig() {
	
	static config = {
		
		player			 : noone,
		collision		 : noone,
		gamespeed		 : 60,	
		
		walk_speed		 : 0,
		walk_speed_max	 : GMM_walk_speed_max,
		walk_speed_acc	 : GMM_walk_speed_acc,
		walk_speed_dec	 : GMM_walk_speed_dec,
		
		run_speed		 : 0,
		run_speed_max	 : GMM_run_speed_max,
		run_speed_acc	 : GMM_run_speed_acc,
		run_speed_dec	 : GMM_run_speed_dec,
		
		dash_speed		 : GMM_dash_speed,
		dash_cooldown	 : GMM_dash_cooldown,
		
		jump_speed		 : GMM_jump_speed,
		jump_speed_dec	 : GMM_jump_speed_dec,
		jump_grounded	 : GMM_jump_grounded,
		jump_coyote_time : GMM_jump_coyote_time,
		
		fall_speed		 : 0,
		fall_speed_max	 : GMM_fall_speed_max,
		fall_speed_acc	 : GMM_fall_speed_acc
	
	}
	
	return static_get(__GMMConfig)
}

__GMMConfig();