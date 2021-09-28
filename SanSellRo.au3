#include <RestApiTest.au3>
#include <AutoItConstants.au3>

;~ Local $jsonString = get_authentication_test("https://vro-market.com/?search-item=6962",""); get Json code version
;~ ConsoleWrite($jsonString)
Local $iPID = Run("curl -s -k https://vro-market.com/?search-item=6962", "", @SW_HIDE, $STDOUT_CHILD)
ProcessWaitClose($iPID)
Local $output = StdoutRead($iPID)
Local $output_uni = _ANSIToUnicode($output)
ConsoleWrite($output_uni)
FileWrite(@ScriptDir & "\test.html",$output_uni); save file



Func _ANSIToUnicode($sString)
    #cs
        Local Const $SF_ANSI = 1
        Local Const $SF_UTF16_LE = 2
        Local Const $SF_UTF16_BE = 3
        Local Const $SF_UTF8 = 4
    #ce
    Local Const $SF_ANSI = 1, $SF_UTF8 = 4
    Return BinaryToString(StringToBinary($sString, $SF_ANSI), $SF_UTF8)
 EndFunc   ;==>_ANSIToUnicode