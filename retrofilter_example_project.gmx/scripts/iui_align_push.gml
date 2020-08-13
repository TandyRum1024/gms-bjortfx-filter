#define iui_align_push
///iui_align_push(halign, valign)
/*
    Pushes the current align into the queue and sets to new align.
*/

var prevH = iui_halign, prevV = iui_valign;
ds_stack_push(iui_alignStack, iui_halign, iui_valign);
iui_halign = argument0;
iui_valign = argument1;

draw_set_halign(iui_halign);
draw_set_valign(iui_valign);

//show_debug_message("PUSH : new ["+string(iui_halign)+","+string(iui_valign)+"] prev [" +string(prevH)+","+string(prevV)+ "] ("+string(ds_stack_size(iui_alignStack))+")");

#define iui_align_pop
///iui_align_pop()
/*
    Pops the previous align from the queue and sets it to current one.
*/

var prevH = iui_halign, prevV = iui_valign;
iui_valign = ds_stack_pop(iui_alignStack);
iui_halign = ds_stack_pop(iui_alignStack);

draw_set_halign(iui_halign);
draw_set_valign(iui_valign);

//show_debug_message("POP : new ["+string(iui_halign)+","+string(iui_valign)+"] prev [" +string(prevH)+","+string(prevV)+ "] ("+string(ds_stack_size(iui_alignStack))+")");

#define iui_align_center
///iui_align_center();

iui_align_push(fa_center, fa_middle);