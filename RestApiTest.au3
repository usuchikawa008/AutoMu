;~ post_authentication_test()
;~ put_authentication_test()
#include "Json.au3"
;~ Global $jsonString = get_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account?Code=B8RV0B2D5W",'')
;~ Local $Obj = Json_Decode($jsonString)
;~ ConsoleWrite(Json_Get_Data($Obj, '[0]["Code"]') & @LF)
;~ Exit

Func Json_Get_Data($Var, $Key)
    If Not $Key Then Return $Var
    Local $Match = StringRegExp($Key, "(^\[([^\]]+)\])", 3)
    If IsArray($Match) Then
        Local $Index = Json_Decode($Match[1])
        $Key = StringTrimLeft($Key, StringLen($Match[0]))

        If IsString($Index) And Json_IsObject($Var) And Json_ObjExists($Var, $Index) Then
            Local $Ret = Json_Get(Json_ObjGet($Var, $Index), $Key)
            Return SetError(@Error, 0, $Ret)

        ElseIf IsNumber($Index) And IsArray($Var) And $Index >= 0 And $Index < UBound($Var) Then
            Local $Ret = Json_Get($Var[$Index], $Key)
            Return SetError(@Error, 0, $Ret)

        Else
            Return SetError(1, 0, "")
        EndIf
    EndIf

    Return SetError(2, 0, "")
EndFunc
Func post_authentication_test($RestUrl,$requestBody)
    Local $oHttp   = Null, _
          $oComErr = Null

    Local $iHttpStatus = 0

    Local $sResponse = "", _
          $sPostData = ""


    ConsoleWrite(@CRLF & "Executing API" & @CRLF)

    ;Set COM error handler
    $oComErr = ObjEvent("AutoIT.Error", "com_error_handler")

    ;Create a HTTP COM object
    $oHttp = ObjCreate("winhttp.winhttprequest.5.1")
    If @error Then
        ConsoleWrite("Unable to create http request object." & @CRLF)
        Exit -1
    EndIf
    ConsoleWrite("WinHttpRequest object created." & @CRLF)

    With $oHttp
        ;Open POST request
        .Open("POST", $RestUrl, False)
;~ 		.Open("POST", "https://60bf0f79320dac0017be452f.mockapi.io/Account", False)

        ;Set request headers and options
        .SetRequestHeader("Content-Type", "application/json")

        ;Send request
        .Send($requestBody)
;~ 		.Send('{"Code":"123","Mac":"AUTOIT_TEST"}')
        If @error Then
            ConsoleWrite(StringFormat("SEND ERROR: (0x%X) %s", $oComErr.Number, $oComErr.Description) & @CRLF)
            Return
        EndIf

        ;Get status code and response
        $iHttpStatus = .Status
        $sResponse   = .ResponseText

        ;If status code isn't okay
        If $iHttpStatus <> 200 Then
            ConsoleWrite("HTTP Status  : " & String($iHttpStatus) & @CRLF)
            ConsoleWrite("HTTP Response: " & @CRLF & $sResponse & @CRLF)
            Return
        EndIf
    EndWith

;~     ConsoleWrite("API Response:" & @CRLF & $sResponse & @CRLF)
	Return $sResponse
EndFunc
Func put_authentication_test($RestUrl = "", $requestBody = "")
    Local $oHttp   = Null, _
          $oComErr = Null

    Local $iHttpStatus = 0

    Local $sResponse = "", _
          $sPostData = ""


    ConsoleWrite(@CRLF & "Executing API" & @CRLF)

    ;Set COM error handler
    $oComErr = ObjEvent("AutoIT.Error", "com_error_handler")

    ;Create a HTTP COM object
    $oHttp = ObjCreate("winhttp.winhttprequest.5.1")
    If @error Then
        ConsoleWrite("Unable to create http request object." & @CRLF)
        Exit -1
    EndIf
    ConsoleWrite("WinHttpRequest object created." & @CRLF)

    With $oHttp
        ;Open POST request
        .Open("Put", $RestUrl, False)

        ;Set request headers and options
        .SetRequestHeader("Content-Type", "application/json")

        ;Send request
        .Send($requestBody)
        If @error Then
            ConsoleWrite(StringFormat("SEND ERROR: (0x%X) %s", $oComErr.Number, $oComErr.Description) & @CRLF)
            Return
        EndIf

        ;Get status code and response
        $iHttpStatus = .Status
        $sResponse   = .ResponseText

        ;If status code isn't okay
        If $iHttpStatus <> 200 Then
            ConsoleWrite("HTTP Status  : " & String($iHttpStatus) & @CRLF)
            ConsoleWrite("HTTP Response: " & @CRLF & $sResponse & @CRLF)
            Return
        EndIf
    EndWith

    ConsoleWrite("API Response:" & @CRLF & $sResponse & @CRLF)
	Return $sResponse
 EndFunc

Func get_authentication_test($RestUrl,$requestBody)
    Local $oHttp   = Null, _
          $oComErr = Null

    Local $iHttpStatus = 0

    Local $sResponse = "", _
          $sPostData = ""


    ConsoleWrite(@CRLF & "Executing API" & @CRLF)

    ;Set COM error handler
    $oComErr = ObjEvent("AutoIT.Error", "com_error_handler")

    ;Create a HTTP COM object
    $oHttp = ObjCreate("winhttp.winhttprequest.5.1")
    If @error Then
        ConsoleWrite("Unable to create http request object." & @CRLF)
        Exit -1
    EndIf
    ConsoleWrite("WinHttpRequest object created." & @CRLF)

    With $oHttp
        ;Open POST request
        .Open("get", $RestUrl, False)
;~ 		.Open("get", "https://60bf0f79320dac0017be452f.mockapi.io/Account?Code=B8RV0B2D5W", False)

        ;Set request headers and options
        .SetRequestHeader("Content-Type", "application/json")

        ;Send request
        .Send($requestBody)
        If @error Then
            ConsoleWrite(StringFormat("SEND ERROR: (0x%X) %s", $oComErr.Number, $oComErr.Description) & @CRLF)
            Return
        EndIf

        ;Get status code and response
        $iHttpStatus = .Status
        $sResponse   = .ResponseText

        ;If status code isn't okay
        If $iHttpStatus <> 200 Then
            ConsoleWrite("HTTP Status  : " & String($iHttpStatus) & @CRLF)
            ConsoleWrite("HTTP Response: " & @CRLF & $sResponse & @CRLF)
            Return
        EndIf
    EndWith

    ConsoleWrite("API Response:" & @CRLF & $sResponse & @CRLF)
	Return $sResponse
 EndFunc
Func com_error_handler($oError)
    Return
EndFunc