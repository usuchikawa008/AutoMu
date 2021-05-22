#include <AutoItConstants.au3>
#include <imageSearchEX.au3>
#include <HandleImgSearch.au3>
#include <huyencanh\huyencanh.au3>
#include <blood\blood.au3>
#include <tinhanh\tinhanh.au3>
#include <daomo\daomo.au3>
#include <bosscanhan\bosscanhan.au3>
#include <nvtienthuong\nvtienthuong.au3>
#include "_IMGSearch_Debug.au3"
#include <Date.au3>
#include <Array.au3>
AutoItSetOption ("TrayIconDebug", 1);0-off
HotKeySet("+{Esc}", "_Exit") ; Press ESC for exit
Func _Exit()
	Exit 0
 EndFunc   ;==>_Exit

 ;config start
If $CmdLine[0] == 0 Then
   Global Const $Title =  StringSplit(@ScriptName,'.')[1] ;get script name : example Noxplayer
Else
   Global Const $Title =  $CmdLine[1]
EndIf
;~ Global $Title =  "NoxPlayer"
;~ Global Const $Title =  "NoxPlayer(1)"
;~ Global $Title =  "NoxPlayer(1)(1)"
Sleep(200)
Global $hwAuto = WinGetHandle("[CLASS:AutoIt v3 GUI]") ;handle cua GUI AUTO de set log
Sleep(200)
;dir config file
Global Const $path = @ScriptDir&"\config\"
;config hoat dong start
Global Const $status = "Status"
Global Const $notyet = "Wait"
Global Const $doing = "Running"
Global Const $done = "Done"
Global Const $hoatdong = "Hoat Dong"
Global Const $huyencanh = "HuyenCanh"
Global Const $blood = "Blood"
Global Const $bosscanhan = "BossCaNhan"
Global Const $tienthuong = "TienThuong"
Global Const $run = "Run"
Global Const $finish = "Finish"
Global Const $daomo = "DaoMo"
Global Const $cuopmo = "CuopMo"
Global Const $treomay = "TreoMay"
Global Const $nvguild = "NVGuild"
Global Const $tinhanh = "TinhAnh"
;config hoat dong End

;~ Global $Nox_Path = "D:\Program Files\Nox\bin"
$Nox_PathFull = _WinGetPath("NoxPlayer")
Global $Nox_Path = StringLeft(StringSplit($Nox_PathFull,'.')[1],StringLen(StringSplit($Nox_PathFull,'.')[1])-4)
Func _WinGetPath($Title="", $strComputer='localhost')
    $win = WinGetTitle($Title)
    $pid = WinGetProcess($win)
   $wbemFlagReturnImmediately = 0x10
   $wbemFlagForwardOnly = 0x20
   $colItems = ""
   $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
   $colItems = $objWMIService.ExecQuery ("SELECT * FROM Win32_Process WHERE ProcessId = " & $pid, "WQL", _
         $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
   If IsObj($colItems) Then
      For $objItem In $colItems
         If $objItem.ExecutablePath Then Return $objItem.ExecutablePath
      Next
   EndIf
EndFunc
  Func writelog($textlog)
	 Opt("WinTitleMatchMode", 3)
     ControlSend($hwAuto, "", "Edit1",$Title & ": " & $textlog) ; log UI
;~ 	 ConsoleWrite($textlog) ;log console
  EndFunc   ;==>Example
If $Title == "NoxPlayer" Then
   Global $emuport = 62001
   HotKeySet("+1", "_Exit") ; Press SHIFT+1 for exit
EndIf
If $Title == "NoxPlayer(1)" Then
   Global $emuport = 62025
   HotKeySet("+2", "_Exit") ; Press SHIFT+2 for exit
EndIf
If $Title == "NoxPlayer(1)(1)" Then
   Global $emuport = 62026
   HotKeySet("+3", "_Exit") ; Press SHIFT+3 for exit
EndIf
;config end
Global $hwnd = GetHwnd($Title);get handle gia lap
Global $sNewTime = _NowCalc();ngay hien tai
Func GetHwnd($Title)
    ; Retrieve a list of window handles.
    Local $aList = WinList("[TITLE:"&$Title&"]")
    ; Loop through the array displaying only visable windows with a title.
    For $i = 1 To $aList[0][0]
        If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) Then
		   if ($aList[$i][0] == $Title ) Then
            writelog("Start Auto With Handle = "& $aList[$i][1] &@CRLF ) ; write console
			$hwnd= $aList[$i][1] ; get handle windown
			Return $hwnd
		 EndIf
	  EndIf
    Next
