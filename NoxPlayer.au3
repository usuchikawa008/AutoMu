#include <AutoItConstants.au3>
#include <imageSearchEX.au3>
#include <HandleImgSearch.au3>
#include <huyencanh\huyencanh.au3>
#include <blood\blood.au3>
#include <tinhanh\tinhanh.au3>
#include <laythanhvat\laythanhvat.au3>
#include <daomo\daomo.au3>
#include <bosscanhan\bosscanhan.au3>
#include <nvtienthuong\nvtienthuong.au3>
#include "_IMGSearch_Debug.au3"
#include <Date.au3>
#include <Array.au3>
#include <DateTime.au3>
AutoItSetOption ("TrayIconDebug", 1);0-off
HotKeySet("+{Esc}", "_Exit") ; Press Shift + ESC for exit
Func _Exit()
	Exit 0
 EndFunc   ;==>_Exit
Global $PauseTimer = 0
Func Pause()
    If $PauseTimer = 0 Then
        $PauseTimer += 2  ; pause1
        While $PauseTimer > 0
;~             ToolTip($PauseTimer)
            Sleep(500)
            $PauseTimer -= 1
        WEnd
;~         ToolTip("")1
    Else
        $PauseTimer = 0
    EndIf
    Return
EndFunc
 ;config start
If $CmdLine[0] == 0 Then
   Global Const $Title =  StringSplit(@ScriptName,'.')[1] ;get script name : example Noxplayer
Else
   Global Const $Title =  $CmdLine[1]
EndIf
;~ Global $Title =  "NoxPlayer"
;~ Global $Title =  "NoxPlayer(1)"
;~ Global $Title =  "NoxPlayer(1)(1)"
Sleep(200)
Global $hwAuto = WinGetHandle("[CLASS:AutoIt v3 GUI]") ;handle cua GUI AUTO de set log
Global Const $expireDate = "06/19/2021" ; format MM/DD/YYYY
;dir config file
Global Const $path = @ScriptDir&"\config\"
Global Const $pathAuto = @ScriptDir&"\auto\"
Global Const $pathImage = @ScriptDir&"\image\"
Global Const $pathOCR = @ScriptDir&"\OCR.jar"
Global Const $OCRFlag = "OCR"
Global Const $general = "General"
Global Const $hardmode = "HardMode"
Global Const $noxpath = "NoxPath"
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
Global Const $daomo = "DaoMo"
Global Const $cuopmo = "CuopMo"
Global Const $treomay = "TreoMay"
Global Const $nvguild = "NVGuild"
Global Const $tinhanh = "TinhAnh"
Global Const $laythanhvat = "LayThanhVat"
Global Const $bossguild12h = "bossguild12"
Global Const $tuhoiguild8h = "Tuhoiguild8h"
;config auto Run
Global Const $run = "Run"
Global Const $finish = "Finish"
Global Const $statusNox = "StatusNox"
Global Const $onl = "Onl"
Global Const $off = "Off"
Global Const $cmdStart = "cmdStart"
;config hoat dong End
;config day of week start
Global Const $CN = "Sunday"
Global Const $T2 = "Monday"
Global Const $T3 = "Tuesday"
Global Const $T4 = "Wednesday"
Global Const $T5 = "Thursday"
Global Const $T6 = "Friday"
Global Const $T7 = "Saturday"
;config day of week end


;~ Global $Nox_Path = "D:\Program Files\Nox\bin"

Global $checkOCR = IniRead($pathImage&"1.tmp", $general, $OCRFlag, False);kiem tra co open OCR hay ko
Local $temp = IniRead($pathImage&"1.tmp", $general, $noxpath, ""); luu vo config
If $temp == "" Then
   writelog("Khong tim thay duong dan Nox" &@CRLF ) ; write console
   Exit 0
Else
   Global $Nox_Path = $temp
EndIf
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
If $Title == "NoxPlayer(2)" Then
   Global $emuport = 62026
   HotKeySet("+3", "_Exit") ; Press SHIFT+3 for exit
EndIf
If $Title == "NoxPlayer(3)" Then
   Global $emuport = 62027
   HotKeySet("+4", "_Exit") ; Press SHIFT+4 for exit
EndIf
If $Title == "NoxPlayer(4)" Then
   Global $emuport = 62028
   HotKeySet("+5", "_Exit") ; Press SHIFT+5 for exit
EndIf
If $Title == "NoxPlayer(5)" Then
   Global $emuport = 62029
   HotKeySet("+6", "_Exit") ; Press SHIFT+6 for exit
