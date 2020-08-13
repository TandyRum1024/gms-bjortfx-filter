#define iui_textbox
///iui_textbox(x, y, w, h, text, ID)
/**
    Textbox for writting stuff
    
    returns text
    ===============================
    
    x, y, w, h - position, and size of the textbox
    text - the text for textbox
    ID - the ID for textbox
**/

/// Setup
var bx = argument0, by = argument1, bw = argument2, bh = argument3;
var insideWid    = (bw - 4); // used both for drawing and trimming string.
var em_          = string_width('M');     // size of a M
var displayChars = (insideWid div em_);   // how much characters currently displayed?
var maxChars     = (displayChars - 1);      // how much characters before Trim?


/// Get ID & vars
var ID    = iui_get_id(argument5);
var IDSTR = string(ID);
var showPos   = iui_varmap[? IDSTR + "_showpos"];
var cursorPos = iui_varmap[? IDSTR + "_cursorpos"];

if (showPos == undefined) // doesn't exist???
{
    showPos   = 0; // we'il update the varmap later, Anyway.
    cursorPos = 0;
}

// text related
var currentText = argument4;
var currentLen  = string_length(currentText);
var trimText    = string_delete(currentText, 1, showPos);
var mustTrim    = (string_width(trimText) > (insideWid - 8));
displayChars    = min(currentLen - showPos, displayChars);

if (mustTrim)
{
    displayChars -= 3; // We don't want users to move cursor over the '...'
    maxChars     -= 3;
}

    
/// Textbox logic
// is hover
if (point_in_rectangle(iui_inputX, iui_inputY, bx, by, bx + bw, by + bh))
{
    iui_hotItem = ID;
    
    // ... and is clicked
    // TODO : Somehow implement mouse navigating
    if (iui_activeItem == -1 && iui_inputDown)
    {
        iui_activeItem  = ID;
        iui_kbFocusItem = ID;
        
        var totalWidth = 12, charInd = 0;
        var relativeX  = (iui_inputX - bx) + (em_ / 2);
        while (totalWidth < relativeX && charInd <= displayChars && totalWidth < bw)
        {
            charInd++;
            totalWidth += string_width(string_char_at(trimText, charInd));
        }
        if (mustTrim)
            charInd = min(charInd, displayChars);
        
        cursorPos = showPos + max((charInd - 1), 0);
    }
}
else if (iui_inputDown && iui_kbFocusItem == ID)
    iui_kbFocusItem = -1;

    
// typing stuff
var isActive  = (iui_activeItem == ID);
var isHot     = (iui_hotItem == ID);
var isFocus   = (iui_kbFocusItem == ID);
var inputCode = ord(iui_keyChar);
var keyAxis;

if (isFocus)
{
    keyAxis = (iui_keyPress == vk_right) - (iui_keyPress == vk_left);
    
    if (iui_keyPress == vk_backspace) // delet
    {
        // Hash (#)
        if (string_ord_at(currentText, cursorPos) == 35)
            currentText = string_delete(currentText, cursorPos - 1, 2);
        else
            currentText = string_delete(currentText, cursorPos, 1);
        
        cursorPos--;
        
        if (cursorPos < (showPos + 1)) // move er'!
        {
            showPos--;
            
            if (showPos < 0)
            {
                showPos   = 0;
                cursorPos = 0;
            }
        }
    }
    else if (keyAxis != 0) // move cursor
    {
        cursorPos += keyAxis;
        
        if (cursorPos < showPos || cursorPos >= (showPos + displayChars)) // move er'!
        {
            showPos += keyAxis;
            
            if (showPos < 0)
            {
                showPos   = 0;
                cursorPos = 0;
            }
            else if (showPos > (currentLen - displayChars))
            {
                showPos   = (currentLen - displayChars);
                cursorPos = currentLen + 1;
            }
        }
        if (cursorPos > currentLen)
            cursorPos = currentLen;
    }
    else if (inputCode >= 32 && inputCode <= 255) // write
    {
        // Hash (#)
        if (inputCode == 35)
        {
            currentText = string_insert("\#", currentText, cursorPos + 1);
            cursorPos++;
        }
        else
            currentText = string_insert(iui_keyChar, currentText, cursorPos + 1);
        
        cursorPos++;
        
        
        if (cursorPos > (showPos + maxChars) - 1) // move er'!
            showPos++;
    }
}


/// Draw
var textColour   = iuiColTextBoxText;
var fillColour   = iuiColTextBoxFill;
var borderColour = iuiColTextBoxBorder;

// Is active or something
if (isActive || isFocus)
{
    fillColour = iuiColTextBoxActiveFill;
    textColour = iuiColTextBoxActiveText;
    if (iuiTextBoxRainbow)
        borderColour = make_colour_hsv(iuiAnimTime, 222, 255);
    else
        borderColour = iuiColTextBoxActiveBorder;
}
else if (isHot)
{
    textColour   = iuiColTextBoxHotText;
    fillColour   = iuiColTextBoxHotFill;
    borderColour = iuiColTextBoxHotBorder;
}

iui_rect(bx, by, bw, bh, borderColour);               // outline
iui_rect(bx + 2, by + 2, insideWid, bh - 4, fillColour); // inside

// text
if (mustTrim)
    trimText = string_copy(trimText, 1, (displayChars - 1));//strTrim_nodots(trimText, insideWid - 8);

iui_align_push(fa_left, fa_middle);

iui_label(bx + 10, by + (bh >> 1), trimText, textColour);

// Fading 3 chars for trimming
var textEndX = string_width(string_copy(currentText, 1, displayChars - 1));
var tmpChar  = string_char_at(currentText, (showPos + displayChars));
var textOffX = bx + 10 + textEndX;
var textOffY = by + (bh >> 1);

if (mustTrim)
{
    iui_label_alpha(textOffX, textOffY + sin(iuiAnimTime * 0.1) * 2, tmpChar, iuiColTextBoxText, 0.75);
    textOffX += string_width(tmpChar);
    tmpChar   = string_char_at(currentText, (showPos + displayChars) + 1);
    
    iui_label_alpha(textOffX, textOffY + sin((iuiAnimTime * 0.1) + 42) * 4, tmpChar, iuiColTextBoxText, 0.5);
    textOffX += string_width(tmpChar);
    tmpChar   = string_char_at(currentText, (showPos + displayChars) + 2);
    
    iui_label_alpha(textOffX, textOffY + sin((iuiAnimTime * 0.1) + 84) * 6, tmpChar, iuiColTextBoxText, 0.25);
}

iui_align_pop();

// cursor
var cursorX = string_width(string_copy(currentText, 1, (cursorPos - showPos)));
if (isFocus)
    iui_rect_alpha(bx + (cursorX - 2) + 10, by + 10, 4, bh - 20, textColour, sin(iuiAnimTime * 0.1));

// update varmap
iui_varmap[? IDSTR + "_showpos"]   = showPos;
iui_varmap[? IDSTR + "_cursorpos"] = cursorPos;

return currentText;

#define iui_textbox_numberonly
///iui_textbox_numberonly(x, y, w, h, text, ID)
/**
    Number-only Textbox for writting stuff
    
    returns text
    ===============================
    
    x, y, w, h - position, and size of the textbox
    text - the text for textbox
    ID - the ID for textbox
**/

/// Setup
var bx = argument0, by = argument1, bw = argument2, bh = argument3;
var insideWid    = (bw - 4); // used both for drawing and trimming string.
var em_          = string_width('M');     // size of a M
var displayChars = (insideWid div em_);   // how much characters currently displayed?
var maxChars     = (displayChars - 1);      // how much characters before Trim?


/// Get ID & vars
var ID    = iui_get_id(argument5);
var IDSTR = string(ID);
var showPos   = iui_varmap[? IDSTR + "_showpos"];
var cursorPos = iui_varmap[? IDSTR + "_cursorpos"];

if (showPos == undefined) // doesn't exist???
{
    showPos   = 0; // we'il update the varmap later, Anyway.
    cursorPos = 0;
}

// text related
var currentText = argument4;
var currentLen  = string_length(currentText);
var trimText    = string_delete(currentText, 1, showPos);
var mustTrim    = (string_width(trimText) > (insideWid - 8));
displayChars    = min(currentLen - showPos, displayChars);

if (mustTrim)
{
    displayChars -= 3; // We don't want users to move cursor over the '...'
    maxChars     -= 3;
}

    
/// Textbox logic
// is hover
if (point_in_rectangle(iui_inputX, iui_inputY, bx, by, bx + bw, by + bh))
{
    iui_hotItem = ID;
    
    // ... and is clicked
    // TODO : Somehow implement mouse navigating
    if (iui_activeItem == -1 && iui_inputDown)
    {
        iui_activeItem  = ID;
        iui_kbFocusItem = ID;
        
        var totalWidth = 12, charInd = 0;
        var relativeX  = (iui_inputX - bx) + (em_ / 2);
        while (totalWidth < relativeX && charInd <= displayChars && totalWidth < bw)
        {
            charInd++;
            totalWidth += string_width(string_char_at(trimText, charInd));
        }
        if (mustTrim)
            charInd = min(charInd, displayChars);
        
        cursorPos = showPos + max((charInd - 1), 0);
    }
}
else if (iui_inputDown && iui_kbFocusItem == ID)
    iui_kbFocusItem = -1;

    
