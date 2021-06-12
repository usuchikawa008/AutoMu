#include <Date.au3>
Func _getCurrentDate()
  Local $Date = _TimeFromNTP("pool.ntp.org")
  Local $Dateconvert = StringSplit($Date,' ',$STR_ENTIRESPLIT)[1] ;get script name : example Noxplayer
  Return $Dateconvert
EndFunc


Func _getDayofWeek()
  ; Retrieve the long name
  Local $sLongDayName = _DateDayOfWeek(@WDAY)
  Return $sLongDayName
EndFunc
;~  msgbox(0, '' , _getDayofWeek())
Func _TimeFromNTP($sNTPServer)
    Local $sData = ""
    TCPStartup()
    If TCPNameToIP($sNTPServer) = "" Then Return SetError(1)
    UDPStartup()
    $aSocket = UDPOpen(TCPNameToIP($sNTPServer), 123)
    $sStatus = UDPSend($aSocket, _MakePacket())
    While $sData = ""
        $sData = UDPRecv($aSocket, 100)
        Sleep(250)
    WEnd
    UDPCloseSocket($aSocket)
    TCPShutdown()


    $sValue = _UnsignedHexToDecimal(StringMid($sData, 83, 8))
    $aTimeZone = _Date_Time_GetTimeZoneInformation()

      If $aTimeZone[0] <> 2 Then
        $iTimeZoneOffset = ($aTimeZone[1]) * -1
    Else
        $iTimeZoneOffset = ($aTimeZone[1] + $aTimeZone[7]) * -1
    EndIf

    $sUTC = _DateAdd("s", $sValue, "1900/01/01 00:00:00")

    $sUTC = _DateAdd("n", $iTimeZoneOffset, $sUTC)

    Local $iMonth = StringMid($sUTC, 6, 2), $iDay = StringMid($sUTC, 9, 2), $iYear = StringMid($sUTC, 1, 4), _
    $iHour = StringMid($sUTC, 12, 2), $iMinute = StringMid($sUTC, 15, 2), $iSecond = StringMid($sUTC, 18, 2)

;~     $sOut = $iMonth & "/" & $iDay & "/" & $iYear & " " & $iHour & ":" & $iMinute & ":" & $iSecond
    $sOut = $iYear & "/" & $iMonth & "/" & $iDay & " " & $iHour & ":" & $iMinute & ":" & $iSecond
    return $sOut

EndFunc

Func _MakePacket()
    Local $x, $sPacket = "1b0e01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    While $sPacket
        $x &= Chr(Dec(StringLeft($sPacket, 2)))
        $sPacket = StringTrimLeft($sPacket, 2)
    WEnd
    Return $x
EndFunc

Func _UnsignedHexToDecimal($sInput)
    $x = StringRight($sInput, 1)
    $sInput = StringTrimRight($sInput, 1)
    Return Dec($sInput) * 16 + Dec($x)
EndFunc