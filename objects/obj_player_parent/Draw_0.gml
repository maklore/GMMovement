draw_self();
draw_set_halign(fa_center);
var _string_name = object_get_name(id.object_index);
_string_name = string_delete(_string_name, 1, string_length("obj_player_"));
draw_text_transformed(x, y - sprite_width, _string_name, 1, 1, 0);