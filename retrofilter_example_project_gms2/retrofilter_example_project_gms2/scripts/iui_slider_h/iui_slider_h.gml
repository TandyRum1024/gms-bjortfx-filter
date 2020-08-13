/// @description iui_slider_h(x, y, value, width, min, max, ID)
/// @param x
/// @param  y
/// @param  value
/// @param  width
/// @param  min
/// @param  max
/// @param  ID
/**
    Slider for IMNOTGUI!
    
    ===========================
    
    x, y - sfjkdsgfdjskgdfgfd
    value - value of slider
    width - how looong
    min, max - min, max value of slider
    ID - software
**/

var btnX = argument0 - (iuiSliderHWid / 2);
var btnY = argument1 - (iuiSliderHHei / 2);
var btnW = iuiSliderHWid;
var btnH = iuiSliderHHei;

var lineX = argument0;
var lineY = argument1 - (iuiSliderThick / 2);

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
var btnHalfW  = (iuiSliderHWid / 2);
btnX = lineX + sliderPos - btnHalfW;


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
    var relativeX = (iui_inputX - lineX) / length;
    relativeX     = clamp(relativeX, 0, 1);
    relativePos   = relativeX;
    
    relativeX *= sliderMid;
    sliderVal  = relativeX + sliderMin;
}
else // still update if the values somehow changes
{
    var relativeX = (sliderVal - sliderMin) / sliderMid;
    relativeX     = clamp(relativeX, 0, 1);
    relativePos   = relativeX;
}


// draw
var btnColour = iuiColSlider;

// slider guideline
iui_rect(lineX, lineY, length, iuiSliderThick, iuiColSliderLine);

// slider button / handle
if (isActive)
{
    // change slider button colour
    btnColour = iuiColSliderActive;
    
    // slider guide text
    if (iuiSliderDisplayValue)
    {
        iui_align_center();
        
        var _linecentery = lineY + (iuiSliderThick / 2);
        var _recth = string_height(string_hash_to_newline("M")) + 8;
        iui_rect(lineX - 42, _linecentery - _recth * 0.5, length + 84, _recth, iuHellaDark);
        iui_label(lineX - 32, _linecentery, string(sliderMin), iuMint);
        iui_label(lineX + length + 32, _linecentery, string(sliderMax), iuRed);
        
        var _rectstr = string(sliderVal);
        var _rectw = string_width(string_hash_to_newline(_rectstr)) + 16;
        var _recth = string_height(string_hash_to_newline(_rectstr)) + 8;
        iui_rect(btnX + btnHalfW - _rectw * 0.5, lineY + (btnH / 2) + 10 - _recth * 0.5, _rectw, _recth, c_black);
        iui_label(btnX + btnHalfW, lineY + (btnH / 2) + 10, string(sliderVal), iuCream);
        
        iui_align_pop();
    }
}
else if (iui_hotItem == ID)
{
    // slider button
    btnColour = iuiColSliderHot;
    
    // slider guide text
    if (iuiSliderDisplayValue)
    {
        iui_align_center();
        
        iui_label(btnX + btnHalfW, lineY + btnH, string(sliderVal), iuCream);
        
        iui_align_pop();
    }
}
iui_rect(btnX, btnY, btnW, btnH, btnColour);


// update varmap
iui_varmap[? IDSTR + "_relativepos"] = relativePos;

return sliderVal;

