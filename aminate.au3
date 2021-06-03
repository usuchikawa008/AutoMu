#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include "GIFAnimation.au3"
#include <GuiButton.au3>

Global $sFileBin = '0xF0B200474946383961150000200083000000FFFF00734A00DC9200FFD4408E96620050320080FF000062966E6E6E00003096A0A0A40088090021FF000B4E4554534341504045322E3003010124FE000928432946756D6942650018F904090E00282C03015801C64304AD10C8090082A5180763CEF89B0011480551144091AC0049300485228F9916001CF48DD7DAEBD3BC00CAEBC0319C4EA0DA00B170C0E980C1A744001A9C0AAE5768559800DC563A9C90C805CB0014C809C429CC53A50057B06653CBBB8DA800552A3E1390CDA67E00747C588275571F0200857C1F8C8A14176400155A268F1D162F4500164B8F43451C675D003D30276A05638227002D2F09A66C4A2C0800644C73416E2BB372008E137615B45EBCBD003B79BE7B357ABE75001617C18ACACA53CE14191182600A89600304AC0010C849ABBD2068CC0083F80167791F285200E43008E12905032C00BBAF6AB734ACE2E700366F14420165301C006EC55641389C048C009A58D1A029589B4E0063721A0D609DB1C300B458D0F1C00131F900BABBC8AE082B15680029C712F14292634D00C8127A7B17050985007E31050A8A6713840085086F07928C128E0008855E92937C8680009A9B7C579369079400151AA519A01D9A2100A4A64EA0AF3DB2AB0018B3AAA922B8B8AC00BABD6E1A40AFA601008A8B2FC70A94C2C2282FCD671260A91F60A28000C170B80D79848AF000A0890D0DA110A1500040118F4FA88C5AAD00050ED9A72ED09DC800C059EE6E14E322B800050D4F9288C7126F00AE015348F865750500477C7E7F77050A0A0073137D7E08800507004C84787F54929317008D859198999A7092001AA22EA351A4419800A79F185F99AE8B4A00A8B03DB3A81DB6AC0017B419B7BB722DB000B1198989C1C58ABF30C02FC0737F2F6A2F9B64114B2F096475812F859293008B128D8505939F9A009B70995F943D5F5100993DA019AA41AEA500A166B0AE1DB4A6B600A6B1ABBAB517724000B1A10189892DC4C5E09AC0C1CB157F2FFF5EFF5E3FBF17BF17BF177F2F7F2F6B2F3B'
Global $sFileBin1 = Binary(_LzntDecompress($sFileBin))



$hGUI = GUICreate("GUI", 700, 300, Default, Default, $WS_POPUP, BitOr($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))

$hPic = GUICtrlCreatePic(@ScriptDir & "\tech.gif",50,50,600,200,$WS_CLIPSIBLINGS)
_GUICtrlSetGIF($hPic, @ScriptDir & "\tech.gif")
GUISetState()
GUISetControlsVisible($hGUI)

$hGUI = GUICreate("GUI", 700, 300, Default, Default, $WS_POPUP, BitOr($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST), $hGUI)

;~ Global $hGIF = _GUICtrlCreateGIF(@ScriptDir & "\tech.gif", "",50,50,600,200)
;~ GUICtrlSetPos($hGIF, 0, 0)
$cExit = GUICtrlCreateButton(" Exit ", 10, 10, 80, 30)


Global $buttoncx = GUICtrlCreateButton ("caixa", 65,65 , 110, 170, $BS_BITMAP)
GUICtrlSetImage ($buttoncx, @ScriptDir & "\Dados\Imagens\caixa.bmp")
GUICtrlSetTip(-1, "Conectar em PDV.")
;GUICtrlSetOnEvent(-1, "caixa")

;botão 2 atm
Global $buttonatm = GUICtrlCreateButton ("atm", 195, 65, 110, 170, $BS_BITMAP)
GUICtrlSetImage ($buttonatm, @ScriptDir & "\Dados\Imagens\atm.bmp")
GUICtrlSetTip(-1, "Conectar em ATM/CONECTA.")
;GUICtrlSetOnEvent(-1, "atm")

;botão 3 mobile
Global $buttonmbl = GUICtrlCreateButton ("mobile", 325, 65, 110, 170, $BS_BITMAP)
GUICtrlSetImage ($buttonmbl, @ScriptDir & "\Dados\Imagens\mobile.bmp")
GUICtrlSetTip(-1, "Conectar em MOBILE SERVER.")
;GUICtrlSetOnEvent(-1, "mobile")

