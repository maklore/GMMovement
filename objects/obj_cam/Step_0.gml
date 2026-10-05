if keyboard_check_released(vk_tab) {
	targets[target_index].is_active = false;
	target_index++;
	if target_index >= target_count {
		target_index = 0;	
	}
	GMMInit(targets[target_index], obj_collision_parent);
	camera.target(targets[target_index], 1, 0.06);
	targets[target_index].is_active = true;	
}