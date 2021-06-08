#include "Json.au3"

Local $Json = '[{"id":"1","Code":"B8RV0B2D5W","Client_Name":"","MAC":"TEST","Social":"","DateExpire":"06/10/2021"}]'
Local $Obj = Json_Decode($Json)

ConsoleWrite(Json_Get_Data($Obj, '[0]["DateExpire"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][0]["map_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][0]["event_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][0]["state"]') & @LF)

ConsoleWrite(Json_Get_Data($Obj, '["events"][1]["world_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][1]["map_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][1]["event_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][1]["state"]') & @LF)

ConsoleWrite(Json_Get_Data($Obj, '["events"][2]["world_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][2]["map_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][2]["event_id"]') & @LF)
ConsoleWrite(Json_Get_Data($Obj, '["events"][2]["state"]') & @LF)

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