#include <AutoItConstants.au3> ; Required for _ArrayDisplay.
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
Global Const $pathAuto = @ScriptDir&"\image\cauhoi"
Global Const $pathNhap = @ScriptDir
Global Const $pathDapan = @ScriptDir&"\image\"
$listfile = _FileListToArray($pathAuto, "*.bmp")
;~ _ArrayDisplay($listfile, "Sorted tree")
;~  ConsoleWrite($listfile[2][0])


For $iii = 1 to 10 Step + 1
   For $i = 1 To UBound($listfile)-1
	  local $name = StringSplit($listfile[$i],".")[1]
	  ConsoleWrite($i&": "&$name&@LF)
   Next
   ConsoleWrite("____________________________________"&$i&@LF)

   _ArrayDelete($listfile,$i-30)
Next


