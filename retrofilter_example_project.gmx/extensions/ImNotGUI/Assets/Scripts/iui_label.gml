#define iui_label
///iui_label(x, y, str, colour)

draw_text_colour(argument0, argument1, argument2, argument3, argument3, argument3, argument3, 1);

#define iui_label_alpha
///iui_label_alpha(x, y, str, colour, alpha)

draw_text_colour(argument0, argument1, argument2, argument3, argument3, argument3, argument3, argument4);
#define iui_label_transform
///iui_label_transform(x, y, str, xscale, yscale, rotation, colour, alpha)

draw_text_transformed_colour(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument6, argument6, argument6, argument7);
#define iui_label_shadow
///iui_label_shadow(x, y, str, colour, sx, sy, shadowColour)

draw_text_colour(argument0 + argument4, argument1 + argument5, argument2, argument6, argument6, argument6, argument6, 1);
draw_text_colour(argument0, argument1, argument2, argument3, argument3, argument3, argument3, 1);
#define iui_label_underline_expensive
///iui_label_underline_expensive(x, y, str, colour, line_thickness, line_offset_y, bg_colour)
/**
    Adds lil' outline to your text, Thus making the text more readable.
**/


var strWid = string_width(argument2);
var em_    = string_height('M') + argument5;

iui_rect(argument0 - 2, argument1 + em_, strWid + 4, argument4, argument3); // underline
iui_label(argument0 - 2, argument1, argument2, argument6); // quick trick - make fancy bottom line
iui_label(argument0 - 2, argument1 + 2, argument2, argument6);
iui_label(argument0, argument1 + 2, argument2, argument6);
iui_label(argument0 + 2, argument1 + 2, argument2, argument6);
iui_label(argument0 + 2, argument1, argument2, argument6);
iui_label(argument0, argument1, argument2, argument3);

#define iui_label_underline
///iui_label_underline(x, y, str, colour, line_thickness, line_offset_y)

var strWid = string_width(argument2);
var em_    = string_height('M') + argument5;
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

#define iui_label_ext
///iui_label_ext(x, y, str, colour, alpha, sep, width)

draw_text_ext_colour(argument0, argument1, argument2, argument5, argument6, argument3, argument3, argument3, argument3, argument4);