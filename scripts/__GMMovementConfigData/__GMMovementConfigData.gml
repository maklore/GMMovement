/**
* @returns {struct.__GMMConfig}
*/
function __GMMConfig() {
			
	static player			  = noone;
	static collision		  = noone;
	static collision_horiz	  = noone;
	static collision_vert	  = noone;
	static collision_ground	  = noone;
	static gamespeed		  = 60;	
		
	static direction_last	  = 0;
	
	static walk_speed		  = 0;
	static walk_speed_x		  = 0;
	static walk_speed_y		  = 0;
	static walk_speed_max	  = GMM_walk_speed_max;
	static walk_speed_acc	  = GMM_walk_speed_acc;
	static walk_speed_dec	  = GMM_walk_speed_dec;
		
	static run_speed		  = 0;
	static run_speed_max	  = GMM_run_speed_max;
	static run_speed_acc	  = GMM_run_speed_acc;
	static run_speed_dec	  = GMM_run_speed_dec;
		
	static dash_speed		  = GMM_dash_speed;
	static dash_cooldown	  = GMM_dash_cooldown;
	static dash_countdown	  = GMM_dash_countdown;
	
	static jump_speed		  = GMM_jump_speed;
	static jump_speed_dec	  = GMM_jump_speed_dec;
	static jump_ground_req	  = GMM_jump_grounded;
	static jump_grounded	  = false;
	static jump_triggered	  = false;
	static jump_coyote_time   = GMM_jump_coyote_time;
	static jump_coyote_timer  = 0;
	static jump_coyote_active = false;
	static jump_count		  = 0;
	static jump_count_max	  = GMM_jump_count_max;
		
	static fall_speed		  = 0;
	static fall_speed_max	  = GMM_fall_speed_max;
	static fall_speed_acc	  = GMM_fall_speed_acc
	
	
	return static_get(__GMMConfig)
}

__GMMConfig();