EndIf
;config end
Local $statusNoxx = IniRead($pathAuto&$Title&".tmp", $run, $statusNox, $onl)
If $statusNoxx == $off Then
   Local $cmd = IniRead($pathAuto&$Title&".tmp", $run, $cmdStart, "")
   If $cmd <> ""  Then
	  $cmdfull = $Nox_Path & "\" & $cmd
	  $DOS = Run($cmdfull, $Nox_Path, @SW_HIDE, $STDERR_MERGED); Start Nox
	  Sleep(30000)
   EndIf
EndIf
Global $hwnd = GetHwnd($Title);get handle gia lap
Global $sNewTime = _NowCalc();ngay hien tai
Func GetHwnd($Title)
    ; Retrieve a list of window handles.
	Opt("WinTitleMatchMode", 3)
    Local $aList = WinList("[TITLE:"&$Title&"]")
;~ 	_ArrayDisplay($aList)
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
Global $NVTIENTHUONGDONE = false;
Global $bloodDONE = False;
Global $DaoMoDone = false;
Global $CuopMoDone = false;
Global $TrainQuai = false;
Global $NVGuide = false;
Global $NVTinhAnh = false;
Global $count = 0
Global $maxloop  = 1000
Global $resetNV = 0 ; reset NV 4 lan truoc khi ket thuc
$checkHARDMOD = IniRead($pathImage&"1.tmp", $general, $hardmode, False);kiem tra co o che do hard mode hay khong
If $checkHARDMOD == True Then
   writelog("Run with hard mode"& @CRLF) ; write console
   $maxloop = 999999;
EndIf
$loadname = False
_checkExpireDate() ; kiem tra het han auto
 If @error Then
	  msgbox(0, '' , "Auto has been expired")
	  IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
 Exit 0
 EndIf
If $statusNoxx == $off Then
   _startAndLogin()
EndIf
Opt("WinTitleMatchMode", 3)
WinMove($Title, "",Default ,Default , 849, 509) ;resize auto
While $count < $maxloop;loop auto 1000 lan
_close($hwnd) ;close het cua so truoc khi bat dau auto
$count = $count + 1 ; so lan loop
writelog("Auto Vong "&$count&" bat dau" &@CRLF) ; write console
Sleep(200)
 Auto()
 If @error Then
   ExitLoop
 EndIf
WEnd
writelog("Het NV ---Stop auto...."&$Title&" on" & _NowTime() & @CRLF) ; write console
IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
Sleep(1000)
Exit 0
Func Auto()
	;getName Nhan Vat
	If $checkOCR == True Then
	   If $loadname == False Then
		  writelog("Update name"& @CRLF) ; write console
		  $rss = _getNameCharacter()
		  If $rss == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
	   EndIf
	EndIf
    Global $pos = WinGetPos($Title)
    Local $countNV = 0;
	Local $countNVHenGio = 0;
	;nv thuong ngay
	#cs
	1.Di Huyen Canh tren khong
	#ce
	Sleep(1000)
	Local $sReadhuyencanh = IniRead($path&$Title&".tmp", $hoatdong, $huyencanh, False)
	Local $statushuyencanh = IniRead($path&$Title&".tmp", $status, $huyencanh, $notyet)
	If $sReadhuyencanh == True And $statushuyencanh <> $done Then
	   $countNV = $countNV + 1
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
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(3); check boss guild 12h trc 5 phut
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
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(10); check boss guild 12h trc 10 phut
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
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(7); check boss guild 12h trc 7 phut
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
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(7); check boss guild 12h trc 7 phut
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
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(5); check boss guild 12h trc 5 phut
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
	#cs
	10. Lay Thanh Vat
	#ce
	Local $scheckboxlaythanhvat = IniRead($path&$Title&".tmp", $hoatdong, $laythanhvat, False)
	Local $statuslaythanhvat = IniRead($path&$Title&".tmp", $status, $laythanhvat, $notyet)
