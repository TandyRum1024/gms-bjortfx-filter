/// @description iui_sprite_shadow(sprite, sub, x, y, colour, alpha, shadowOffX, shadowOffY, shadowColour)
/// @param sprite
/// @param  sub
/// @param  x
/// @param  y
/// @param  colour
/// @param  alpha
/// @param  shadowOffX
/// @param  shadowOffY
/// @param  shadowColour
/**
    Stripped down version of draw_sprite_ext with shadows
**/

draw_sprite_ext(argument0, argument1, argument2 + argument6, argument3 + argument7, 1, 1, 0, argument8, argument5);
draw_sprite_ext(argument0, argument1, argument2, argument3, 1, 1, 0, argument4, argument5);
