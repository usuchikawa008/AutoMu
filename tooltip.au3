#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <GUIToolTip.au3>

Opt('MustDeclareVars', 1)

Global Const $LPSTR_TEXTCALLBACK = -1
Global $hMainWin, $iID_ListView, $iID_ListView_hHeader, $hToolTip

_Main()

Func _Main()
    createGUI()

    GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

    While (1)
        Local $msg = GUIGetMsg()
        Select
            Case $msg = $GUI_EVENT_CLOSE
                Exit
        EndSelect
        Sleep(125)
    WEnd
EndFunc   ;==>_Main

Func WM_NOTIFY($hWnd, $IMsg, $iwParam, $ilParam)
    #forceref $hWnd, $IMsg, $iwParam
    Local $hwndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo,  $gText, $aPos

    $hWndListView = $iID_ListView
    If Not IsHWnd($iID_ListView) Then $hWndListView = GUICtrlGetHandle($iID_ListView)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hwndFrom = HWnd(DllStructGetData($tNMHDR, "hwndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "idFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    ; Get the rect of the Listview
    $aPos = _GUICtrl_GetMessagePos($iIDFrom)

    Switch $hwndFrom
        Case $hWndListView
            Switch $iCode
                Case $LVN_HOTTRACK; Sent by a list-view control When the user moves the mouse over an item
                    $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
                    $gText = _GUICtrlListView_GetItemText($hwndFrom, DllStructGetData($tInfo, "Index"), 0)
                    ToolTip($gText)
                    ; Return 0; Allow the ListView to perform its normal track select processing.
                    Return 1; the item will not be selected.
                    ; No returnValue
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

; e.g.:
;      _GUIToolTip_AddToolMod($hToolTip, $hMainWin, $LPSTR_TEXTCALLBACK, _
;      $iID_ListView_hHeader, _
;      0, 0, 0, 0, BitOR(1, 8), $iID_ListView_hHeader)

Func _GUIToolTip_AddToolMod($hTool, $hWnd, $sText, $iID = 0, $iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0, $iFlags = 8, $iParam = 0)
    Local $tToolInfo = DllStructCreate($tagTOOLINFO)
    Local $pToolInfo = DllStructGetPtr($tToolInfo)
    Local $iToolInfo = DllStructGetSize($tToolInfo)
    DllStructSetData($tToolInfo, "Size", $iToolInfo)
    DllStructSetData($tToolInfo, "Flags", _GUIToolTip_BitsToTTF($iFlags))
    DllStructSetData($tToolInfo, "hWnd", $hWnd)
    DllStructSetData($tToolInfo, "ID", $iID)
    DllStructSetData($tToolInfo, "Left", $iLeft)
    DllStructSetData($tToolInfo, "Top", $iTop)
    DllStructSetData($tToolInfo, "Right", $iRight)
    DllStructSetData($tToolInfo, "Bottom", $iBottom)
    DllStructSetData($tToolInfo, "Param", $iParam)

    Local $iRet = 0
    If IsString($sText) Then
        Local $iBuffer = StringLen($sText) + 1
        Local $tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
        $iBuffer *= 2
        Local $pBuffer = DllStructGetPtr($tBuffer)
        DllStructSetData($tBuffer, "Text", $sText)
        DllStructSetData($tToolInfo, "Text", $pBuffer)
        $iRet = _SendMessage($hTool, $TTM_ADDTOOLW, 0, $pToolInfo, 0, "wparam", "ptr")
    Else
        DllStructSetData($tToolInfo, "Text", $sText)
        $iRet = _SendMessage($hTool, $TTM_ADDTOOLW, 0, $pToolInfo, 0, "wparam", "ptr")
    EndIf
    Return $iRet <> 0
EndFunc   ;==>_GUIToolTip_AddToolMod

Func _GUICtrl_GetMessagePos($control)
    Local $p = DllCall("user32.dll", "DWORD", "GetMessagePos")
    Local $pt = DllStructCreate($tagPOINT)
    DllStructSetData($pt, "X", _WinAPI_LoWord($p[0]))
    DllStructSetData($pt, "Y", _WinAPI_HiWord($p[0]))
    _WinAPI_ScreenToClient(_GUICtrl_GetHandle($control), $pt)
    Local $result[2] = [DllStructGetData($pt, "X"), DllStructGetData($pt, "Y")]
    Return $result
EndFunc   ;==>_GUICtrl_GetMessagePos

Func _GUICtrl_GetHandle($control)
    If IsHWnd($control) Then Return $control
    Return GUICtrlGetHandle($control)
EndFunc   ;==>_GUICtrl_GetHandle


Func createGUI()
    Local $flags, $flagsEX, $w, $h, $str

    $w = 250
    $h = 200
    $flags = BitOR($WS_CAPTION, $WS_VISIBLE)

    $hMainWin = GUICreate("ToolTip test", 250, 200, -1, -1, $flags)

    $flags = $WS_VISIBLE
    $flagsEX = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_INFOTIP)

    $iID_ListView = GUICtrlCreateListView("Column 0|Column 1|Column 2", 10, 10, $w - 15, $h - 25, $flags, $flagsEX)

    For $i = 0 To 5
        $str = StringFormat("Item %s|abc%s|def%s", $i, $i, $i)
        GUICtrlCreateListViewItem($str, $iID_ListView)
    Next

    $iID_ListView_hHeader = _GUICtrlListView_GetHeader($iID_ListView)
    $hToolTip = _GUIToolTip_Create($hMainWin)

    _GUIToolTip_AddToolMod($hToolTip, $hMainWin, $LPSTR_TEXTCALLBACK, _
            $iID_ListView_hHeader, 0, 0, 0, 0, BitOR(1, 8), $iID_ListView_hHeader)

EndFunc   ;==>createGUI