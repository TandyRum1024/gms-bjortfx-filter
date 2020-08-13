///iui_tab(x, y, w, h, array_of_string, tab_index, trim_mode)
/**
    Makes tabs!
    
    Usage :
        // make variable that stores the current tab index
        tabIdx = 0;
        
        // and use that for this                               V use the variable here
        tabIdx = (42, 42, 42, 42, pack("UNO", "DOS", "TRES"), tabIdx, 0);
    
    returns currently pressed tab index
    ===============================
    
    x, y, w, h - the position of tab, and (default) size of the each tab
    array_of_string (array) - the array of strings.
     (Use pack() to pack the strings!)
     
    tab_index - index of current tab.
    trim_mode - selects how to take care of string that's too long
     0 - Normal, Draw the text normally ("bleeds" over the button).
     1 - Trims the string
     2 - Makes the tab wider
**/

/// Setup
var numTabs = array_length_1d(argument4);
var tabX = argument0, tabY = argument1;
var tabW = argument2, tabH = argument3;
var tabCurrent = argument5; // selected tab index
// array
var IDs    = 0;
var labels = 0;

/// ID for each tabs
var i, _IDSTR, _IDMAP;
var stringArr;
for (i = 0; i < numTabs; i++)
{
    stringArr = iui_get_all(argument4[@ i]);
    IDs[i]    = stringArr[0];
    labels[i] = stringArr[1];
}

/// Button logic for each tabs
var isCurrent, isHot;
var tmpLabel;
var tabLabel, tabLabelWid;
var tabBoxX = tabX, tabBoxY = tabY;
var tabBoxW, tabBoxH;
var tabID;
var colBackdrop, colAccent;

iui_align_center(); // center label

for (i = 0; i < numTabs; i++)
{
    isHot = false;
    
    tabID    = IDs[i];
    tmpLabel = labels[i];
    tabBoxY  = tabY;
    tabBoxW  = tabW;
    tabBoxH  = tabH;
    
    // Tab label
    tabLabelWid = string_width(tmpLabel);
    if (tabLabelWid > tabW)
    {
        if (tabCurrent != i)
        {
            switch (argument6)
            {
                case 1: // TRIM
                    tmpLabel = iui_strTrim(tmpLabel, tabW);
                    break;
                case 2: // RESIZE
                    tabBoxW = (tabLabelWid + 20); // add padding :>
                    break;
            }
        }
        else
        {
            tabBoxW = (tabLabelWid + 20);
        }
    }
    tabLabel = tmpLabel;
    

    // is hover
    if (point_in_rectangle(iui_inputX, iui_inputY, tabBoxX, tabBoxY, (tabBoxX + tabBoxW), (tabBoxY + tabBoxH)))
    {
        iui_hotItem = tabID;
        isHot = true;
        
        // ... and is clicked
        if (iui_activeItem == -1 && iui_inputDown)
        {
            iui_activeItem = tabID;
            tabCurrent = i;
        }
    }
    isCurrent = (tabCurrent == i);
    
    
    /// Button draw
    // TODO : Make fancy tab style IDK lol
    var colIdx  = (i % iuiColTabNum);
    colBackdrop = iuiColTab[colIdx];
    colAccent   = iuiColTabAccent[colIdx];
    
    if (isCurrent)
    {
        colBackdrop = iuiColTabCurrent;
        colAccent   = iuiColTabCurrentAccent;
        
        tabBoxY -= 5;
        tabBoxH += 5;
    }
    else if (isHot) // Hovering
    {
        colBackdrop = iuiColTabHot;
        colAccent   = iuiColTabHotAccent;
    }
    
    iui_rect(tabBoxX, tabBoxY, tabBoxW, tabBoxH, colBackdrop);
    iui_rect(tabBoxX, tabBoxY, tabBoxW, 5, colAccent);
    iui_rect(tabBoxX, tabBoxY, tabBoxW, 5, colAccent);
    
    // label
    iui_label(tabBoxX + (tabBoxW >> 1), tabBoxY + (tabBoxH >> 1), tabLabel, iuiColTabLabel);
    
    // for next tab
    tabBoxX += tabBoxW;
}

iui_align_pop(); // revert align

return tabCurrent;
