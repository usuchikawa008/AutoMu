 ;C�i thu vi?n v�o chuong tr�nh
#include <NomadMemory.au3>
#include <MsgBoxConstants.au3>
;Th? xem thu vi?n c�i th�nh c�ng kh�ng
_MemoryOpen(72)
 ;M? game Minesweeper
$iv_Pid=WinGetProcess ("Cheat Engine Tutorial v3.4")

;N?u game dang ho?t d?ng th� l?nh tr�n ch?c ch?n th�nh c�ng, vi?c ti?p theo l� m? Memory ra b?ng c�u l?nh sau:
;M? Memory game Minesweeper ra
$ah_Handle=_MemoryOpen(13048)
ConsoleWrite($ah_Handle)
$iv_Address="0x0180E94C"

;�?c Memory trong Game
$var=_MemoryRead($iv_Address , $ah_Handle)
;~ $_Address = "0x"&Hex($var + 1196)

;~ $final=_MemoryRead($_Address , $ah_Handle)
msgbox (0 ,"hocautoit.com" ,$var)
