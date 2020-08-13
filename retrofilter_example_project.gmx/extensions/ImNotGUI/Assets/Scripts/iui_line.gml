#define iui_line
///iui_line(x, y, length, angle, thick, colour)
/**
    Draws line optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x, y    - The position of line
    length  - length of line
    angle   - rotation of line
    thick   - THICCness
    colour  - It's colour, Y'see?
**/

draw_sprite_general(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument4, argument3, argument5, argument5, argument5, argument5, 1);

#define iui_line_alpha
///iui_line_alpha(x, y, length, angle, thick, colour, alpha)
/**
    Draws line optimized while abusing the Gamemaker's sprite-batch.
    
    ======================================================================
    
    x, y    - The position of line
    length  - length of line
    angle   - rotation of line
    thick   - THICCness
    colour  - It's colour, Y'see?
    alpha
**/

draw_sprite_general(spr_uiwhitepixel, 0, 1, 1, 1, 1, argument0, argument1, argument2, argument4, argument3, argument5, argument5, argument5, argument5, argument6);