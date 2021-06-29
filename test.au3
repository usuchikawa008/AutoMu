#include <AutoItConstants.au3> ; Required for _ArrayDisplay.
#include <WinAPI.au3>
;~ WinActivate("LDPlayer-2")
Opt("WinTitleMatchMode", 3)
;~ ControlSend("NoxPlayer","","","Hồ Ngọc hà")
;~ $Title = "LDPlayer-1"
;~ Opt("WinTitleMatchMode", 3)
;~ WinMove($Title, "",Default ,Default , 849, 512) ;resize auto
Global Const $pathDapan = @ScriptDir&"\image\dapan.ini"
Local $read = IniRead($pathDapan, "Answer", "songbenhaivasong", ""); doc
ConsoleWrite($read)
$out = _WinAPI_WideCharToMultiByte($read, 65001)
Opt("WinTitleMatchMode", 3)
ControlSend("NoxPlayer","","",_ANSIToUnicode($read))


Func _ANSIToUnicode($sString)
    #cs
        Local Const $SF_ANSI = 1
        Local Const $SF_UTF16_LE = 2
        Local Const $SF_UTF16_BE = 3
        Local Const $SF_UTF8 = 4
    #ce
    Local Const $SF_ANSI = 1, $SF_UTF8 = 4
    Return BinaryToString(StringToBinary($sString, $SF_ANSI), $SF_UTF8)
 EndFunc   ;==>_ANSIToUnicode


 Func _UnicodeToANSI($sString)
    #cs
        Local Const $SF_ANSI = 1
        Local Const $SF_UTF16_LE = 2
        Local Const $SF_UTF16_BE = 3
        Local Const $SF_UTF8 = 4
    #ce
    Local Const $SF_ANSI = 1, $SF_UTF8 = 4
    Return BinaryToString(StringToBinary($sString, $SF_UTF8), $SF_ANSI)
EndFunc   ;==>_UnicodeToANSI