// typing stuff
var isActive  = (iui_activeItem == ID);
var isHot     = (iui_hotItem == ID);
var isFocus   = (iui_kbFocusItem == ID);
var inputCode = ord(iui_keyChar);
var keyAxis;

if (isFocus)
{
    keyAxis = (iui_keyPress == vk_right) - (iui_keyPress == vk_left);
    
    if (iui_keyPress == vk_backspace) // delet
    {
        currentText = string_delete(currentText, cursorPos, 1);
        cursorPos--;
        
        if (cursorPos < (showPos + 1)) // move er'!
        {
            showPos--;
            
            if (showPos < 0)
            {
                showPos   = 0;
                cursorPos = 0;
            }
        }
    }
    else if (keyAxis != 0) // move cursor
    {
        cursorPos += keyAxis;
        
        if (cursorPos < showPos || cursorPos >= (showPos + displayChars)) // move er'!
        {
            showPos += keyAxis;
            
            if (showPos < 0)
            {
                showPos   = 0;
                cursorPos = 0;
            }
            else if (showPos > (currentLen - displayChars))
            {
                showPos   = (currentLen - displayChars);
                cursorPos = currentLen + 1;
            }
        }
        if (cursorPos > currentLen)
            cursorPos = currentLen;
    }
    else if (inputCode >= 48 && inputCode <= 57 && currentLen <= 13) // write
    {
        // Hash (#)
        currentText = string_insert(iui_keyChar, currentText, cursorPos + 1);
        cursorPos++;
        
        
        if (cursorPos > (showPos + maxChars) - 1) // move er'!
            showPos++;
    }
    else if (inputCode == 45 && cursorPos == 0) // minus
    {
        currentText = string_insert('-', currentText, cursorPos + 1);
        cursorPos++;
    }
    else if (inputCode == 46 && string_pos(currentText, '.') == 0) // dot
    {
        currentText = string_insert('.', currentText, cursorPos + 1);
        cursorPos++;
    }
}


/// Draw
var textColour   = iuiColTextBoxText;
var fillColour   = iuiColTextBoxFill;
var borderColour = iuiColTextBoxBorder;

// Is active or something
if (isActive || isFocus)
{
    textColour = iuiColTextBoxActiveText;
    fillColour = iuiColTextBoxActiveFill;
    if (iuiTextBoxRainbow)
        borderColour = make_colour_hsv(iuiAnimTime, 222, 255);
    else
        borderColour = iuiColTextBoxActiveBorder;
}
else if (isHot)
{
    textColour   = iuiColTextBoxHotText;
    fillColour   = iuiColTextBoxHotFill;
    borderColour = iuiColTextBoxHotBorder;
}

iui_rect(bx, by, bw, bh, borderColour);               // outline
iui_rect(bx + 2, by + 2, insideWid, bh - 4, fillColour); // inside

// text
if (mustTrim)
    trimText = strTrim_nodots(trimText, insideWid - 8);

iui_align_push(fa_left, fa_middle);

iui_label(bx + 10, by + (bh >> 1), trimText, textColour);

// Fading 3 chars for trimming
var textEndX = string_width(string_copy(currentText, 1, displayChars - 1));
var tmpChar  = string_char_at(currentText, (showPos + displayChars));
var textOffX = bx + 10 + textEndX;
var textOffY = by + (bh >> 1);

if (mustTrim)
{
    iui_label_alpha(textOffX, textOffY + sin(iuiAnimTime * 0.1) * 2, tmpChar, iuiColTextBoxText, 0.75);
    textOffX += string_width(tmpChar);
    tmpChar   = string_char_at(currentText, (showPos + displayChars) + 1);
    
    iui_label_alpha(textOffX, textOffY + sin((iuiAnimTime * 0.1) + 42) * 4, tmpChar, iuiColTextBoxText, 0.5);
    textOffX += string_width(tmpChar);
    tmpChar   = string_char_at(currentText, (showPos + displayChars) + 2);
    
    iui_label_alpha(textOffX, textOffY + sin((iuiAnimTime * 0.1) + 84) * 6, tmpChar, iuiColTextBoxText, 0.25);
}

iui_align_pop();

// cursor
var cursorX = string_width(string_copy(currentText, 1, (cursorPos - showPos)));
if (isFocus)
    iui_rect_alpha(bx + (cursorX - 2) + 10, by + 10, 4, bh - 20, textColour, sin(iuiAnimTime * 0.1));

// update varmap
iui_varmap[? IDSTR + "_showpos"]   = showPos;
iui_varmap[? IDSTR + "_cursorpos"] = cursorPos;

return currentText;