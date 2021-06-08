 ;Cài thu vi?n vào chuong trình
#include <NomadMemory.au3>
#include <MsgBoxConstants.au3>
;Th? xem thu vi?n cài thành công không
_MemoryOpen(72)
 ;M? game Minesweeper
 Opt("WinTitleMatchMode", 3)
$iv_Pid=WinGetProcess ("NoxPlayer")

;N?u game dang ho?t d?ng thì l?nh trên ch?c ch?n thành công, vi?c ti?p theo là m? Memory ra b?ng câu l?nh sau:
;M? Memory game Minesweeper ra
ConsoleWrite($iv_Pid&@CRLF)
$ah_Handle=_MemoryOpen($iv_Pid)
$iv_Address="0x5ABB7C38"

;Ð?c Memory trong Game
$var=_MemoryRead($iv_Address , $ah_Handle)
;~ $_Address = "0x"&Hex($var + 1196)

;~ $final=_MemoryRead($_Address , $ah_Handle)
ConsoleWrite($var&@CRLF)
