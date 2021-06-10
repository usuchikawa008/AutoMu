#include <MsgBoxConstants.au3>
#include <StringConstants.au3.>
; Retrieve the character position of where the string 'white' first occurs in the sentence.
Local $iPosition = StringInStr("NOX", "Nox",$STR_CASESENSE)
If ($iPosition == 0) Then ConsoleWrite ("sai duong dan")
MsgBox($MB_SYSTEMMODAL, "", "The search string 'white' first appears at position: " & $iPosition)