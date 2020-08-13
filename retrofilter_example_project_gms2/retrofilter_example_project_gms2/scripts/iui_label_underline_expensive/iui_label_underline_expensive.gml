/// @description iui_label_underline_expensive(x, y, str, colour, line_thickness, line_offset_y, bg_colour)
/// @param x
/// @param  y
/// @param  str
/// @param  colour
/// @param  line_thickness
/// @param  line_offset_y
/// @param  bg_colour
/**
    Adds lil' outline to your text, Thus making the text more readable.
**/


var strWid = string_width(string_hash_to_newline(argument2));
var em_    = string_height(string_hash_to_newline("M")) + argument5;

iui_rect(argument0 - 2, argument1 + em_, strWid + 4, argument4, argument3); // underline
iui_label(argument0 - 2, argument1, argument2, argument6); // quick trick - make fancy bottom line
iui_label(argument0 - 2, argument1 + 2, argument2, argument6);
iui_label(argument0, argument1 + 2, argument2, argument6);
iui_label(argument0 + 2, argument1 + 2, argument2, argument6);
iui_label(argument0 + 2, argument1, argument2, argument6);
iui_label(argument0, argument1, argument2, argument3);

