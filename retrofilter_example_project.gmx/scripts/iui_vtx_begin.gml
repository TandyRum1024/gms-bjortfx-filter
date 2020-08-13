#define iui_vtx_begin
/**
    Starts the vertex buffer
    
    =========================
**/

vertex_begin(iui_VB, iui_VF);

#define iui_vtx_end
/**
    Ends the vertex buffer
    
    =========================
**/

vertex_end(iui_VB);

#define iui_vtx_submit
/**
    Submits the vertex buffer
    
    =========================
**/

vertex_submit(iui_VB, pr_trianglelist, -1);