;~ 	Local $ignore = _checkBoss12handTuhoiGuild(5); check boss guild 12h trc 5 phut
	If $scheckboxlaythanhvat == True And $statuslaythanhvat <> $done Then
	   $countNV = $countNV + 1
	   $rs = _openHoatDong()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return
	   EndIf
	   Sleep(500)
	   IniWrite($path&$Title&".tmp", $status, $laythanhvat,$doing) ; change status doing
	   _GotoLayThanhVat($Title,$emuport,$hwnd) ; nv lay thanh vat #laythanhvat
	   If @error Then
		  IniWrite($path&$Title&".tmp", $status, $laythanhvat,$done) ; change status done
		  writelog("10. Hoan Thanh Lay Thanh Vat..." & _NowTime() & @CRLF) ; write console
	    Else
		   IniWrite($path&$Title&".tmp", $status, $laythanhvat,$notyet) ; change status wait
	    EndIf
	   Sleep(2000)
	EndIf

	#cs
	11. Boss guild 12h
	#ce
   Local $scheckboxbossguild12h = IniRead($path&$Title&".tmp", $hoatdong, $bossguild12h, False)
   Local $statusbossguild12h = IniRead($path&$Title&".tmp", $status, $bossguild12h, $notyet)
   If $scheckboxbossguild12h == True And $statusbossguild12h <> $done Then
	   $countNVHenGio = $countNVHenGio + 1 ; van con nv de lam
	   Local $Now = _getCurrentTime();time hien tai
	   Local $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("11:59", "[:]", "")
	   Local $timeend = StringRegExpReplace("12:10", "[:]", "")
	   ;check het time boss guild chua
	   If $var1 > $timeend Then
		  writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  $rs = _openMenu()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
		  _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
	   EndIf
	EndIf
	#cs
	12. Tu Hoi Guild + Boss Guild 8h
	#ce
   Local $scheckboxtuhoiguild = IniRead($path&$Title&".tmp", $hoatdong, $tuhoiguild8h, False)
   Local $statustuhoiguild = IniRead($path&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
   If $scheckboxtuhoiguild == True And $statustuhoiguild <> $done Then
	   $countNVHenGio = $countNVHenGio + 1 ; van con nv de lam
	   Local $Now = _getCurrentTime();time hien tai
	   Local $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("19:35", "[:]", "")
	   Local $timeend = StringRegExpReplace("20:00", "[:]", "")
	   ;check het time boss guild chua
	   If $var1 > $timeend Then
		  writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  $rs = _openMenu()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
	   EndIf
   EndIf
	Sleep(2000)
	;Xu Li Het Auto
   If $countNV == 0 Then ; het nv de lam
	  If $resetNV < 4 Then
		 $resetNV = $resetNV + 1
		 writelog("Reset auto lan "&$resetNV& @CRLF) ; write console
		 _resetStatus()
		 Return ;next
	  EndIf
   EndIf
   If $countNV == 0 And $countNVHenGio == 0 Then ; het nv ngay va nv hen gio thi stop auto
	  SetError(3)
   EndIf
EndFunc   ;==>Example
Func CheckInPbOrNot($Title,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
   While 1 ;tim den khi thay menu
	 Local $ImagePath = @ScriptDir & "\image\menu.bmp"
	 Local $Result = _HandleImgWaitExist($Handle, $ImagePath,1, 0, 0, -1, -1,94, 2);search nut menu
	  If @error Then ; ko thay menu
		  writelog("Tim kiem menu " & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 450") ;click giua man hinh
		 _close($Handle); close all window
		 Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
		 Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,1, 0, 0, -1, -1,80, 2);search icon thoat pho ban
		 If Not @error Then
			writelog("Dang Trong Pho Ban .. Thoat " & _NowTime() & @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$rsthoatpb[1][0], $rsthoatpb[1][1]) ; click thoat
			Sleep(700)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 985 600") ;click Xac nhan
			Sleep(6000)
			$Result2 = _HandleImgWaitExist($Handle, $ImagePath,2, 0, 0, -1, -1,94, 2);search nut menu again trong 5s
		 EndIf
	  Else
		 writelog("Tim thay menu " & _NowTime() & @CRLF) ; write console
		 Opt("WinTitleMatchMode", 3)
;~ 		 writelog($Result[1][0] &" " & $Result[1][1] & @CRLF) ; write console
		 ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click menu
		 ExitLoop
	  EndIf
   WEnd
EndFunc   ;==>ControlClickWindowsByImage
Func _CheckNhanSoiNoi($Title,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 $ImagePath = @ScriptDir & "\image\laysoinoi.bmp"
	 $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 0, 0, -1, -1,100, 10);search nut Laysoi noi trongh 2s
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
	  If not @error Then ; thay close
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click close
	  EndIf
	  $ImagePath2 = @ScriptDir & "\image\close2.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath2,1, 0, 0, -1, -1,94, 10);search close button 2
	  If not @error Then ;  thay close
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click close
	  EndIf
	  $ImagePath3 = @ScriptDir & "\image\huy.bmp"
	  $Result = _HandleImgSearch($Handle, $ImagePath3, 480, 250, 80, 60,149, 2);search huy button
	  If not @error Then ;  thay huy
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$Result[1][0]+480, $Result[1][1]+250) ; click close
	  EndIf
   EndFunc   ;==>Example

Func _closeSimple($Handle)
     If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Local $ImagePath = @ScriptDir & "\image\close.bmp"
	  Local $Result = _HandleImgSearch($Handle, $ImagePath, 0, 0, -1, -1,94, 10);search close button
	  If not @error Then ; thay close
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
	   Sleep(1000)
	   $rsboss = _checkbossguild()
	   If $rsboss == 1 Then ;  boss guild = 1 thi next loop
		  Return 1
	   EndIf

	   $rstuhoi = _checktuhoiguild()
	   If $rstuhoi == 1 Then ;  tu hoi guild = 1 thi next loop
		  Return 1
	   EndIf
EndFunc   ;==>Example

Func _checkbossguild()
   Local $scheckboxbossguild12h = IniRead($path&$Title&".tmp", $hoatdong, $bossguild12h, False)
   Local $statusbossguild12h = IniRead($path&$Title&".tmp", $status, $bossguild12h, $notyet)
   If $scheckboxbossguild12h == True And $statusbossguild12h <> $done Then
	   Local $Now = _getCurrentTime();time hien tai
	   Local $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("11:59", "[:]", "")
	   Local $timewait = StringRegExpReplace("11:50", "[:]", "")
	   Local $timeend = StringRegExpReplace("12:10", "[:]", "")
	   ;check het time boss guild chua
	   If $var1 > $timeend Then
		  writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
		  Return
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
		  _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 Return 1
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
		  Return 1
	   EndIf
	   If $var1 > $timewait And $var1 < $timeend Then
		  Local $wait = 1160 - $var1
		  writelog("Cho "&$wait &" phut vo boss guild 12 gio"& @CRLF) ; write console
		  Sleep($wait*60000)
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
		  _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 Return 1
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
		  Return 1
	   EndIf
	EndIf

EndFunc   ;==>Example

Func _checktuhoiguild()
   Local $scheckboxtuhoiguild = IniRead($path&$Title&".tmp", $hoatdong, $tuhoiguild8h, False)
   Local $statustuhoiguild = IniRead($path&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
   If $scheckboxtuhoiguild == True And $statustuhoiguild <> $done Then
	   Local $Now = _getCurrentTime();time hien tai
	   Local $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("19:35", "[:]", "")
	   Local $timewait = StringRegExpReplace("19:26", "[:]", "")
	   Local $timeend = StringRegExpReplace("20:00", "[:]", "")
	   ;check het time boss guild chua
	   If $var1 > $timeend Then
		  writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  Return
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 Return 1
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  Return 1
	   EndIf
	   If $var1 > $timewait And $var1 < $timeend Then
		  Local $wait = 1935 - $var1
		  writelog("Cho "&$wait &" phut vo tu hoi guild"& @CRLF) ; write console
		  Sleep($wait*60000)
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 Return 1
		  EndIf
		  IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  Return 1
	   EndIf
   EndIf


EndFunc   ;==>Example

Func _openMenu()
	   $ImagePath = @ScriptDir & "\image\nhatkihd.bmp"
	   $Result = _HandleImgSearch($hwnd, $ImagePath, 0, 0, -1, -1,50, 2);search nhat ki hd
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


EndFunc   ;==>Open menu

 Func _ADB_Command($Command, $WorkingDir = @ScriptDir)
    $DOS = Run($Nox_Path & "\" & $Command, $Nox_Path, @SW_HIDE, $STDERR_MERGED)
    While 1
        Sleep(50)
        If @error Or Not ProcessExists($DOS) Then ExitLoop
    WEnd
    $Message = StdoutRead($DOS)
    Return $Message
 EndFunc   ;==>_ADB_Command

Func _searchNV($Handle, $imagepath, $tor = 115 , $sizeSan = 6)
	  Local $i = 0
	  While $i < $sizeSan
		 $i = $i + 1
		 Local $Result = _HandleImgWaitExist($Handle, $imagepath,1, 0, 0, -1, -1,$tor, 2);search nv can tim
		 If not @error Then ; neu thay nv out
			Return $Result
		 Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 510 800"); di chuyen cuon len 1 chut
			Sleep(1700)
		 EndIf
	  WEnd
	  Return SetError(3) ; ko tim thay return error
EndFunc   ;==> Search NV
Func _getNameCharacter()
	   $rs = _openMenu()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return 1
	   EndIf
	   _close($hwnd)
	   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 100 69") ;click to icon nhan vat
	   Sleep(1000)
	   Local $BMP = _HandleCapture($hwnd, 473, 152, 85, 20, True);32 bit map
	   ;convert to 24 bitmap
	   $iX = _GDIPlus_ImageGetWidth($BMP)
	   $iY = _GDIPlus_ImageGetHeight($BMP)
	   Local $hBitmap_Scaled = _GDIPlus_ImageResize($BMP, $iX*2, $iY*2) ;resize image

	   $hClone = _GDIPlus_BitmapCloneArea($hBitmap_Scaled, 0, 0, $iX*2, $iY*2, $GDIP_PXF24RGB)
	   _GDIPlus_ImageSaveToFile($hClone,$pathAuto&$Title&".bmp")
	   $loadname = True
	   ;execute OCR
	   ShellExecuteWait($pathOCR, @SW_HIDE)
	   Return 1
	EndFunc   ;==> Get Name Character
Func _checkExpireDate()
	  Local $currentDate = _getCurrentDate() ;MM/DD/YYYY
	   $current = StringRegExpReplace($currentDate, "[/]", "")
	   $expire = StringRegExpReplace($expireDate, "[/]", "")
	   If $current > $expire Then Return SetError(3)
	   EndFunc   ;==> Get Name Character

Func _resetStatus()
     IniWrite($path&$Title&".tmp", $status, $huyencanh, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $blood, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $bosscanhan, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $tienthuong, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $daomo, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $cuopmo, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $treomay, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $nvguild, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $tinhanh, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $laythanhvat, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $bossguild12h, $notyet)
	 IniWrite($path&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
  EndFunc

Func _startAndLogin()
     While 1
		Local $Imageicon = @ScriptDir & "\image\iconMuVTD.bmp"
	    Local $Result = _HandleImgSearch($hwnd, $Imageicon, 0, 0, -1, -1,100, 2);search icon MU
		If not @error Then ; neu thay nv out
		    writelog("Game san sang " & _NowTime() & @CRLF) ; write console
			Sleep(2000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(1000);
			ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
			ExitLoop
	    Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(5000) ;cho 5s
			Local $Imagewait = @ScriptDir & "\image\wait.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   ControlClick($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
		 EndIf
		 ;icon lon
	    Local $Imageiconbig = @ScriptDir & "\image\iconMuVTDbig.bmp"
	    Local $Result = _HandleImgSearch($hwnd, $Imageiconbig, 0, 0, -1, -1,100, 2);search icon MU big
		If not @error Then ; neu thay nv out
		    writelog("Game san sang " & _NowTime() & @CRLF) ; write console
			Sleep(3000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(1000);
			ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
			Sleep(3000)
			Opt("WinTitleMatchMode", 3)
			WinMove($Title, "",Default ,Default , 849, 509) ;resize auto
			ExitLoop
	    Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(5000) ;cho 5s
			Local $Imagewait = @ScriptDir & "\image\waitBig.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   ControlClick($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
	    EndIf
	 WEnd
	 Local $ImageiconTK = @ScriptDir & "\image\icontaikhoan.bmp"
     Local $ResultTK = _HandleImgWaitExist($hwnd, $ImageiconTK,180, 0, 0, -1, -1,70, 2);search icon Tai Khoan
	 If not @error Then
		 writelog("Dang Nhap " & _NowTime() & @CRLF) ; write console
		 Sleep(4000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 669") ;click to dang nhap
		 Sleep(5000)
		 Local $Imagepath = @ScriptDir & "\image\iconchonNV.bmp"
		 Local $ResultChonNV = _HandleImgWaitExist($hwnd, $Imagepath,20, 0, 0, -1, -1,70, 2);search icon back
		 If not @error Then ;thay icon chon nhan vat
			writelog("Bat dau " & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 800") ;click to bat dau
			Sleep(20000)
			Local $ImagePath2 = @ScriptDir & "\image\thietlaptreomay.bmp"
			$Result = _HandleImgWaitExist($hwnd, $ImagePath2,10, 0, 0, -1, -1,70, 2);search thiet lap treo may
			If Not @error Then ; ko thay thiet lap
			   Opt("WinTitleMatchMode", 3)
			   ControlClick($Title, "", "","", 1,$Result[1][0]+275, $Result[1][1]) ; click xac nhan
			EndIf
			Local $ImagePath3 = @ScriptDir & "\image\close2.bmp"
			$Result2 = _HandleImgWaitExist($hwnd, $ImagePath3,10, 0, 0, -1, -1,80, 2);search close button 2 trong 15s
			If not @error Then ; ko thay close
			   Opt("WinTitleMatchMode", 3)
			   ControlClick($Title, "", "","", 1,$Result2[1][0], $Result2[1][1]) ; click close
			EndIf
		 Else
		 EndIf
      Else
		 writelog("Ko thay icon dang nhap " & _NowTime() & @CRLF) ; write console
	  EndIf

EndFunc