EndFunc   ;==>Example
Global $BossCaNhanDONE = false;
Global $huyencanhDONE = False;
Global $NVTIENTHUONGDONE = false;
Global $bloodDONE = False;
Global $DaoMoDone = false;
Global $CuopMoDone = false;
Global $TrainQuai = false;
Global $NVGuide = false;
Global $NVTinhAnh = false;
Opt("WinTitleMatchMode", 3)
WinMove($Title, "",Default ,Default , 849, 509)
$count = 0
While $count < 30 ;loop auto 50 lan
_close($hwnd)
$count = $count + 1
writelog("Auto Vong "&$count&" bat dau" &@CRLF) ; write console
_ADB_Command("nox_adb.exe -s 127.z0.0.1:"&$emuport&" shell input keyevent 111"); an esc top reset
Sleep(200)
_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 800 800 800 850 500"); di chuyen 1 chut

 Auto()
 If @error Then
   ExitLoop
 EndIf
WEnd
writelog("Het NV ---Stop auto...."&$Title&" on" & _NowTime() & @CRLF) ; write console
IniWrite($path&$Title&".tmp", $run, $finish,True) ; update finish AUTO
Sleep(1000)
Exit 0
Func Auto()
	;click menu
   ;loop Huyen canh pb
    Global $pos = WinGetPos($Title)
	  Local $countNV = 0;
	   ;nv thuong ngay
	   #cs
	   1.Di Huyen Canh tren khong
	   #ce
	   Sleep(1000)
	   Local $sReadhuyencanh = IniRead($path&$Title&".tmp", $hoatdong, $huyencanh, False)
	   Local $statushuyencanh = IniRead($path&$Title&".tmp", $status, $huyencanh, $notyet)
	   If $sReadhuyencanh == True And $statushuyencanh <> $done Then
		  $countNV = $countNV + 1
		  $huyencanhDONE = False
		   $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $huyencanh,$doing) ; change status running
		  GotoPBHuyenCanh($Title,$emuport,$hwnd) ;huyencanh.au3--Di huyen canh
		  If @error Then
			 writelog("1. DA HET LUOT HUYEN CANH...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $huyencanh,$done) ; change status done
		  Else
			 IniWrite($path&$Title&".tmp", $status, $huyencanh,$notyet) ; change status wait
		  EndIf
		  Sleep(1500)
	   EndIf

   #cs
	2.Di Blood castle
	#ce
	   Local $sReadblood = IniRead($path&$Title&".tmp", $hoatdong, $blood, False)
	   Local $statusblood = IniRead($path&$Title&".tmp", $status, $blood, $notyet)
	   If $sReadblood == True And $statusblood <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $blood,$doing) ; change status running
		  GotoPBBlood($Title,$emuport,$hwnd) ;blood #blood.au3
		  If @error Then
			 writelog("2. DA HET LUOT BLOOD...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $blood,$done) ; change status
		  Else
			 IniWrite($path&$Title&".tmp", $status, $blood,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf

   ;~    #cs
   ;~ 	3. Dao mo
   ;~ 	#ce
	   Local $sReaddaomo = IniRead($path&$Title&".tmp", $hoatdong, $daomo, False)
	   Local $statusdaomo = IniRead($path&$Title&".tmp", $status, $daomo, $notyet)
	   If $sReaddaomo == True And $statusdaomo <> $done Then
		  $countNV = $countNV + 1
		  If _NowCalc() > $sNewTime Then
			 $rs = _openHoatDong()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($path&$Title&".tmp", $status, $daomo,$doing) ; change status running
			 $sNewTime = GotoDaoMo($Title,$emuport,$hwnd) ; di dao mo #daomo.au3
			 If @error Then
				writelog("3. DA HET LUOT DAO MO...." & _NowTime() & @CRLF) ; write console
				IniWrite($path&$Title&".tmp", $status, $daomo,$done) ; change status done
			 Else
			    IniWrite($path&$Title&".tmp", $status, $daomo,$notyet) ; change status wait
			 EndIf
		  EndIf
	   Sleep(2000)
       EndIf
    #cs
	4. cuop mo
	#ce
	   Local $sReadcuopmo = IniRead($path&$Title&".tmp", $hoatdong, $cuopmo, False)
	   Local $statuscuopmo = IniRead($path&$Title&".tmp", $status, $cuopmo, $notyet)
	   If $sReadcuopmo == True And $statuscuopmo <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $cuopmo,$doing) ; change status running
		  $resultcuopmo = GotoCuopMo($Title,$emuport,$hwnd) ; di dao mo #daomo.au3
		  If @error Then
			 writelog("4. DA HET LUOT CUOP MO...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $cuopmo,$done) ; change status done
		  Else
			 IniWrite($path&$Title&".tmp", $status, $cuopmo,$notyet) ; change status done
		  EndIf
		  Sleep(2000)
	   EndIf
   #cs
	5.boss ca nhan
	#ce
	Local $checkboxbosscanhan = IniRead($path&$Title&".tmp", $hoatdong, $bosscanhan, False)
	Local $statusbosscanhan = IniRead($path&$Title&".tmp", $status, $bosscanhan, $notyet)
	If $checkboxbosscanhan == True And $statusbosscanhan <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   IniWrite($path&$Title&".tmp", $status, $bosscanhan,$doing) ; change status running
	   _GotoPBBossCaNhan($Title,$emuport,$hwnd) ;boss ca nhan # bosscanhan.au3
	   If @error Then
		  writelog("5. DA HET LUOT BOSS CA NHAN...." & _NowTime() & @CRLF) ; write console
		  IniWrite($path&$Title&".tmp", $status, $bosscanhan,$done) ; change status done
	   Else
		   IniWrite($path&$Title&".tmp", $status, $bosscanhan,$notyet) ; change status wait
	   EndIf
	Sleep(2000)
	EndIf
;~    #cs
;~ 	6.Di NV tien thuong
;~ 	#ce
	Local $scheckboxtienthuong = IniRead($path&$Title&".tmp", $hoatdong, $tienthuong, False)
	Local $statustienthuong = IniRead($path&$Title&".tmp", $status, $tienthuong, $notyet)
	If $scheckboxtienthuong == True And $statustienthuong <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   IniWrite($path&$Title&".tmp", $status, $tienthuong,$doing) ; change status running
	   GotoNVTienThuong($Title,$emuport,$hwnd,$pos) ; di pb nvtienthuong #nvthienthuong.au3
	   If @error Then
		  IniWrite($path&$Title&".tmp", $status, $tienthuong,$done) ; change status done
		  writelog("6. DA HET LUOT NV TIEN THUONG...." & _NowTime() & @CRLF) ; write console
	   Else
		   IniWrite($path&$Title&".tmp", $status, $tienthuong,$notyet) ; change status wait
	    EndIf
	   Sleep(2000)
	EndIf


    #cs
	7. train quai
	#ce
	Local $scheckboxtreomay = IniRead($path&$Title&".tmp", $hoatdong, $treomay, False)
	Local $statustreomay = IniRead($path&$Title&".tmp", $status, $treomay, $notyet)
	If $scheckboxtreomay == True And $statustreomay <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   Sleep(500)
	   IniWrite($path&$Title&".tmp", $status, $treomay,$doing) ; change status running
	   _GotoTrainQuai($Title,$emuport,$hwnd,$pos) ; train quai #nvtienthuong.au3
	   If @error Then
		  IniWrite($path&$Title&".tmp", $status, $treomay,$done) ; change status done
		  writelog("7. Hoan Thanh Train Quai...." & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	   Else
		   IniWrite($path&$Title&".tmp", $status, $treomay,$notyet) ; change status wait
	    EndIf
	   Sleep(2000)
	EndIf

	#cs
	8. NV guild
	#ce
	Local $scheckboxnvguild = IniRead($path&$Title&".tmp", $hoatdong, $nvguild, False)
	Local $statusnvguild = IniRead($path&$Title&".tmp", $status, $nvguild, $notyet)
	If $scheckboxnvguild == True And $statusnvguild <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   Sleep(500)
	   IniWrite($path&$Title&".tmp", $status, $nvguild,$doing) ; change status running
	   _GotoNVGuide($Title,$emuport,$hwnd,$pos) ; nv guide #nvtienthuong.au3
	   If @error Then
		  IniWrite($path&$Title&".tmp", $status, $nvguild,$done) ; change status done
		  writelog("8. Hoan Thanh NV Guide...." & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	   Else
		   IniWrite($path&$Title&".tmp", $status, $nvguild,$notyet) ; change status wait
	    EndIf
	   Sleep(2000)
	EndIf

	#cs
	9. San Tinh Anh
	#ce
	Local $scheckboxtinhanh = IniRead($path&$Title&".tmp", $hoatdong, $tinhanh, False)
	Local $statustinhanh = IniRead($path&$Title&".tmp", $status, $tinhanh, $notyet)
	If $scheckboxtinhanh == True And $statustinhanh <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   Sleep(500)
	   IniWrite($path&$Title&".tmp", $status, $tinhanh,$doing) ; change status doing
	   _GotoNVTinhAnh($Title,$emuport,$hwnd) ; nv tinh anh #tinhanh
	   If @error Then
		  IniWrite($path&$Title&".tmp", $status, $tinhanh,$done) ; change status done
		  writelog("9. Hoan Thanh NV Tinh Anh...." & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	   Else
		   IniWrite($path&$Title&".tmp", $status, $tinhanh,$notyet) ; change status wait
	    EndIf
	   Sleep(2000)
	EndIf
   If $countNV == 0 Then
	  Return SetError(3);tra ve error neu tat ca nv da done
   EndIf
EndFunc   ;==>Example
Func CheckInPbOrNot($Title,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 $ImagePath = @ScriptDir & "\image\menu.bmp"
	 $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 0, 0, -1, -1,90, 2);search nut menu
	  If @error Then ; ko thay menu
		 writelog("Dang o trong pho ban.. Chuan bi thoat" & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1268 54") ;click thoat
		  Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 985 600") ;click Xac nhan
		 $Result = _HandleImgWaitExist($Handle, $ImagePath,6, 0, 0, -1, -1,90, 2);search nut menu again trong 6s
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1268 54") ;click menu
		 Return SetError(3)
	  Else
		 writelog("Tim thay menu " & _NowTime() & @CRLF) ; write console
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click menu
	  EndIf


EndFunc   ;==>ControlClickWindowsByImage
Func _CheckNhanSoiNoi($Title,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 $ImagePath = @ScriptDir & "\image\laysoinoi.bmp"
	 $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 0, 0, -1, -1,90, 10);search nut Laysoi noi trongh 2s
	  If @error Then ; ko thay soi noi
		 Return SetError(3)
	  Else
		 writelog("Nhan thuong soi noi " & _NowTime() & @CRLF) ; write console
		 Sleep(500)
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0]+250, $Result[1][1]-30) ; click nhan soi noi
	  EndIf


EndFunc   ;==>ControlClickWindowsByImage

Func _close($Handle)
     If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  $ImagePath = @ScriptDir & "\image\close.bmp"
	  $Result = _HandleImgSearch($Handle, $ImagePath, 0, 0, -1, -1,94, 10);search close button
	  If @error Then ; ko thay close
	  Else
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click close
	  EndIf
EndFunc   ;==>Example


Func _openHoatDong()
	   Sleep(1000)
	   $rs = _openMenu()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return 1
	   EndIf
	   $rsboss = _checkbossguild()
EndFunc   ;==>Example

Func _checkbossguild()
	   Sleep(1000)
	   Local $Now = _NowTime(4);time hien tai
	   $var1 = StringRegExpReplace($Now, "[:]", "")
	   $timestart = StringRegExpReplace("11:59", "[:]", "")
	   $timeend = StringRegExpReplace("12:10", "[:]", "")
	   If $var1 > $timestart And $var1 < $timeend Then
		  _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
		  If @error Then
			 writelog("Het Time Boss Guild...." & _NowTime() & @CRLF) ; write console
		  EndIf
	   EndIf
EndFunc   ;==>Example

Func _openMenu()
	   $ImagePath = @ScriptDir & "\image\nhatkihd.bmp"
	   $Result = _HandleImgSearch($hwnd, $ImagePath, 0, 0, -1, -1,50, 10);search nhat ki hd
	   If not @error Then ;menu da mo san
		  _CheckNhanSoiNoi($Title,$hwnd); search Lay soi noi neu available
		  If not @error Then
			Return 1 ;
		  EndIf
		  writelog("Menu san sang " & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 160 130") ;chuyen sang tab hoat dong
		  Return
	   EndIf
	   CheckInPbOrNot($Title,$hwnd); search menu
	   Sleep(700)
	   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 160 130") ;chuyen sang tab hoat dong
	   _CheckNhanSoiNoi($Title,$hwnd); search Lay soi noi neu available
	   If not @error Then
		 Return 1 ;
	   EndIf


EndFunc   ;==>Example

 Func _ADB_Command($Command, $WorkingDir = @ScriptDir)
    $DOS = Run($Nox_Path & "\" & $Command, $Nox_Path, @SW_HIDE, $STDERR_MERGED)
    While 1
        Sleep(50)
        If @error Or Not ProcessExists($DOS) Then ExitLoop
    WEnd
    $Message = StdoutRead($DOS)
    Return $Message
 EndFunc   ;==>_ADB_Command

Func _searchNV($Handle, $imagepath, $tor = 115)
	  $i = 0
	  While $i < 6
		 $i = $i + 1
		 $Result = _HandleImgWaitExist($Handle, $imagepath,1, 0, 0, -1, -1,$tor, 2);search nut menu
		 If not @error Then ; neu thay nv out
			Return $Result
		 Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 510 800"); di chuyen cuon len 1 chut
			Sleep(1500)
		 EndIf
	  WEnd
	  Return SetError(3) ; ko tim thay return error
EndFunc   ;==>Goto Treo Quai
