/// @description iui_rect(x, y, w, h, colour)
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  colour
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, argument4, 1);

