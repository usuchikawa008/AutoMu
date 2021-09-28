#include <Array.au3>
#include "HandleImgSearch.au3"
Local $sAnswer = InputBox("Input Name", ""& @LF & "", "", "",- 1, -1, 0, 0)
   If @error = 1 Then ; cancel -> tat Auto
	  Exit 0
   EndIf
If $sAnswer == "" Then ; ko nhap ji thi xai ban thu nghiem
	  Exit 0
EndIf

$Title = $sAnswer
;~ $Title = "NoxPlayer(1)"
;~ $Title2 = "NoxPlayer(2)"
$_HandleImgSearch_IsDebug = True
$scale = 1
Global $Handle = ""
Local $aList = WinList("[TITLE:"&$Title&"]")
_ArrayDisplay($aList)
;~   _ArrayDisplay($aList)
    ; Loop through the array displaying only visable windows with a title.
    For $i = 1 To $aList[0][0]
        If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) Then
		   if ($aList[$i][0] == $Title ) Then
;~             MsgBox($MB_SYSTEMMODAL, "", "Title: " & $aList[$i][0] & @CRLF & "Handle: " & $aList[$i][1])
			$Handle = $aList[$i][1]
			EndIf
        EndIf
	 Next
Local $BMP = _HandleCapture($Handle, 0, 0, -1, -1, true)