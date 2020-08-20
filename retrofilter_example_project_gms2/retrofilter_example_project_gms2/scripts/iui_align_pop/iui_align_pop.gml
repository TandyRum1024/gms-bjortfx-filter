/// @description iui_align_pop()
/*
    Pops the previous align from the queue and sets it to current one.
*/

var prevH = iui_halign, prevV = iui_valign;
iui_valign = ds_stack_pop(iui_alignStack);
iui_halign = ds_stack_pop(iui_alignStack);

draw_set_halign(iui_halign);
draw_set_valign(iui_valign);

//show_debug_message("POP : new ["+string(iui_halign)+","+string(iui_valign)+"] prev [" +string(prevH)+","+string(prevV)+ "] ("+string(ds_stack_size(iui_alignStack))+")");

