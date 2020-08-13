///iui_end()
/**
    End IMNOTGUI
**/

if (iui_inputDown)
{
    if (iui_activeItem == -1)
        iui_activeItem = -$DEADBEEF;
}
else
{
    iui_activeItem = -1;
}

iui_keyPress = 0;
iui_keyChar  = "";
