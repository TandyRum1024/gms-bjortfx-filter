/// @description iui_slider_v(x, y, value, height, min, max, ID)
/// @param x
/// @param  y
/// @param  value
/// @param  height
/// @param  min
/// @param  max
/// @param  ID
/**
    Slider for IMNOTGUI!
    
    ===========================
    
    x, y - sfjkdsgfdjskgdfgfd
    value - value of slider
    height - how looong
    min, max - min, max value of slider
    ID - software
**/

var btnX = argument0 - (iuiSliderVWid / 2);
var btnY = argument1 - (iuiSliderVHei / 2);
var btnW = iuiSliderVWid;
var btnH = iuiSliderVHei;

var lineX = argument0 - (iuiSliderThick / 2);
var lineY = argument1;

var length    = argument3;
var sliderVal = argument2;
var sliderMin = argument4;
var sliderMax = argument5;

var ID    = iui_get_id(argument6);
var IDSTR = string(ID);
var relativePos = iui_varmap[? IDSTR + "_relativepos"];
if (relativePos == undefined)
    relativePos = 0;
    
var sliderPos = (relativePos * length);
var btnHalfH  = (iuiSliderVHei / 2);
btnY = lineY + sliderPos - btnHalfH;


/// Slider logic
// is hover
if (point_in_rectangle(iui_inputX, iui_inputY, btnX, btnY, btnX + btnW, btnY + btnH))
{
    iui_hotItem = ID;
    
    // ... and is clicked
    if (iui_activeItem == -1 && iui_inputDown)
    {
        iui_activeItem = ID;
    }
}


// drag / slide
var isActive  = (iui_activeItem == ID);
var sliderMid = (sliderMax - sliderMin);
if (isActive)
{
    var relativeY = (iui_inputY - lineY) / length;
    relativeY     = clamp(relativeY, 0, 1);
    relativePos   = relativeY;
    
    relativeY *= sliderMid;
    sliderVal  = relativeY + sliderMin;
}
else // still update if the values somehow changes
{
    var relativeY = (sliderVal - sliderMin) / sliderMid;
    relativeY     = clamp(relativeY, 0, 1);
    relativePos   = relativeY;
}


// draw
var btnColour = iuiColSlider;

// slider guideline
iui_rect(lineX, lineY, iuiSliderThick, length, iuiColSliderLine);

// slider button / handle
if (isActive)
{
    // slider button
    iui_rect(btnX, btnY, btnW, btnH, iuiColSliderActive);
    
    // slider guide text
    if (iuiSliderDisplayValue)
    {
        iui_align_center();
        
        iui_label(lineX + (iuiSliderThick / 2), lineY - 32, string(sliderMin), iuMint);
        iui_label(lineX + (iuiSliderThick / 2), lineY + length + 32, string(sliderMax), iuRed);
        iui_label(lineX, btnY - 20, string(sliderVal), iuCream);
        
        iui_align_pop();
    }
}
else if (iui_hotItem == ID)
{
    // slider button
    iui_rect(btnX, btnY, btnW, btnH, iuiColSliderHot);
    
    // slider guide text
    if (iuiSliderDisplayValue)
    {
        iui_align_center();
        
        iui_label(lineX, btnY - 20, string(sliderVal), iuCream);
        
        iui_align_pop();
    }
}

iui_rect(btnX, btnY, btnW, btnH, btnColour);


// update varmap
iui_varmap[? IDSTR + "_relativepos"] = relativePos;

return sliderVal;
