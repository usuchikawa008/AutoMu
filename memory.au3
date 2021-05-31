 ;Cài thu vi?n vào chuong trình
#include <NomadMemory.au3>
#include <MsgBoxConstants.au3>
;Th? xem thu vi?n cài thành công không
_MemoryOpen(72)
 ;M? game Minesweeper
$iv_Pid=WinGetProcess ("Cheat Engine Tutorial v3.4")

;N?u game dang ho?t d?ng thì l?nh trên ch?c ch?n thành công, vi?c ti?p theo là m? Memory ra b?ng câu l?nh sau:
;M? Memory game Minesweeper ra
$ah_Handle=_MemoryOpen(13048)
ConsoleWrite($ah_Handle)
$iv_Address="0x0180E94C"

;Ð?c Memory trong Game
$var=_MemoryRead($iv_Address , $ah_Handle)
;~ $_Address = "0x"&Hex($var + 1196)

;~ $final=_MemoryRead($_Address , $ah_Handle)
msgbox (0 ,"hocautoit.com" ,$var)
