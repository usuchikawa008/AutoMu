 ;C�i thu vi?n v�o chuong tr�nh
#include <NomadMemory.au3>
#include <MsgBoxConstants.au3>
;Th? xem thu vi?n c�i th�nh c�ng kh�ng
_MemoryOpen(72)
 ;M? game Minesweeper
 Opt("WinTitleMatchMode", 3)
$iv_Pid=WinGetProcess ("NoxPlayer")

;N?u game dang ho?t d?ng th� l?nh tr�n ch?c ch?n th�nh c�ng, vi?c ti?p theo l� m? Memory ra b?ng c�u l?nh sau:
;M? Memory game Minesweeper ra
ConsoleWrite($iv_Pid&@CRLF)
$ah_Handle=_MemoryOpen($iv_Pid)
$iv_Address="0x5ABB7C38"

;�?c Memory trong Game
$var=_MemoryRead($iv_Address , $ah_Handle)
;~ $_Address = "0x"&Hex($var + 1196)

;~ $final=_MemoryRead($_Address , $ah_Handle)
ConsoleWrite($var&@CRLF)
