draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _text = 
@"Press 'Tab' to swap another objects movement type.
Press ('A' or 'Left arrow') or ('D' or 'Right arrow') to move horizontally (rotate with motion).
Press ('W' or 'Up arrow') or ('S' or 'Down arrow') to move vertically (for-/backwards with motion).
Press 'Spacebar' to jump (Platformer).
Press 'CTRL' to dash.
Hold 'Shift' to run/record grid movement.";
var _scale = 0.75;
var _text_w = string_width(_text) * _scale;
var _text_h = string_height(_text) * _scale;
var _padding = 5;
var _x = _padding;
var _y = 1080 - _text_h - _padding;
draw_rectangle_colour(_x - _padding, _y - _padding, _x + _text_w + _padding, _y + _text_h + _padding, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
draw_text_transformed(_x, _y, _text, _scale, _scale, 0);
