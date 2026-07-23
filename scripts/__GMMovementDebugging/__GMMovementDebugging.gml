global.refGMMovement = GMMovement();
global.refGMMSet = GMMSet();
global.refGMMConfig = __GMMConfig();

function __GMMDebug(_enable) {

	dbg_view("GMMovement", _enable);
		dbg_section("General", true);
			dbg_text(" collision_horiz:                  "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "collision_horiz"));
			dbg_text(" collision_vert:                   "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "collision_vert"));
			dbg_slider(ref_create(__GMMConfig(), "walk_speed"), -__GMMConfig.walk_speed_max, __GMMConfig.walk_speed_max, "walk_speed:");
				dbg_text_input(ref_create(__GMMConfig(), "walk_speed_max"), "walk_speed_max:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "walk_speed_acc"), "walk_speed_acc:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "walk_speed_dec"), "walk_speed_dec:", "r");
			dbg_slider(ref_create(__GMMConfig(), "run_speed"),  -__GMMConfig.run_speed_max,  __GMMConfig.run_speed_max, "run_speed:");
				dbg_text_input(ref_create(__GMMConfig(), "run_speed_max"), "run_speed_max:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "run_speed_acc"), "run_speed_acc:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "run_speed_dec"), "run_speed_dec:", "r");
			dbg_text(" dash_countdown:                   "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "dash_countdown"));
				dbg_text_input(ref_create(__GMMConfig(), "dash_cooldown"), "dash_cooldown:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "dash_speed"), "dash_speed:", "r");
		
		dbg_section("Platformer", true);
			dbg_text(" collision_ground:                 "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "collision_ground"));
			dbg_slider(ref_create(__GMMConfig(), "fall_speed"), -__GMMConfig.jump_speed,	 __GMMConfig.fall_speed_max, "fall_speed;");
				dbg_text_input(ref_create(__GMMConfig(), "fall_speed_max"), "fall_speed_max:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "fall_speed_acc"), "fall_speed_acc:", "r");
			dbg_text(" jump_triggered:                   "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "jump_triggered"));
				dbg_text_input(ref_create(__GMMConfig(), "jump_speed"), "jump_speed:", "r");
				dbg_text_input(ref_create(__GMMConfig(), "jump_speed_dec"), "jump_speed_dec:", "r");
			dbg_checkbox(ref_create(__GMMConfig(), "jump_ground_req"), "jump_ground_req:");
			dbg_text(" jump_grounded:                    "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "jump_grounded"));
			dbg_text(" jump_coyote_active:               "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "jump_coyote_active"));
			dbg_text(" jump_coyote_timer:                "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "jump_coyote_timer"));
				dbg_text_input(ref_create(__GMMConfig(), "jump_coyote_time"), "jump_coyote_time:", "r");
			dbg_text(" jump_count:                       "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "jump_count"));
				dbg_text_input(ref_create(__GMMConfig(), "jump_count_max"), "jump_count_max:", "r");
		
		dbg_section("Eight way", true);
			dbg_text(" walk_speed_x:                      "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "walk_speed_x"));
			dbg_text(" walk_speed_y:                      "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "walk_speed_y"));
			dbg_text(" direction_last:                    "); dbg_same_line(); dbg_text(ref_create(__GMMConfig(), "direction_last"));
}