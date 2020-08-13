/// @description iui_rect_alpha(x, y, w, h, colour, alpha)
/// @param x
/// @param  y
/// @param  w
/// @param  h
/// @param  colour
/// @param  alpha
/**
    Draws rectangle optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x y w h - The position and size of rect
    colour  - It's colour, Y'see?
    alpha   - Alpha of rect
**/

draw_sprite_part_ext(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument3, argument4, argument5);

