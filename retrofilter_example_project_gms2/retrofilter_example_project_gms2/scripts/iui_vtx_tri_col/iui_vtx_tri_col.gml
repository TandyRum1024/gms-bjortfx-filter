/// @description iui_vtx_tri_col(x1, y1, x2, y2, x3, y3, colour)
/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  x3
/// @param  y3
/// @param  colour
/**
    [VERTEX BUFFER]
    Draws triangle with colours
    
    ==============================
    
    x1 ~ y3 - The position of triangle
    colour - The colour of triangle
**/

var _colour = iui_VBCOLOUR;
var _alpha  = iui_VBALPHA;
iui_VBCOLOUR = argument4;
iui_VBALPHA  = argument5;
iui_vtx(argument0, argument1);
iui_vtx(argument2, argument3);
iui_vtx(argument4, argument5);
iui_VBCOLOUR = _colour;
iui_VBALPHA  = _alpha;