; Must be within GUI window
;$cLabel = GUICtrlCreateLabel("", 600, 200, 100, 100)

GUISetControlsVisible($hGUI)

    ; _GUICtrlCreateGIF($sFileBin1, "", 5, 5, 35, 35)
    ; _GUICtrlCreateGIF($sFileBin1, "", 80, 80, 55, 55)
    ;_GUICtrlCreateGIF($sFileBin1, "", 90, 170, 155, 155)
    ;GUICtrlSetTip(-1, "ESC to exit")


GUISetState()


;~ GUIRegisterMsg($WM_MOVE, "_WM_MOVE")

While 1

;~     _ImageHover()

;If GUICtrlRead($Final) <> $OldInput Then

;$OldInput = GUICtrlRead($Final)

;_DestUpdate()

;Endif

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $cExit
            Exit
    EndSwitch

WEnd

Func GUISetControlsVisible($hWnd)
    Local $aM_Mask, $aCtrlPos, $aMask

    $aM_Mask = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", 0, "long", 0, "long", 0, "long", 0)
    $aLastID = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", GUICtrlGetHandle(-1))

    For $i = 3 To $aLastID[0]
        $aCtrlPos = ControlGetPos($hWnd, '', $i)
        If Not IsArray($aCtrlPos) Then ContinueLoop

        $aMask = DllCall("gdi32.dll", "long", "CreateRectRgn", _
            "long", $aCtrlPos[0], _
            "long", $aCtrlPos[1], _
            "long", $aCtrlPos[0] + $aCtrlPos[2], _
            "long", $aCtrlPos[1] + $aCtrlPos[3])
        DllCall("gdi32.dll", "long", "CombineRgn", "long", $aM_Mask[0], "long", $aMask[0], "long", $aM_Mask[0], "int", 2)
    Next
    DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $hWnd, "long", $aM_Mask[0], "int", 1)
EndFunc

Func _LzntDecompress($bBinary); by trancexx
    $bBinary = Binary($bBinary)
    Local $tInput = DllStructCreate('byte[' & BinaryLen($bBinary) & ']')
    DllStructSetData($tInput, 1, $bBinary)
    Local $tBuffer = DllStructCreate('byte[' & 16 * DllStructGetSize($tInput) & ']')
    Local $a_Call = DllCall('ntdll.dll', 'int', 'RtlDecompressBuffer', 'ushort', 2, 'ptr', DllStructGetPtr($tBuffer), 'dword', DllStructGetSize($tBuffer), 'ptr', DllStructGetPtr($tInput), 'dword', DllStructGetSize($tInput), 'dword*', 0)
    If @error Or $a_Call[0] Then Return SetError(1, 0, '')
    Local $tOutput = DllStructCreate('byte[' & $a_Call[6] & ']', DllStructGetPtr($tBuffer))
    Return SetError(0, 0, DllStructGetData($tOutput, 1))
EndFunc   ;==>_LzntDecompress

Func _ImageHover()

     Global $aCursor = GUIGetCursorInfo($hGUI)

_ImageChange($buttoncx, @ScriptDir & "\Dados\Imagens\caixa2.bmp", @ScriptDir & "\Dados\Imagens\caixa1.bmp", $aCursor)

_ImageChange($buttonatm, @ScriptDir & "\Dados\Imagens\atm2.bmp", @ScriptDir & "\Dados\Imagens\atm1.bmp", $aCursor)

_ImageChange($buttonmbl, @ScriptDir & "\Dados\Imagens\mobile2.bmp", @ScriptDir & "\Dados\Imagens\mobile1.bmp", $aCursor)

;_ImageChange($buttonconnect, @ScriptDir & "\Dados\Imagens\connect2.bmp", @ScriptDir & "\Dados\Imagens\connect.bmp", $aCursor)

EndFunc


Func _ImageChange($iCtrl, $iIMG_1, $i_IMG2, ByRef $aCursor)


If $aCursor = 0 Then

Else
    If ($aCursor[4] = $iCtrl) Then
        GUICtrlSetImage($iCtrl, $iIMG_1)
    ElseIf ($aCursor[4] <> $iCtrl) Then
        GUICtrlSetImage($iCtrl, $i_IMG2)
    EndIf
EndIf
EndFunc