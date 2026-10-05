show_debug_overlay(false)
surface_resize(application_surface, 1920, 1080);
display_set_gui_size(1920, 1080);
window_set_size(1280, 720)
draw_set_font(fnt_UI);
__GMMDebug(false);

targets = [];
target_index = 0;

with (obj_player_parent) {
	array_push(other.targets, id);	
}
target_count = array_length(targets);

camera = new GMCamera(1920, 1080);
camera.size(1280, 720);
camera.target(targets[target_index], 1, 0.06);
targets[target_index].is_active = true;
camera.enable(true);