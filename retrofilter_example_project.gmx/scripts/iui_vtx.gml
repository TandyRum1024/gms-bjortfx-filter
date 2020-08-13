#define iui_vtx
///iui_vtx(x, y)

vertex_position(iui_VB, argument0, argument1);
vertex_colour(iui_VB, iui_VBCOLOUR, iui_VBALPHA);

#define iui_vtx_col
///iui_vtx_col(x, y, colour, alpha)

vertex_position(iui_VB, argument0, argument1);
vertex_colour(iui_VB, argument2, argument3);