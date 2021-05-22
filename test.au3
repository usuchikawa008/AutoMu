

#Include <WinAPI.au3>

ConsoleWrite(_FileIsUses('C:\Users\Admin\Desktop\AutoIT\AutoMuDev\auto\NoxPlayer.tmp') & @CR)

Func _FileIsUses($sFile)

    Local $hFile = _WinAPI_CreateFile($sFile, 2, 2, 0)

    If $hFile Then
        _WinAPI_CloseHandle($hFile)
        Return 0
    EndIf

    Local $Error = _WinAPI_GetLastError()

    Switch $Error
        Case 32 ; ERROR_SHARING_VIOLATION
            Return 1
        Case Else
            Return SetError($Error, 0, 0)
    EndSwitch
EndFunc   ;==>_FileIsUses