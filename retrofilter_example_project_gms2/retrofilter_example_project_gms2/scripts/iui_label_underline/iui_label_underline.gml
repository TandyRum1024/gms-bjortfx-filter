/// @description iui_label_underline(x, y, str, colour, line_thickness, line_offset_y)
/// @param x
/// @param  y
/// @param  str
/// @param  colour
/// @param  line_thickness
/// @param  line_offset_y

var strWid = string_width(string_hash_to_newline(argument2));
var em_    = string_height(string_hash_to_newline("M")) + argument5;
var xoff = 0;
var yoff = em_;

if (iui_halign != fa_left)
{
    if (iui_halign == fa_middle)
        xoff = -(strWid / 2);
    
    if (iui_halign == fa_right)
        xoff = -strWid;
}

if (iui_valign != fa_top)
{
    if (iui_valign == fa_middle)
        yoff -= (em_ / 2);
    
    if (iui_valign == fa_bottom)
        yoff -= em_;
}

iui_rect(argument0 - 2 + xoff, argument1 + yoff, strWid + 4, argument4, iui_colLighter_adv(argument3, -42, 1.15, 1.3, 1.05)); // underline
iui_label(argument0, argument1, argument2, argument3);

