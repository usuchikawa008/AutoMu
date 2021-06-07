
$Nox_PathFull = _WinGetPath("NoxPlayer") ;get path cua Nox
ConsoleWrite($Nox_PathFull & @CRLF)
Global $Nox_Path = StringLeft(StringSplit($Nox_PathFull,'.')[1],StringLen(StringSplit($Nox_PathFull,'.')[1])-4)

ConsoleWrite($Nox_Path)
MsgBox(0,"",$Nox_Path)

Func _WinGetPath($Title="", $strComputer='localhost')
    $win = WinGetTitle($Title)
   Local $pid = WinGetProcess($win)
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