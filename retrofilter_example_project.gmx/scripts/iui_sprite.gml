#define iui_sprite
///iui_sprite(sprite, sub, x, y, colour, alpha)
/**
    Stripped down version of draw_sprite_ext
**/

draw_sprite_ext(argument0, argument1, argument2, argument3, 1, 1, 0, argument4, argument5);

#define iui_sprite_shadow
///iui_sprite_shadow(sprite, sub, x, y, colour, alpha, shadowOffX, shadowOffY, shadowColour)
/**
    Stripped down version of draw_sprite_ext with shadows
**/

draw_sprite_ext(argument0, argument1, argument2 + argument6, argument3 + argument7, 1, 1, 0, argument8, argument5);
draw_sprite_ext(argument0, argument1, argument2, argument3, 1, 1, 0, argument4, argument5);