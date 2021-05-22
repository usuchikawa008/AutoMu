#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay.
#include <AutoItConstants.au3>

;~ HotKeySet("{Esc}", "_Exit1") ; Press ESC for exit
;~ Func _Exit1()
;~ 	Exit 0
;~  EndFunc   ;==>_Exit

;~ MsgBox(0, '', $return)
$countDevices = 0;
Global $listcheckbox[5]
; Retrieve a list of window handles.
    Local $aList = WinList("[TITLE:NoxPlayer]")

    ; Loop through the array displaying only visable windows with a title.
    For $i = 1 To $aList[0][0]
        If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) Then
		   $listcheckbox[$countDevices] = $aList[$i][0]
		   $countDevices = $countDevices + 1

	    EndIf
    Next

Gui()

Func Gui()
    ; Create a GUI with various controls.
	$title = "Auto-Mu"
    Local $hGUI = GUICreate($title, 350, 700)
    ; Create a checkbox control.
	If $countDevices == 3  Then ;;case 3 acc
	  $idCheckbox = GUICtrlCreateCheckbox($listcheckbox[0]&"", 10, 0, 150, 35)
	  $idCheckbox1 = GUICtrlCreateCheckbox($listcheckbox[1]&"", 10, 30, 150, 35)
	  $idCheckbox2 = GUICtrlCreateCheckbox($listcheckbox[2]&"", 10, 60, 150, 35)
	   Local $idButton_Close = GUICtrlCreateButton("Close", 210, 670, 85, 25)
	   Local $idButton_Clean = GUICtrlCreateButton("Clean", 100, 670, 85, 25)
	  $textarea = GUICtrlCreateEdit("", 10, 100, 330, 550) ; will not accept drag&drop files
	   ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idButton_Close
                ExitLoop
			 Case $idButton_Clean
				GUICtrlSetData($textarea, "");clear log
            Case $idCheckbox
                If _IsChecked($idCheckbox) Then
				    $filename = GUICtrlRead($idCheckbox,$GUI_READ_EXTENDED) ;get lable checkbox
				    Local $iPID = Run($filename&" "&$filename)
					ConsoleWrite("PID = "&$iPID &@CRLF)
				 Else
				    If ProcessExists($iPID) Then
					   ProcessClose($iPID)
					EndIf
				 EndIf
			Case $idCheckbox1
                If _IsChecked($idCheckbox1) Then
				    $filename = GUICtrlRead($idCheckbox1,$GUI_READ_EXTENDED)
				    Local $iPID1 = Run($filename&" "&$filename)
					ConsoleWrite("PID1 = "&$iPID1 &@CRLF)
                Else
                    If ProcessExists($iPID1) Then
					   ProcessClose($iPID1)
					EndIf
				 EndIf
			Case $idCheckbox2
                If _IsChecked($idCheckbox2) Then
				    $filename = GUICtrlRead($idCheckbox2,$GUI_READ_EXTENDED)
				    Local $iPID2 = Run($filename&" "&$filename)
					ConsoleWrite("PID2 = "&$iPID2 &@CRLF)
                Else
                    If ProcessExists($iPID2) Then
					   ProcessClose($iPID2)
					EndIf
			    EndIf
        EndSwitch
    WEnd
 EndIf

	If $countDevices == 2  Then ;;case 2 acc
	  $idCheckbox = GUICtrlCreateCheckbox($listcheckbox[0]&"", 10, 0, 150, 35)
	  $idCheckbox1 = GUICtrlCreateCheckbox($listcheckbox[1]&"", 10, 30, 150, 35)
	   Local $idButton_Close = GUICtrlCreateButton("Close", 210, 670, 85, 25)
	   Local $idButton_Clean = GUICtrlCreateButton("Clean", 100, 670, 85, 25)
	  $textarea = GUICtrlCreateEdit("", 10, 100, 330, 550) ; will not accept drag&drop files
	   ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idButton_Close
                ExitLoop
			 Case $idButton_Clean
				GUICtrlSetData($textarea, "");clear log
            Case $idCheckbox
                If _IsChecked($idCheckbox) Then
				    ConsoleWrite("checked ne")
				    $filename = GUICtrlRead($idCheckbox,$GUI_READ_EXTENDED) ;get lable checkbox
				    Local $iPID = Run($filename&" "&$filename)
					ConsoleWrite("PID = "&$iPID &@CRLF)
				 Else
					ConsoleWrite("uncheck ne")
					ConsoleWrite($iPID)
                    If ProcessExists($iPID) Then
					   ProcessClose($iPID)
					EndIf
				 EndIf
			Case $idCheckbox1
                If _IsChecked($idCheckbox1) Then
				    $filename = GUICtrlRead($idCheckbox1,$GUI_READ_EXTENDED)
				    Local $iPID1 = Run($filename&" "&$filename)
					ConsoleWrite("PID1 = "&$iPID1 &@CRLF)
				 Else
					ConsoleWrite("uncheck ne")
					ConsoleWrite($iPID1)
                    If ProcessExists($iPID1) Then
					   ProcessClose($iPID1)
					EndIf
				 EndIf
        EndSwitch
    WEnd
 EndIf
 If $countDevices == 1  Then ;;case 3 acc
	  $idCheckbox = GUICtrlCreateCheckbox($listcheckbox[0]&"", 10, 0, 150, 35)
	   Local $idButton_Close = GUICtrlCreateButton("Close", 210, 670, 85, 25)
	   Local $idButton_Clean = GUICtrlCreateButton("Clean", 100, 670, 85, 25)
	  $textarea = GUICtrlCreateEdit("", 10, 100, 330, 550) ; will not accept drag&drop files
	   ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idButton_Close
                ExitLoop
			 Case $idButton_Clean
				GUICtrlSetData($textarea, "");clear log
            Case $idCheckbox
                If _IsChecked($idCheckbox) Then
				    $filename = GUICtrlRead($idCheckbox,$GUI_READ_EXTENDED) ;get lable checkbox
				    Local $iPID = Run($filename&" "&$filename)
					ConsoleWrite("PID = "&$iPID &@CRLF)
                Else
                    If ProcessExists($iPID) Then
					   ProcessClose($iPID)
					EndIf
				 EndIf
        EndSwitch
    WEnd
 EndIf
    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>Example

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked