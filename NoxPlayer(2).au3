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
Global Const $expireDate = "06/25/2021" ; format MM/DD/YYYY
;dir config file
Global Const $path = @ScriptDir&"\hoatdong\"
Global Const $pathstatus = @ScriptDir&"\status\"
Global Const $pathAuto = @ScriptDir&"\auto\"
Global Const $pathImage = @ScriptDir&"\image\"
Global Const $pathLog = @ScriptDir&"\log\"
Global Const $pathOCR = @ScriptDir&"\OCR.jar"
Global Const $OCRFlag = "OCR"
Global Const $general = "General"
Global Const $hardmode = "HardMode"
Global Const $noxpath = "NoxPath"
Global Const $anExp = "AnDonExp"
Global Const $camtrain = "CamTrain"
Global Const $ghepveblood = "GhepVeBlood"
Global Const $autoAnThit = "AutoAnThit"
Global Const $autoTruyenCong = "TruyenCong"
Global Const $boquaQuestS = "$BoQuaQuestS"
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
Global Const $devil = "Devil"
Global Const $baotang = "BaoTang"
Global Const $phaodai = "PhaoDai"
Global Const $hotroguild = "HoTroGuild"
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

;~   ControlSend($hwAuto, "", "Edit1",$Title & ": " & $textlog) ; log UI
  Local $hFileOpen = FileOpen($pathLog&$Title&".log", $FO_APPEND)
  If $hFileOpen = -1 Then
	 MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
  Else
     FileWriteLine($hFileOpen, $Title & ": " & $textlog)
  EndIf
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
Global $huyencanhDone = False
Global $bloodDONE = False;
Global $BossCaNhanDONE = false;
Global $NVTIENTHUONGDONE = false;
Global $DaoMoDone = false;
Global $CuopMoDone = false;
Global $TrainQuai = false;
Global $NVGuide = false;
Global $NVTinhAnh = false;
Global $LayThanhVatDone = false;
Global $Boss12hDone = false;
Global $TuhoiDone = false;
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
If Mod($count, 50) = 0 Then ;boi so cua 50 thi show log
   writelog("Auto Vong "&$count&" bat dau" &@CRLF) ; write console
EndIf
Sleep(500)
 Auto()
 If @error Then
   ExitLoop
 EndIf
WEnd
writelog("Het NV ---Stop auto...."&$Title&" tại Loop "&$count & _NowTime() & @CRLF) ; write console
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
   ;~    #cs
   ;~ 	 Dao mo
   ;~ 	#ce
    Local $sReaddaomo = IniRead($path&$Title&".tmp", $hoatdong, $daomo, False)
    Local $statusdaovo = IniRead($pathstatus&$Title&".tmp", $status, $daomo, $notyet)
	If $sReaddaomo == True And $statusdaovo <> $done Then
	   $countNV = $countNV + 1
	   If _NowCalc() > $sNewTime Then
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $daomo,$doing) ; change status running
		  $sNewTime = GotoDaoMo($Title,$emuport,$hwnd) ; di dao mo #daomo.au3
		  If @error Then
			 writelog("1. DA HET LUOT DAO MO...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $daomo,$done) ; change status done
		  Else
			 IniWrite($pathstatus&$Title&".tmp", $status, $daomo,$notyet) ; change status wait
		  EndIf
	   EndIf
	Sleep(2000)
	EndIf
	;nv thuong ngay
	#cs
	2.Di Huyen Canh tren khong
	#ce
	Sleep(1000)
;~ 	If $huyencanhDone == False Then
	  Local $sReadhuyencanh = IniRead($path&$Title&".tmp", $hoatdong, $huyencanh, False)
	  Local $statushuyencanh = IniRead($pathstatus&$Title&".tmp", $status, $huyencanh, $notyet)
	  If $sReadhuyencanh == True And $statushuyencanh <> $done Then
		 $countNV = $countNV + 1
		 $rs = _openHoatDong()
		 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		 EndIf
	  IniWrite($pathstatus&$Title&".tmp", $status, $huyencanh,$doing) ; change status running
	  GotoPBHuyenCanh($Title,$emuport,$hwnd) ;huyencanh.au3--Di huyen canh
	  If @error Then
		  writelog("2. DA HET LUOT HUYEN CANH...." & _NowTime() & @CRLF) ; write console
		  IniWrite($pathstatus&$Title&".tmp", $status, $huyencanh,$done) ; change status done
		  $huyencanhDone = True
	  Else
		  IniWrite($pathstatus&$Title&".tmp", $status, $huyencanh,$notyet) ; change status wait
	  EndIf
	  Sleep(1500)
	  EndIf
;~ 	EndIf

   #cs
	3.Di Blood castle
	#ce
;~ 	If $bloodDONE == False Then
	   Local $sReadblood = IniRead($path&$Title&".tmp", $hoatdong, $blood, False)
	   Local $statusblood = IniRead($pathstatus&$Title&".tmp", $status, $blood, $notyet)
	   If $sReadblood == True And $statusblood <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $blood,$doing) ; change status running
		  GotoPBBlood($Title,$emuport,$hwnd) ;blood #blood.au3
		  If @error Then
			 writelog("3. DA HET LUOT BLOOD...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $blood,$done) ; change status
			 $bloodDONE = True
		  Else
			 IniWrite($pathstatus&$Title&".tmp", $status, $blood,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
    #cs
	4. cuop mo
	#ce
;~ 	  If $CuopMoDone == False Then
		 Local $sReadcuopmo = IniRead($path&$Title&".tmp", $hoatdong, $cuopmo, False)
		 Local $statuscuopmo = IniRead($pathstatus&$Title&".tmp", $status, $cuopmo, $notyet)
		  If $sReadcuopmo == True And $statuscuopmo <> $done Then
			 $countNV = $countNV + 1
			 $rs = _openHoatDong()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $cuopmo,$doing) ; change status running
			 $resultcuopmo = GotoCuopMo($Title,$emuport,$hwnd) ; di dao mo #daomo.au3
			 If @error Then
				writelog("4. DA HET LUOT CUOP MO...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $cuopmo,$done) ; change status done
				$CuopMoDone = True
			 Else
				IniWrite($pathstatus&$Title&".tmp", $status, $cuopmo,$notyet) ; change status done
			 EndIf
			 Sleep(2000)
		  EndIf
;~ 	  EndIf
   #cs
	5.boss ca nhan
	#ce
;~ 	If $BossCaNhanDONE == False Then
	   Local $checkboxbosscanhan = IniRead($path&$Title&".tmp", $hoatdong, $bosscanhan, False)
	   Local $statusbosscanhan = IniRead($pathstatus&$Title&".tmp", $status, $bosscanhan, $notyet)
	   If $checkboxbosscanhan == True And $statusbosscanhan <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $bosscanhan,$doing) ; change status running
		  _GotoPBBossCaNhan($Title,$emuport,$hwnd) ;boss ca nhan # bosscanhan.au3
		  If @error Then
			 writelog("5. DA HET LUOT BOSS CA NHAN...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $bosscanhan,$done) ; change status done
			 $BossCaNhanDONE = True
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bosscanhan,$notyet) ; change status wait
		  EndIf
	   Sleep(2000)
	   EndIf
;~ 	EndIf


;~    #cs
;~ 	6.Di NV tien thuong
;~ 	#ce
;~    If $NVTIENTHUONGDONE == False Then
	  Local $scheckboxtienthuong = IniRead($path&$Title&".tmp", $hoatdong, $tienthuong, False)
	  Local $statustienthuong = IniRead($pathstatus&$Title&".tmp", $status, $tienthuong, $notyet)
	   If $scheckboxtienthuong == True And $statustienthuong <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $tienthuong,$doing) ; change status running
		  GotoNVTienThuong($Title,$emuport,$hwnd,$pos) ; di pb nvtienthuong #nvthienthuong.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $tienthuong,$done) ; change status done
			 writelog("6. DA HET LUOT NV TIEN THUONG...." & _NowTime() & @CRLF) ; write console
			 $NVTIENTHUONGDONE = True
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $tienthuong,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
;~    EndIf



    #cs
	7. train quai
	#ce
;~ 	If $TrainQuai == False Then
	   Local $scheckboxtreomay = IniRead($path&$Title&".tmp", $hoatdong, $treomay, False)
	   Local $statustreomay = IniRead($pathstatus&$Title&".tmp", $status, $treomay, $notyet)
	   If $scheckboxtreomay == True And $statustreomay <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $treomay,$doing) ; change status running
		  _GotoTrainQuai($Title,$emuport,$hwnd,$pos) ; train quai #nvtienthuong.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $treomay,$done) ; change status done
			 writelog("7. Hoan Thanh Train Quai...." & _NowTime() & @CRLF) ; write console
			 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			 $TrainQuai = True
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $treomay,$notyet) ; change status wait
		   EndIf
		  Sleep(2000)
	   EndIf
;~ 	EndIf



	#cs
	8. NV guild
	#ce
;~ 	If $NVGuide == False Then
	   Local $scheckboxnvguild = IniRead($path&$Title&".tmp", $hoatdong, $nvguild, False)
	   Local $statusnvguild = IniRead($pathstatus&$Title&".tmp", $status, $nvguild, $notyet)
	   If $scheckboxnvguild == True And $statusnvguild <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $nvguild,$doing) ; change status running
		  _GotoNVGuide($Title,$emuport,$hwnd,$pos) ; nv guide #nvtienthuong.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $nvguild,$done) ; change status done
			 writelog("8. Hoan Thanh NV Guide...." & _NowTime() & @CRLF) ; write console
			 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			 $NVGuide = True
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $nvguild,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
;~ 	EndIf



	#cs
	9. San Tinh Anh
	#ce
;~ 	If $NVTinhAnh == False Then
	   Local $scheckboxtinhanh = IniRead($path&$Title&".tmp", $hoatdong, $tinhanh, False)
	   Local $statustinhanh = IniRead($pathstatus&$Title&".tmp", $status, $tinhanh, $notyet)
	   If $scheckboxtinhanh == True And $statustinhanh <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $tinhanh,$doing) ; change status doing
		  _GotoNVTinhAnh($Title,$emuport,$hwnd) ; nv tinh anh #tinhanh
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $tinhanh,$done) ; change status done
			 writelog("9. Hoan Thanh NV Tinh Anh...." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $tinhanh,$notyet) ; change status wait
		   EndIf
		  Sleep(2000)
	   EndIf
;~ 	EndIf


	#cs
	10. Lay Thanh Vat
	#ce
;~ 	If $LayThanhVatDone == False Then
	   Local $scheckboxlaythanhvat = IniRead($path&$Title&".tmp", $hoatdong, $laythanhvat, False)
	   Local $statuslaythanhvat = IniRead($pathstatus&$Title&".tmp", $status, $laythanhvat, $notyet)
	   If $scheckboxlaythanhvat == True And $statuslaythanhvat <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$doing) ; change status doing
		  _GotoLayThanhVat($Title,$emuport,$hwnd) ; nv lay thanh vat #laythanhvat
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$done) ; change status done
			 writelog("10. Hoan Thanh Lay Thanh Vat..." & _NowTime() & @CRLF) ; write console
		   Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$notyet) ; change status wait
		   EndIf
		  Sleep(2000)
	   EndIf
;~ 	EndIf



	#cs
	11. Boss guild 12h
	#ce
	  Local $scheckboxbossguild12h = IniRead($path&$Title&".tmp", $hoatdong, $bossguild12h, False)
	  Local $statusbossguild12h = IniRead($pathstatus&$Title&".tmp", $status, $bossguild12h, $notyet)
	  If $scheckboxbossguild12h == True And $statusbossguild12h <> $done Then
		  $countNVHenGio = $countNVHenGio + 1 ; van con nv de lam
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("11:59", "[:]", "")
		  Local $timeend = StringRegExpReplace("12:10", "[:]", "")
		  ;check het time boss guild chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 $Boss12hDone = True
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 $rs = _openMenu()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
			 _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
				$Boss12hDone = True
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 $Boss12hDone = True
		  EndIf
	   EndIf

	#cs
	12. Tu Hoi Guild + Boss Guild 8h
	#ce
;~ 	If $TuhoiDone == False Then
	  Local $scheckboxtuhoiguild = IniRead($path&$Title&".tmp", $hoatdong, $tuhoiguild8h, False)
	  Local $statustuhoiguild = IniRead($pathstatus&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
	  If $scheckboxtuhoiguild == True And $statustuhoiguild <> $done Then
		  $countNVHenGio = $countNVHenGio + 1 ; van con nv de lam
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("19:35", "[:]", "")
		  Local $timeend = StringRegExpReplace("20:00", "[:]", "")
		  ;check het time boss guild chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 $rs = _openMenu()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
			 _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  EndIf
	  EndIf
;~ 	EndIf
    #cs
	13. Devil Square
	#ce
	  $dayofweek = _getDayofWeek()
	  If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
	  Local $scheckboxDevil = IniRead($path&$Title&".tmp", $hoatdong, $devil, False)
	  Local $statusDevil = IniRead($pathstatus&$Title&".tmp", $status, $devil, $notyet)
	  If $scheckboxDevil == True And $statusDevil <> $done Then
		  $countNVHenGio = $countNVHenGio + 1 ; van con nv de lam
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("20:30", "[:]", "")
		  Local $timeend = StringRegExpReplace("23:30", "[:]", "")
		  ;check het time boss guild chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Vao Devil Square...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $devil,$done) ; change status done
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 $rs = _openMenu()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $devil,$doing) ; change status doing
			 _GotoDevilSquare($Title,$emuport,$hwnd) ; Devil Square #blood.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Devil Square...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $devil,$done) ; change status done
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $devil,$done) ; change status done
		  EndIf
	   EndIf
	EndIf
	#cs
	14. Hộ Tống Bảo Tàng
	#ce
	   Local $scheckboxBaoTang = IniRead($path&$Title&".tmp", $hoatdong, $baotang, False)
	   Local $statusBaoTang = IniRead($pathstatus&$Title&".tmp", $status, $baotang, $notyet)
	   If $scheckboxBaoTang == True And $statusBaoTang <> $done Then
		  $countNVHenGio = $countNVHenGio + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $baotang,$doing) ; change status doing
		  _GotoHoTongBaoTang($Title,$emuport,$hwnd) ; nv hộ tống #laythanhvat
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $baotang,$done) ; change status done
			 writelog("Hoan Thanh Ho Tong Bao Tang..." & _NowTime() & @CRLF) ; write console
		   Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $baotang,$notyet) ; change status wait
		   EndIf
		  Sleep(2000)
	   EndIf
	   #cs
	16. Hotro Guild
	#ce
	   Local $scheckboxhotro = IniRead($path&$Title&".tmp", $hoatdong, $hotroguild, False)
	   If $scheckboxhotro == True Then
		  $countNVHenGio = $countNVHenGio + 1
		  _findIconMenu($hwnd)
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $hotroguild,$doing) ; change status doing
		  _GotoHoTroGuild($Title,$emuport,$hwnd) ; nv ho tro guild in tinhanh.au3
		  IniWrite($pathstatus&$Title&".tmp", $status, $hotroguild,$notyet) ; change status wait
		  Sleep(2000)
	   EndIf
	Sleep(2000)
	;Xu Li Het Auto
   If $countNV == 0 Then ; het nv de lam
	  If $resetNV < 1 Then
		 $resetNV = $resetNV + 1
		 _anDanExp()
		 _diCamTrain()
		 _resetStatus()
		 writelog("Reset auto lan "&$resetNV& @CRLF) ; write console
		 Return ;next
	  EndIf
   EndIf
   If $countNV == 0 And $countNVHenGio == 0 Then ; het nv ngay va nv hen gio thi stop auto
	  writelog("Het NV "& @CRLF) ; write console
	  SetError(3)
   EndIf
EndFunc   ;==>Auto
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

	   $rsphaodai = _checkPhaoDaiDo()
	   If $rsphaodai == 1 Then ;  phao dai do  = 1 thi next loop
		  Return 1
	   EndIf
EndFunc   ;==>Example

Func _checkbossguild()
;~    If $Boss12hDone = False Then
	  Local $scheckboxbossguild12h = IniRead($path&$Title&".tmp", $hoatdong, $bossguild12h, False)
	  Local $statusbossguild12h = IniRead($pathstatus&$Title&".tmp", $status, $bossguild12h, $notyet)
	  If $scheckboxbossguild12h == True And $statusbossguild12h <> $done Then
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("11:59", "[:]", "")
		  Local $timewait = StringRegExpReplace("11:50", "[:]", "")
		  Local $timeend = StringRegExpReplace("12:10", "[:]", "")
		  ;check het time boss guild chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 $Boss12hDone = True
			 Return
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
			 _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
				$Boss12hDone = True
				Return 1
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 $Boss12hDone = True
			 Return 1
		  EndIf
		  If $var1 > $timewait And $var1 < $timeend Then
			 Local $wait = 1160 - $var1
			 writelog("Cho "&$wait &" phut vo boss guild 12 gio"& @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$doing) ; change status doing
			 Sleep($wait*60000)
			 _GotoNVBossGuild($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
				$Boss12hDone = True
				Return 1
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h,$done) ; change status done
			 $Boss12hDone = True
			 Return 1
		  EndIf
	   EndIf
;~    EndIf



EndFunc   ;==>Example

Func _checktuhoiguild()

   Local $scheckboxtuhoiguild = IniRead($path&$Title&".tmp", $hoatdong, $tuhoiguild8h, False)
   Local $statustuhoiguild = IniRead($pathstatus&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
   If $scheckboxtuhoiguild == True And $statustuhoiguild <> $done Then
	   Local $Now = _NowTime(4);time hien tai
	   Local $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("19:35", "[:]", "")
	   Local $timewait = StringRegExpReplace("19:26", "[:]", "")
	   Local $timeend = StringRegExpReplace("20:00", "[:]", "")
	   ;check het time boss guild chua
	   If $var1 > $timeend Then
		  writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  $TuhoiDone == True
		  Return 1
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 $TuhoiDone == True
			 Return 1
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  $TuhoiDone == True
		  Return 1
	   EndIf
	   If $var1 > $timewait And $var1 < $timeend Then
		  Local $wait = 1935 - $var1
		  writelog("Cho "&$wait &" phut vo tu hoi guild"& @CRLF) ; write console
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  Sleep($wait*60000)
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 $TuhoiDone == True
			 Return 1
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  $TuhoiDone == True
		  Return 1
	   EndIf
   EndIf


EndFunc   ;==>Example
Func _checkPhaoDaiDo()
	  $dayofweek = _getDayofWeek()
	  If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
	  Local $scheckboxphaodai = IniRead($path&$Title&".tmp", $hoatdong, $phaodai, False)
	  Local $statusphaodai = IniRead($pathstatus&$Title&".tmp", $status, $phaodai, $notyet)
	  If $scheckboxphaodai == True And $statusphaodai <> $done Then
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("20:30", "[:]", "")
		  Local $timewait = StringRegExpReplace("20:25", "[:]", "")
		  Local $timeend = StringRegExpReplace("20:35", "[:]", "")
		  ;check het time boss guild chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Phao Dai...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
			 Return
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$doing) ; change status doing
			 _GotoPhaoDaiDo($Title,$emuport,$hwnd) ;Phao Dai Do #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Phao Dai...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
				Return 1
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
			 Return 1
		  EndIf
		  If $var1 > $timewait And $var1 < $timeend Then
			 Local $wait = 2030 - $var1
			 writelog("Cho "&$wait &" phut vo phao dai"& @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$doing) ; change status doing
			 Sleep($wait*60000)
			 _GotoPhaoDaiDo($Title,$emuport,$hwnd) ;Boss guild #tinhanh.au3
			 If @error Then
				writelog("Het Thoi Gian Vao Boss Guild...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
				Return 1
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
			 Return 1
		  EndIf
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
		  writelog("Menu san sang "& @CRLF) ; write console
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

Func _searchNVAdvance($Handle, $imageHet, $imageCon,$torHet = 115, $torCon = 115 , $sizeSan = 6)
	  Local $i = 0
	  While $i < $sizeSan
		 $i = $i + 1
		 $Result = _HandleImgWaitExist($Handle, $imageHet,1, 0, 0, -1, -1,$torHet, 2);search image het luot
		 If not @error Then ; neu thay image het NV -> out
			 Return SetError(3)
		 Else
			 $Result = _HandleImgWaitExist($Handle, $imageCon,1, 0, 0, -1, -1,$torCon, 2);search image con luot
			 If not @error Then
				Return $Result
			 EndIf
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 510 800"); di chuyen cuon len 1 chut
			Sleep(1800)
		 EndIf
	  WEnd
	  _closeSimple($Handle)
	  Return 2 ; ko tim thay hinh nao het return 2
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
     IniWrite($pathstatus&$Title&".tmp", $status, $huyencanh, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $blood, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $bosscanhan, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $tienthuong, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $daomo, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $cuopmo, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $treomay, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $nvguild, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $tinhanh, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $bossguild12h, $notyet)
	 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h, $notyet)
EndFunc
Func _anDanExp()
   Local $flagAnExp = IniRead($pathImage&"1.tmp", $general, $anExp, ""); check flag an exp
   If $flagAnExp <> True Then Return
   ;check an Dan
   _findIconMenu($hwnd)
   Local $count = 0
   While $count < 5
	  $count = $count + 1
	  Local $ImageIconBalo = @ScriptDir & "\image\iconBalo.bmp"
	  Local $Result = _HandleImgWaitExist($hwnd, $ImageIconBalo,2, 687, 328, 45, 45,80, 2);search balo
	  If not @error Then ; thay balo -> click
		 writelog("Thay Balo" & @CRLF) ; write console
		 ControlClick($Title, "", "","", 1,$Result[1][0]+687, $Result[1][1]+328) ; click balo
		 Sleep(2000)
		 ;search Dan Exp
		 While 1
			;search exp lon
			Local $Imageexplon = @ScriptDir & "\image\expLon.bmp"
			$Result = _HandleImgWaitExist($hwnd,$Imageexplon,1, 0, 0, -1, -1,90, 10);search exp lon
			If not @error Then ; thay exp -> click
			   ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo exp Lon
			   Sleep(1000)
			   Local $Imagesudungbtn = @ScriptDir & "\image\thembtn.bmp"
			   $Result = _HandleImgWaitExist($hwnd,$Imagesudungbtn,1, 0, 0, -1, -1,90, 10);search btn su dung
			   If not @error Then ; thay su dung btn -> click
				  ControlClick($Title, "", "","", 1,$Result[1][0]+200, $Result[1][1]) ; click su dung btn
				  Sleep(1000)
				  ContinueLoop
			   EndIf
			EndIf
			;search exp nho
			Local $Imageexpnho = @ScriptDir & "\image\expNho.bmp"
			$Result = _HandleImgWaitExist($hwnd,$Imageexpnho,1, 0, 0, -1, -1,90, 10);search exp nho
			If not @error Then ; thay exp -> click
			   ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo exp nho
			   Sleep(1000)
			   Local $Imagesudungbtn = @ScriptDir & "\image\thembtn.bmp"
			   $Result = _HandleImgWaitExist($hwnd,$Imagesudungbtn,1, 0, 0, -1, -1,90, 10);search btn su dung
			   If not @error Then ; thay su dung btn -> click
				  ControlClick($Title, "", "","", 1,$Result[1][0]+200, $Result[1][1]) ; click su dung btn
				  Sleep(1000)
				  ContinueLoop
			   EndIf
			EndIf
			writelog("Da an het dan exp" & @CRLF) ; write console
			ExitLoop
		 WEnd
		 _close($hwnd)
		 Return
	  Else
		 _close($hwnd)
		 _ADB_Command_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1523 821") ; click vo kiem
		 Sleep(1000)
	  EndIf

   WEnd
EndFunc
Func _diCamTrain()
   Local $flagCamTrain = IniRead($pathImage&"1.tmp", $general, $camtrain, ""); check flag an exp
   If $flagCamTrain <> True Then Return
   $rs = _openMenu()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return 1
	   EndIf
   Local $Imagetreomayhetluot = @ScriptDir & "\image\treomayhetluot.bmp"
   Local $p = _searchNV($hwnd, $Imagetreomayhetluot) ; search NV treo may het luot
   If @error Then
	  Return
   Else
	  writelog("Di treo may" & @CRLF) ; write console
	  ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(20000);Cho 20s
   EndIf
