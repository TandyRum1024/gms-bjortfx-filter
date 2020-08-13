#define iui_asciiShift
///iui_asciiShift(asciiCode)
/**
    Converts smöll ascii chars to shift-pressed one.
    
    Usage : asciiShift( ord('a') ) => returns 65 ('A' in ascii)
            asciiShift( ord('1') ) => returns 33 ('!' in ascii)
**/

var shiftChar = argument0;

/// check shift-able range
/**
    33 ~ 128 : Printable chars
    =========== 33 ~ 43 expect 39 ['] is un-SHIFTable ====================
    33 ~ 38 : [!, ", #, $, %, &], Already SHIFTed
    39 : ['], Can be SHIFTed!
    40 ~ 43 : [(, ), *, +] same as 33 ~ 38
    
    =========== 58 ~ 90 expect 59, 61 [;, =] is un-SHIFTable =============
    58, 60 : [:, <], you can't shift these, Y'see?
    59, 61 : [;, =], Can be SHIFTed!
    62 ~ 90 : [>, ?, @, uppercase alphabets], Can't SHIFT!
    
    
    94, 95 : [^, _], Already SHIFTed
    123 ~ 126 : [{, |, }, ~], Same
**/
// rangecheck :D
if ((argument0 <= 43 && argument0 != 39) || 
    (argument0 >= 58 && argument0 <= 90 && argument0 != 59 && argument0 != 61) ||
    (argument0 >= 123 && argument0 <= 126) ||
    (argument0 == 94 || argument0 == 95) ||
    argument0 >= 127)
    return argument0;
    
    
/// shift
// smoll alphabetz
if (argument0 >= 97 && argument0 <= 122)
{
    // Fun fact : Alphabets and some characters shift version is just its character code subtracted by 32
    // EX ] 'a' (97) -> 'A' (65)
            
    // See? Just subtract 32 and you get SHIFTED version.
    shiftChar -= 32;
}

// [, \, ]
if (argument0 >= 91 && argument0 <= 93)
{
    // But sometimes it's all swanky :<
    shiftChar += 32;
}

// ; (59) -> : (58)
if (argument0 == 59)
    shiftChar = 58;
    
// = (61) -> + (43)
if (argument0 == 61)
    shiftChar = 43;
    
// / (47) -> ? (63)
if (argument0 == 47)
    shiftChar = 63;

// , . (44, 46) -> < > (60, 62)
// they both add 16 for getting SHIFT version (like the alphabets above)
if (argument0 == 44 || argument0 == 46)
    shiftChar += 16;
    
// ` (96) -> ~ (126)
if (argument0 == 96)
    shiftChar = 126;
    
// - (45) -> _ (95)
if (argument0 == 45)
    shiftChar = 95;

// ' (39) -> " (34)
if (argument0 == 39)
    shiftChar = 34;

// numbers
if (argument0 >= 48 && argument0 <= 57)
{
    switch (argument0-48)
    {
        case 0:
            shiftChar = 41; //ord(')');
            break;
        case 1:
            shiftChar = 33;//ord('!');
            break;
        case 2:
            shiftChar = 64;//ord('@');
            break;
        case 3:
            shiftChar = 35;//ord('#');
            break;
        case 4:
            shiftChar = 36;//ord('$');
            break;
        case 5:
            shiftChar = 37;//ord('%');
            break;
        case 6:
            shiftChar = 94;//ord('^');
            break;
        case 7:
            shiftChar = 38;//ord('&');
            break;
        case 8:
            shiftChar = 42;//ord('*');
            break;
        case 9:
            shiftChar = 40;//ord('(');
            break;
    }
}


return shiftChar;

#define asciiUnShift
///iui_asciiUnShift(asciiCode)
/**
    Converts shift-pressed ascii chars to smöll one.
    
    Usage : asciiShift( ord('A') ) => returns 97 ('a' in ascii)
            asciiShift( ord('!') ) => returns 49 ('1' in ascii)
**/

var shiftChar = argument0;

/// check shift-able range
/**
    33 ~ 128 : Printable chars
    =========== 33 ~ 43 expect 39 ['] is un-SHIFTable ====================
    33 ~ 38 : [!, ", #, $, %, &], Already SHIFTed
    39 : ['], Can be SHIFTed!
    40 ~ 43 : [(, ), *, +] same as 33 ~ 38
    
    =========== 58 ~ 90 expect 59, 61 [;, =] is un-SHIFTable =============
    58, 60 : [:, <], you can't shift these, Y'see?
    59, 61 : [;, =], Can be SHIFTed!
    62 ~ 90 : [>, ?, @, uppercase alphabets], Can't SHIFT!
    
    
    94, 95 : [^, _], Already SHIFTed
    123 ~ 126 : [{, |, }, ~], Same
**/
// rangecheck :D
if (!((argument0 <= 43 && argument0 != 39) || 
    (argument0 >= 58 && argument0 <= 90 && argument0 != 59 && argument0 != 61) ||
    (argument0 >= 123 && argument0 <= 126) ||
    (argument0 == 94 || argument0 == 95) ||
    argument0 >= 127))
    return argument0;
    
    
/// shift
// bigge alphabetz
if (argument0 >= 65 && argument0 <= 90)
    shiftChar += 32;

// {, |, }
if (argument0 >= 123 && argument0 <= 125)
    shiftChar -= 32;

// ; (59) <- : (58)
if (argument0 == 58)
    shiftChar = 59;
    
// = (61) <- + (43)
if (argument0 == 43)
    shiftChar = 61;
    
// / (47) <- ? (63)
if (argument0 == 63)
    shiftChar = 47;

// , . (44, 46) <- < > (60, 62)
// they both subtract 16 for getting UN-SHIFT version (like the alphabets above)
if (argument0 == 60 || argument0 == 62)
    shiftChar -= 16;
    
// ` (96) <- ~ (126)
if (argument0 == 126)
    shiftChar = 96;
    
// - (45) <- _ (95)
if (argument0 == 95)
    shiftChar = 45;

// ' (39) <- " (34)
if (argument0 == 34)
    shiftChar = 39;

// symbols -> numbers
if (argument0 == 41) shiftChar = 48;
if (argument0 == 33) shiftChar = 49;
if (argument0 == 64) shiftChar = 50;
if (argument0 == 35) shiftChar = 51;
if (argument0 == 36) shiftChar = 52;
if (argument0 == 37) shiftChar = 53;
if (argument0 == 94) shiftChar = 54;
if (argument0 == 38) shiftChar = 55;
if (argument0 == 42) shiftChar = 56;
if (argument0 == 40) shiftChar = 57;

return shiftChar;