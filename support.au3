#include <AutoItConstants.au3>
#include <imageSearchEX.au3>
#include <HandleImgSearch.au3>
#include "_IMGSearch_Debug.au3"
#include <Date.au3>
#include <Array.au3>
#include <DateTime.au3>
AutoItSetOption ("TrayIconDebug", 1);0-off
Func _Exit()
	Exit 0
 EndFunc   ;==>_Exit

 ;config start
If $CmdLine[0] == 0 Then
   Global Const $Title =  "NoxPlayer(1)"
Else
   Global Const $Title =  $CmdLine[1]
EndIf
;~ Global $Title =  "NoxPlayer"
;~ Global $Title =  "NoxPlayer(1)"
;~ Global $Title =  "NoxPlayer(1)(1)"
Sleep(200)
;dir config file
Global Const $path = @ScriptDir&"\config\"
;config auto Run
Global Const $run = "Run"
Global Const $finish = "Finish"
Global Const $statusNox = "StatusNox"
Global Const $onl = "Onl"
Global Const $off = "Off"
Global Const $cmdStart = "cmdStart"
;config hoat dong End


;~ Global $Nox_Path = "D:\Program Files\Nox\bin"
$Nox_PathFull = _WinGetPath("NoxPlayer") ;get path cua Nox
Global $Nox_Path = StringLeft(StringSplit($Nox_PathFull,'.')[1],StringLen(StringSplit($Nox_PathFull,'.')[1])-4)
Func _WinGetPath($Title="", $strComputer='localhost')
    $win = WinGetTitle($Title)
    $pid = WinGetProcess($win)
   $wbemFlagReturnImmediately = 0x10
   $wbemFlagForwardOnly = 0x20
   $colItems = ""
   $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
   $colItems = $objWMIService.ExecQuery ("SELECT * FROM Win32_Process WHERE ProcessId = " & $pid, "WQL", _
         $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
   If IsObj($colItems) Then
      For $objItem In $colItems
         If $objItem.ExecutablePath Then Return $objItem.ExecutablePath
      Next
   EndIf
EndFunc

;config end
Local $statusNoxx = IniRead($path&$Title&".tmp", $run, $statusNox, $onl)
If $statusNoxx == $off Then
   ConsoleWrite("NOX OFF")
   Local $cmd = IniRead($path&$Title&".tmp", $run, $cmdStart, "")
   If $cmd <> ""  Then
   _ADB_Command($cmd); start auto
   Sleep(5000)
   EndIf
Else
   ConsoleWrite("NOX ON")
EndIf


Opt("WinTitleMatchMode", 3)
WinMove($Title, "",Default ,Default , 849, 509)

 Func _ADB_Command($Command, $WorkingDir = @ScriptDir)
    $DOS = Run($Nox_Path & "\" & $Command, $Nox_Path, @SW_HIDE, $STDERR_MERGED)
    $Message = StdoutRead($DOS)
    Return $Message
 EndFunc   ;==>_ADB_Command