EndFunc
Func _findIconMenu($Handle)
   While 1 ;tim den khi thay menu
	 Local $ImagePath = @ScriptDir & "\image\menu.bmp"
	 Local $Result = _HandleImgWaitExist($Handle, $ImagePath,1, 0, 0, -1, -1,94, 2);search nut menu
	  If @error Then ; ko thay menu
		  writelog("Tim kiem menu " & @CRLF) ; write console
		  _close($Handle); close all window
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 450") ;click giua man hinh
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
		 ExitLoop
	  EndIf
   WEnd
EndFunc

Func _startAndLogin()
   Local $count = 0
     While 1 ;buoc vo game
		$count = $count + 1
		If $count > 60 Then
		   MsgBox(0,"","Lỗi không thể tự động đăng nhập. Vui lòng đăng nhập thủ công")
		   IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
		   Exit 0
		EndIf

		Local $Imageicon = @ScriptDir & "\image\iconMuVTD.bmp"
	    Local $Result = _HandleImgSearch($hwnd, $Imageicon, 0, 0, -1, -1,100, 2);search icon MU
		If not @error Then ; neu thay nv out
		    writelog("Game san sang " & _NowTime() & @CRLF) ; write console
			Sleep(2000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(1000);
			Local $Imagewait = @ScriptDir & "\image\wait.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   ControlClick($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
			Sleep(2000)
			ControlClick($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
			ExitLoop
	    Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(4000) ;cho 5s
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
			Sleep(4000) ;cho 5s
			Local $Imagewait = @ScriptDir & "\image\waitBig.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   ControlClick($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
	    EndIf
	 WEnd
	 Local $count = 0
	 While 1 ;buoc dang nhap
		$count = $count + 1
		If $count > 50 Then
		   MsgBox(0,"","Lỗi không thể tự động đăng nhập. Vui lòng đăng nhập thủ công")
		   IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
		   Exit 0
		EndIf
		 Local $ImageiconTK = @ScriptDir & "\image\icontaikhoan.bmp"
		 Local $ResultTK = _HandleImgWaitExist($hwnd, $ImageiconTK,2, 0, 0, -1, -1,70, 2);search icon Tai Khoan
		 If not @error Then
			Sleep(5000)
			ExitLoop
		 Else
			_closeSimple($hwnd)
			Sleep(5000)
		 EndIf
	  WEnd
		 writelog("Dang Nhap " & _NowTime() & @CRLF) ; write console
		 Sleep(4000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 669") ;click to dang nhap
		 Sleep(5000)
		 Local $Imagepath = @ScriptDir & "\image\iconchonNV.bmp"
		 Local $ResultChonNV = _HandleImgWaitExist($hwnd, $Imagepath,20, 0, 0, -1, -1,70, 2);search icon back
		 If not @error Then ;thay icon chon nhan vat
			writelog("Chon nhan vat dau tien " & _NowTime() & @CRLF) ; write console
			Sleep(3000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 145 232") ;click to icon nhan vat dau tien
			writelog("Bat dau ---- loading vo game " & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 800") ;click to bat dau
			Sleep(60000); cho 60s
			Local $ImagePath2 = @ScriptDir & "\image\thietlaptreomay.bmp"
			$Result = _HandleImgWaitExist($hwnd, $ImagePath2,5, 0, 0, -1, -1,70, 2);search thiet lap treo may
			If Not @error Then ; ko thay thiet lap
			   Opt("WinTitleMatchMode", 3)
			   ControlClick($Title, "", "","", 1,$Result[1][0]+275, $Result[1][1]) ; click xac nhan
			EndIf
			Local $ImagePath3 = @ScriptDir & "\image\close2.bmp"
			$Result2 = _HandleImgWaitExist($hwnd, $ImagePath3,5, 0, 0, -1, -1,80, 2);search close button 2 trong 15s
			If not @error Then ; ko thay close
			   Opt("WinTitleMatchMode", 3)
			   ControlClick($Title, "", "","", 1,$Result2[1][0], $Result2[1][1]) ; click close
			EndIf
		 Else
		 EndIf
EndFunc