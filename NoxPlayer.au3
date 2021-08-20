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
#include <File.au3>
#include <WinAPI.au3>
AutoItSetOption ("TrayIconDebug", 1);0-off
HotKeySet("+{Esc}", "_Exit") ; Press Shift + ESC for exit
Func _Exit()
	Exit 0
 EndFunc   ;==>_Exit
 ;config start
If $CmdLine[0] == 0 Then
   Global $Title =  StringSplit(@ScriptName,'.')[1] ;get script name : example Noxplayer
Else
   Global $Title =  $CmdLine[1]
EndIf
Sleep(200)
Global $isLDPlayer = False ; default is NoxPlayer
isLDPlayer()
Global $scale = _GetDPI_Ratio()
Global $flag_in_game = False
;dir config file
Global Const $path = @ScriptDir&"\hoatdong\"
Global Const $pathconfig = @ScriptDir&"\config\"
Global Const $pathstatus = @ScriptDir&"\status\"
Global Const $pathAuto = @ScriptDir&"\auto\"
Global Const $pathImage = @ScriptDir&"\image\"
Global Const $pathLog = @ScriptDir&"\log\"
Global Const $pathOCR = @ScriptDir&"\OCR.jar"
Global Const $adbpath = @ScriptDir&"\adb"
Global Const $pathDapan = @ScriptDir&"\image\dapan.ini"
Global Const $pathCauHoi = @ScriptDir&"\image\cauhoi"
Global Const $OCRFlag = "OCR"
Global Const $debug = "Debug"
Global Const $general = "General"
Global Const $hardmode = "HardMode"
Global Const $noxpath = "NoxPath"
Global Const $ldplayerpath = "LDPlayerPath"
Global Const $anExp = "AnDonExp"
Global Const $camtrain = "CamTrain"
Global Const $ghepveblood = "GhepVeBlood"
Global Const $autoAnThit = "AutoAnThit"
Global Const $autoTruyenCong = "TruyenCong"
;config hoat dong/status start
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
Global Const $bossthegioi = "BossTheGioi"
Global Const $bosschientruong = "BossChienTruong"
Global Const $mahoa = "MaHoa"
Global Const $chinhtuyen = "ChinhTuyen"
Global Const $dialao = "DiaLao"
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

;config path start
Global Const $config = "Configuration"
Global Const $nvguildRankS = "NvGuildRankS"
Global Const $nvguilddoi3nguoi = "NVGuildDoi3ng"
Global Const $timewaitNvS = "WaitNvS"
Global Const $weaktinhanh = "WeakTinhAnh"
Global Const $baotang11h = "BaoTang11h"
Global Const $baotang21h = "BaoTang21h"
Global Const $spbossTG = "SpBossTG"
Global Const $spbossctc = "SpBossCTC"
Global Const $spcuopmo = "SpCuopMo"
Global Const $sp_nvguildRankS = "SpNvGuildRankS"
Global Const $sp_timewaitNvS = "SpWaitNvS"
Global Const $cuop_mo_de = "MoDe"
Global Const $cuop_mo_thuong = "MoThuong"
Global Const $cuop_mo_kho = "MoKho"
Global Const $cuop_mo_trang = "MoTrang"
Global Const $cuop_mo_xanh = "MoXanh"
Global Const $cuop_mo_tim = "MoTim"
Global Const $cuop_mo_do = "MoDo"
Global Const $bossTG_top1= "BossTGTop1"
Global Const $bossTG_top2 = "BossTGTop2"
Global Const $bossTG_top3 = "BossTGTop3"
Global Const $bosCTC_boss1 = "BossCTCBoss1"
Global Const $bosCTC_boss2 = "BossCTCBoss2"
Global Const $bosCTC_boss3 = "BossCTCBoss3"
Global Const $bosCTC_boss4 = "BossCTCBoss4"
Global Const $bosCTC_boss5 = "BossCTCBoss5"
Global Const $bosCTC_boss6 = "BossCTCBoss6"
Global Const $traloicauhoi= "TraLoiCauHoi"
;config path EndFunc

#Region debug
Global Const $noxplayer = "Nox"
Global Const $ldplayer = "LD"
Global Const $tolerance_menu = "Tolerance_Menu"
Global Const $tolerance_thoatpb = "Tolerance_Thoatpb"
Global Const $tolerance_close = "Tolerance_Close"
Global Const $tolerance_nvtienthuong = "Tolerance_NvTienthuong"
;write config
;~ IniWrite($pathImage&"tolerance.ini", $noxplayer, $tolerance_menu,94) ;
;~ IniWrite($pathImage&"tolerance.ini", $ldplayer, $tolerance_menu,103) ;
;get properties
Global $x_toler_menu = 94
Global $x_toler_thoatpb = 85
Global $x_toler_close = 94
Global $x_toler_nvtienthuong = 110

If isLDPlayer() Then ; -> LDplayer
   $x_toler_menu = 112
   $x_toler_thoatpb = 90
   $x_toler_close = 102
   $x_toler_nvtienthuong = 115
EndIf
#EndRegion debug end

#Region debug
Global $flagdebug = IniRead($pathImage&"1.tmp", $general, $debug, False);kiem tra co bat debug ko
If $flagdebug == True Then
   $_HandleImgSearch_IsDebug = True
EndIf
#EndRegion debug end

Global $checkOCR = IniRead($pathImage&"1.tmp", $general, $OCRFlag, False);kiem tra co open OCR hay ko
If $isLDPlayer == True Then ;-> ldplayer
   Local $temp = IniRead($pathImage&"1.tmp", $general, $ldplayerpath, ""); doc config ldplayer
   If $temp == "" Then
	  MsgBox(0,"","Khong tim thay duong dan LDPlayer" &@CRLF ) ; write console
	  IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
	  Exit 0
   Else
	  Global $LD_Path = $temp
   EndIf
Else
   Local $temp = IniRead($pathImage&"1.tmp", $general, $noxpath, ""); doc config
   If $temp == "" Then
	  MsgBox(0,"","Khong tim thay duong dan NoxPlayer" &@CRLF ) ; write console
	  IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
	  Exit 0
   Else
	  Global $Nox_Path = $temp
   EndIf
EndIf

Func writelog($textlog)
  Opt("WinTitleMatchMode", 3)
  Local $hFileOpen = FileOpen($pathLog&$Title&".log", $FO_APPEND)
  If $hFileOpen = -1 Then
	 MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
	 IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
	 Exit 0
  Else
     FileWriteLine($hFileOpen, $Title & ": " & $textlog)
  EndIf
;~ 	 ConsoleWrite($textlog) ;log console
EndFunc   ;==>Example
If $Title == "NoxPlayer" Then
   Global $emuport = 62001
EndIf
If $Title == "NoxPlayer(1)" Or $Title == "NoxPlayer1" Then
   Global $emuport = 62025
EndIf
If $Title == "NoxPlayer(2)" Or $Title == "NoxPlayer2" Then
   Global $emuport = 62026
EndIf
If $Title == "NoxPlayer(3)" Or $Title == "NoxPlayer3" Then
   Global $emuport = 62027
EndIf
If $Title == "NoxPlayer(4)" Or $Title == "NoxPlayer4" Then
   Global $emuport = 62028
EndIf
If $Title == "NoxPlayer(5)" Or $Title == "NoxPlayer5" Then
   Global $emuport = 62029
EndIf
If $Title == "NoxPlayer(6)" Or $Title == "NoxPlayer6" Then
   Global $emuport = 62030
EndIf
If $Title == "NoxPlayer(7)" Or $Title == "NoxPlayer7" Then
   Global $emuport = 62031
EndIf
If $Title == "LDPlayer" Then
   Global $emuport = 5554
EndIf
If $Title == "LDPlayer-1" Or $Title == "LDPlayer1" Then
   Global $emuport = 5556
EndIf
If $Title == "LDPlayer-2" Or $Title == "LDPlayer2" Then
   Global $emuport = 5558
EndIf
If $Title == "LDPlayer-3" Or $Title == "LDPlayer3" Then
   Global $emuport = 5560
EndIf
If $Title == "LDPlayer-4" Or $Title == "LDPlayer4" Then
   Global $emuport = 5562
EndIf
If $Title == "LDPlayer-5" Or $Title == "LDPlayer5" Then
   Global $emuport = 5564
EndIf
If $Title == "LDPlayer-6" Or $Title == "LDPlayer6" Then
   Global $emuport = 5566
EndIf
If $Title == "LDPlayer-7" Or $Title == "LDPlayer7" Then
   Global $emuport = 5568
EndIf
;config end
Global $statusNoxx = IniRead($pathAuto&$Title&".tmp", $run, $statusNox, $onl)
If $statusNoxx == $off Then
   Global $cmd = IniRead($pathAuto&$Title&".tmp", $run, $cmdStart, "")
   If $cmd <> ""  Then
	  If $isLDPlayer == True Then ; -> LDplayer
		 Local $cmdfull = $LD_Path & "\" & $cmd
;~ 		 MsgBox(0,"",$cmdfull)
		 RunWait(@ComSpec & " /c " & $cmdfull)
		 Sleep(30000)
	  Else
		 Local $cmdfull = $Nox_Path & "\" & $cmd
;~ 		 MsgBox(0,"",$cmdfull)
		 $DOS = Run($cmdfull, $Nox_Path, @SW_SHOW, $STDERR_MERGED); Start Nox
		 Sleep(30000)
	  EndIf
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
Global $countLoop = 0
Global $maxloop  = 1000
Global $resetNV = 0 ; reset NV 4 lan truoc khi ket thuc
Global $reset_mahoa_bossTG = False
$checkHARDMOD = IniRead($pathImage&"1.tmp", $general, $hardmode, False);kiem tra co o che do hard mode hay khong
If $checkHARDMOD == True Then
   writelog("Run with hard mode"& @CRLF) ; write console
   $maxloop = 999999;
EndIf
Local $loadname = False
;~ _checkExpireDate() ; kiem tra het han auto
;~  If @error Then
;~ 	  msgbox(0, '' , "Auto has been expired")
;~ 	  IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
;~  Exit 0
;~  EndIf
If $statusNoxx == $off And $cmd <> ""  Then
   _startAndLogin()
Else
   AdLibRegister("_openGame", 5000);auto run this function every 5 s
EndIf

_resizeAuto()

Func _resizeAuto()
   If $isLDPlayer == True Then ; ko phai Nox -> LD player
	  WinActivate($Title)
	  Local $ImageminiLD = @ScriptDir & "\image\miniModel.bmp"
	  Local	$ResultLD = _HandleImgWaitExist($hwnd,$ImageminiLD,1, 0, 0, -1, -1,90, 10);search mini
	  If not @error Then ; thay
		 WinActivate($Title)
		 Opt("WinTitleMatchMode", 3)
		 ControlSend($Title,"","","^{F1}")
		 Sleep(500)
		 Opt("WinTitleMatchMode", 3)
		 WinMove($Title, "",Random(0,20) ,Random(0,80) , 849, 512) ;resize auto again
	  Else
		 Opt("WinTitleMatchMode", 3)
		 WinMove($Title, "",Default ,Default , 849, 512) ;resize auto again
	  EndIf
   Else ;-> LDplayer
	  Opt("WinTitleMatchMode", 3)
	  WinMove($Title, "",Default ,Default , 849, 509) ;resize auto
   EndIf
EndFunc
;~ _outParty()
_anDanExp()
While $countLoop < $maxloop;loop auto 1000 lan
   _close($hwnd) ;close het cua so truoc khi bat dau auto
   $countLoop = $countLoop + 1 ; so lan loop
   If Mod($countLoop, 50) == 0 Then ;boi so cua 50 thi show log
	  writelog("Auto Vong "&$countLoop&" bat dau" &@CRLF) ; write console
   EndIf
   $Auto = Auto()
   If $Auto == "Exit" Then
	  ExitLoop
   Else
	  ContinueLoop
   EndIf
WEnd
writelog("Het NV ---Stop auto...."&$Title&" tại Loop "&$countLoop& " On " & _NowTime() & @CRLF) ; write console
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
   ;~ 	 1. NV Chinh Tuyen
   ;~ 	#ce
;~     Local $readChinhTuyen = IniRead($path&$Title&".tmp", $hoatdong, $chinhtuyen, False)
;~     Local $statusCT = IniRead($pathstatus&$Title&".tmp", $status, $chinhtuyen, $notyet)
;~ 	If $readChinhTuyen == True And $statusCT <> $done Then
;~ 	   $countNV = $countNV + 1
;~ 	   IniWrite($pathstatus&$Title&".tmp", $status, $chinhtuyen,$doing) ; change status running
;~ 	   _GotoNVChinhTuyen($Title,$emuport,$hwnd) ; nv chinh tuyen #nvtienhuong.au3
;~ 	   If @error Then
;~ 		  writelog("0. XONG NV CHINH TUYEN...." & _NowTime() & @CRLF) ; write console
;~ 		  IniWrite($pathstatus&$Title&".tmp", $status, $chinhtuyen,$done) ; change status done
;~ 	   Else
;~ 		  IniWrite($pathstatus&$Title&".tmp", $status, $chinhtuyen,$notyet) ; change status wait
;~ 	   EndIf
;~ 	Sleep(2000)
;~ 	EndIf
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
		  Else
			 IniWrite($pathstatus&$Title&".tmp", $status, $blood,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
	     #cs
	16. Boss The Gioi
	#ce
	   Local $scheckboxBossTG = IniRead($path&$Title&".tmp", $hoatdong, $bossthegioi, False)
	   Local $statusBossTG = IniRead($pathstatus&$Title&".tmp", $status, $bossthegioi, $notyet)
	   If $scheckboxBossTG == True And $statusBossTG <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$doing) ; change status doing
		  _GotoBossTheGioi($Title,$emuport,$hwnd) ; nv boss the gioi #tinhanh.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$done) ; change status done
			 writelog("16. Hoan Thanh Boss The Gioi..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
	   #cs
	17. Boss Chien Truong
	#ce
	   Local $scheckboxBossCTC = IniRead($path&$Title&".tmp", $hoatdong, $bosschientruong, False)
	   Local $statusBossCTC = IniRead($pathstatus&$Title&".tmp", $status, $bosschientruong, $notyet)
	   If $scheckboxBossCTC == True And $statusBossCTC <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$doing) ; change status doing
		  _GotoBossCTC($Title,$emuport,$hwnd) ; nv boss CTC #tinhanh.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$done) ; change status done
			 writelog("17. Hoan Thanh Boss Chien Truong..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$notyet) ; change status wait
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
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bosscanhan,$notyet) ; change status wait
		  EndIf
	   Sleep(2000)
	   EndIf
;~	 	EndIf
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
				_anDanExp()
			 Else
				 IniWrite($pathstatus&$Title&".tmp", $status, $tinhanh,$notyet) ; change status wait
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
		  Local $rs = _openHoatDong()
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
;~ 		  _outParty()
		  $countNV = $countNV + 1
		  Local $rs = _openHoatDong()
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
		  Local $rs = _openHoatDong()
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
	   Local $scheckboxlaythanhvat = IniRead($path&$Title&".tmp", $hoatdong, $laythanhvat, False)
	   Local $statuslaythanhvat = IniRead($pathstatus&$Title&".tmp", $status, $laythanhvat, $notyet)
	   If $scheckboxlaythanhvat == True And $statuslaythanhvat <> $done Then
		  $countNV = $countNV + 1
		  Local $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$doing) ; change status doing
		  _GotoLayThanhVat($Title,$emuport,$hwnd) ; nv lay thanh vat #laythanhvat
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$done) ; change status done
			 writelog("10. Hoàn thành lấy thánh vât..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $laythanhvat,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
	  #cs
	10.1. DiaLao
	#ce
	   Local $scheckboxdialao = IniRead($path&$Title&".tmp", $hoatdong, $dialao, False)
	   Local $statusdialao = IniRead($pathstatus&$Title&".tmp", $status, $dialao, $notyet)
	   If $scheckboxdialao == True And $statusdialao <> $done Then
		  $countNV = $countNV + 1
		  Local $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $dialao,$doing) ; change status doing
		  _GotoDiaLao($Title,$emuport,$hwnd) ; dia lao nguyen to #blood.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $dialao,$done) ; change status done
			 writelog("20. Hoàn thành địa lao..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $dialao,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
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
	  $dayofweek = _getDayofWeek()
	  If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
	     Local $scheckboxBaoTang = IniRead($path&$Title&".tmp", $hoatdong, $baotang, False)
	     Local $statusBaoTang = IniRead($pathstatus&$Title&".tmp", $status, $baotang, $notyet)
	     If $scheckboxBaoTang == True And $statusBaoTang <> $done Then
		  $countNVHenGio = $countNVHenGio + 1
		  $rs = _openMenu()
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
	  EndIf

	   #cs
	14. Phao Dai Do
	#ce
	  Local $dayofweek = _getDayofWeek()
	  If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
	  Local $scheckboxphaodai = IniRead($path&$Title&".tmp", $hoatdong, $phaodai, False)
	  Local $statusphaodai = IniRead($pathstatus&$Title&".tmp", $status, $phaodai, $notyet)
	  If $scheckboxphaodai == True And $statusphaodai <> $done Then
		 $countNVHenGio = $countNVHenGio + 1
		  Local $Now = _NowTime(4);time hien tai
		  Local $var1 = StringRegExpReplace($Now, "[:]", "")
		  Local $timestart = StringRegExpReplace("20:30", "[:]", "")
		  Local $timeend = StringRegExpReplace("20:35", "[:]", "")
		  ;check het time phao dai chua
		  If $var1 > $timeend Then
			 writelog("Het Thoi Gian Phao Dai...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
			 Return
		  EndIf
		  If $var1 > $timestart And $var1 < $timeend Then
			 $rs = _openMenu()
			 If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
				Return
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$doing) ; change status doing
			 _GotoPhaoDaiDo($Title,$emuport,$hwnd) ;Phao Dai Do #blood.au3
			 If @error Then
				writelog("Het Thoi Gian Phao Dai...." & _NowTime() & @CRLF) ; write console
				IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
				Return 1
			 EndIf
			 IniWrite($pathstatus&$Title&".tmp", $status, $phaodai,$done) ; change status done
			 Return 1
		  EndIf
	   EndIf
	EndIf
	   #cs
	15. Hotro Guild
	#ce
	   Local $scheckboxhotro = IniRead($path&$Title&".tmp", $hoatdong, $hotroguild, False)
	   If $scheckboxhotro == True Then
		  $countNV = $countNV + 1
		  _findIconMenu($hwnd)
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $hotroguild,$doing) ; change status doing
		  Local $rsHotro = _GotoHoTroGuild($Title,$emuport,$hwnd) ; nv ho tro guild in tinhanh.au3
		  IniWrite($pathstatus&$Title&".tmp", $status, $hotroguild,$notyet) ; change status wait
		  Sleep(2000)
	   EndIf

   #cs
	16. Boss The Gioi
	#ce
	   Local $scheckboxBossTG = IniRead($path&$Title&".tmp", $hoatdong, $bossthegioi, False)
	   Local $statusBossTG = IniRead($pathstatus&$Title&".tmp", $status, $bossthegioi, $notyet)
	   If $scheckboxBossTG == True And $statusBossTG <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$doing) ; change status doing
		  _GotoBossTheGioi($Title,$emuport,$hwnd) ; nv boss the gioi #tinhanh.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$done) ; change status done
			 writelog("16. Hoan Thanh Boss The Gioi..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	   EndIf
	   #cs
	17. Boss Chien Truong
	#ce
	   Local $scheckboxBossCTC = IniRead($path&$Title&".tmp", $hoatdong, $bosschientruong, False)
	   Local $statusBossCTC = IniRead($pathstatus&$Title&".tmp", $status, $bosschientruong, $notyet)
	   If $scheckboxBossCTC == True And $statusBossCTC <> $done Then
		  $countNV = $countNV + 1
		  $rs = _openHoatDong()
		  If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
			 Return
		  EndIf
		  Sleep(500)
		  IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$doing) ; change status doing
		  _GotoBossCTC($Title,$emuport,$hwnd) ; nv boss CTC #tinhanh.au3
		  If @error Then
			 IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$done) ; change status done
			 writelog("17. Hoan Thanh Boss Chien Truong..." & _NowTime() & @CRLF) ; write console
		  Else
			  IniWrite($pathstatus&$Title&".tmp", $status, $bosschientruong,$notyet) ; change status wait
		  EndIf
		  Sleep(2000)
	  EndIf

      #cs
	18. Ma Hoa
	#ce
	  Local $scheckboxMaHoa = IniRead($path&$Title&".tmp", $hoatdong, $mahoa, False)
	  Local $statusMaHoa = IniRead($pathstatus&$Title&".tmp", $status, $mahoa, $notyet)
	  If $scheckboxMaHoa == True And $statusMaHoa <> $done Then
		 If $countNV == 0 And $countNVHenGio == 0 Then ;het tat ca NV thi treo Ma Hoa
			$countNV = $countNV + 1
			_findIconMenu($hwnd)
			Sleep(500)
			IniWrite($pathstatus&$Title&".tmp", $status, $mahoa,$doing) ; change status doing
			_GotoMaHoa($Title,$emuport,$hwnd) ; nv MaHoa #laythanhvat.au3
			If @error Then
			   IniWrite($pathstatus&$Title&".tmp", $status, $mahoa,$done) ; change status done
			   writelog("18. Hoan Thanh Ma Hoa..." & _NowTime() & @CRLF) ; write console
			   #Region reset NV Boss TG va Ma Hoa
			   If $reset_mahoa_bossTG == False Then
				  IniWrite($pathstatus&$Title&".tmp", $status, $bossthegioi,$notyet) ; change status wait
				  $reset_mahoa_bossTG = True
				  IniWrite($pathstatus&$Title&".tmp", $status, $mahoa,$notyet) ; change status wait
			   EndIf
			   #EndRegion
			Else
			   IniWrite($pathstatus&$Title&".tmp", $status, $mahoa,$notyet) ; change status wait
			EndIf
			Sleep(1000)
		 EndIf
	  EndIf
	;Xu Li Het Auto
   If $countNV == 0 And $countNVHenGio == 0 Then ; het nv ngay va nv hen gio thi stop auto
	  _anDanExp()
	  _diCamTrain()
	  writelog("Het NV "& @CRLF) ; write console
	  Return "Exit"
   EndIf
EndFunc   ;==>Auto
Func CheckInPbOrNot($Title,$Handle)
   If BitAND(WinGetState($Title), 16) Then
	  Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
	  WinActivate($Title)
	  WinActivate($myLastWin)
   EndIf
   Local $Result = _findIconMenu($hwnd)
   If Not @error Then
	  _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+1+660, $Result[1][1]+30) ; click menu
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1500 200") ;click to hoat dong
   EndIf
EndFunc   ;==>ControlClickWindowsByImage
Func _CheckNhanSoiNoi($Title,$Handle)
	  If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	  EndIf
	  $ImagePath = @ScriptDir & "\image\laysoinoi.bmp"
	  Local $x_tolerance_laysoinoi = 100
	  If $isLDPlayer == True Then
		 $x_tolerance_laysoinoi = 105
	  EndIf
	  $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 0, 0, -1, -1,$x_tolerance_laysoinoi, 10);search nut Laysoi noi trongh 2s
	  If @error Then ; ko thay soi noi
		 Return SetError(3)
	  Else
		 writelog("Nhan thuong soi noi " & _NowTime() & @CRLF) ; write console
		 Sleep(500)
		 Opt("WinTitleMatchMode", 3)
		 _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+250, $Result[1][1]-30) ; click nhan soi noi
	  EndIf
EndFunc   ;==>ControlClickWindowsByImage

Func _close($Handle)
     _closeSimple($Handle)
	  $ImagePath2 = @ScriptDir & "\image\close2.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath2,1, 0, 0, -1, -1,95, 10);search close button 2
	  If not @error Then ;  thay close
		 Opt("WinTitleMatchMode", 3)
		 _ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click close
	  EndIf
	  Local $ImagePath3 = @ScriptDir & "\image\huy.bmp"
	  If $isLDPlayer == True Then
		 $ImagePath3 = @ScriptDir & "\image\huy_ld.bmp"
	  EndIf
	  $Result = _HandleImgSearch($Handle, $ImagePath3, 480, 250, 80, 60,149, 2);search huy button
	  If not @error Then ;  thay huy
		 Opt("WinTitleMatchMode", 3)
		 _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+484, $Result[1][1]+253) ; click close
	  EndIf
   EndFunc   ;==>Example

Func _closeSimple($Handle)
      If BitAND(WinGetState($Title), 16) Then
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  $ImagePath = @ScriptDir & "\image\close.bmp"
	  If $isLDPlayer == True Then
		 $ImagePath = @ScriptDir & "\image\close_ld.bmp"
	  EndIf
	  Local $Result = _HandleImgSearch($Handle, $ImagePath, 0, 0, -1, -1,$x_toler_close, 10);search close button
	  If not @error Then ; thay close
		 If $Result[0][0] > 1 Then
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
		 Else
		 Opt("WinTitleMatchMode", 3)
		 _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+2, $Result[1][1]+27) ; click close
		 EndIf
	  EndIf
EndFunc   ;==>Example


Func _openHoatDong()
	   Local $rs = _openMenu()
	   If $rs == 1 Then ; da nhan thuong soi noi xong chay lai vong lap
		  Return 1
	   EndIf
	   Local $rsboss = _checkbossguild()
	   If $rsboss == 1 Then ;  boss guild = 1 thi next loop
		  Return 1
	   EndIf

	   Local $rstuhoi = _checktuhoiguild()
	   If $rstuhoi == 1 Then ;  tu hoi guild = 1 thi next loop
		  Return 1
	   EndIf

	   Local $rsphaodai = _checkPhaoDaiDo()
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
				writelog("Lỗi khi vô boss guild...." & _NowTime() & @CRLF) ; write console
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
				writelog("Lỗi khi vô boss guild...." & _NowTime() & @CRLF) ; write console
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
		  Return 1
	   EndIf
	   If $var1 > $timestart And $var1 < $timeend Then
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$doing) ; change status doing
		  _GotoNVTuHoiGuild($Title,$emuport,$hwnd) ;Tu hoi guild #tinhanh.au3
		  If @error Then
			 writelog("Het Thoi Gian Vao Tu Hoi Guild...." & _NowTime() & @CRLF) ; write console
			 IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
			 Return 1
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
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
			 Return 1
		  EndIf
		  IniWrite($pathstatus&$Title&".tmp", $status, $tuhoiguild8h,$done) ; change status done
		  Return 1
	   EndIf
   EndIf


EndFunc   ;==>Example
Func _checkPhaoDaiDo()
	  Local $dayofweek = _getDayofWeek()
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
			 _GotoPhaoDaiDo($Title,$emuport,$hwnd) ;Phao Dai Do #blood.au3
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
			 _GotoPhaoDaiDo($Title,$emuport,$hwnd) ;Phao Dai Do #blood.au3
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
	   Local $ImagePath = @ScriptDir & "\image\nhatkihd.bmp"
	   Local $Result = _HandleImgSearch($hwnd, $ImagePath, 0, 0, -1, -1,50, 2);search nhat ki hd
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
	If $isLDPlayer == True Then  ;->LDPlayer
	   Local $newCommand = StringReplace($Command,"127.0.0.1:","emulator-")
	   $DOS = Run($adbpath & "\" & $newCommand, $adbpath, @SW_HIDE, $STDERR_MERGED)
	   While 1
		   Sleep(50)
		   If @error Or Not ProcessExists($DOS) Then ExitLoop
	   WEnd
	   $Message = StdoutRead($DOS)
	   Return $Message
    Else
	   $DOS = Run($Nox_Path & "\" & $Command, $Nox_Path, @SW_HIDE, $STDERR_MERGED)
	   While 1
		   Sleep(50)
		   If @error Or Not ProcessExists($DOS) Then ExitLoop
	   WEnd
	   $Message = StdoutRead($DOS)
	   Return $Message
	EndIf

 EndFunc   ;==>_ADB_Command

Func _searchNV($Handle, $imagepath, $tor = 115 , $sizeSan = 6)
	  Local $i = 0
	  While $i < $sizeSan
		 $i = $i + 1
		 Local $Result = _HandleImgWaitExist($Handle, $imagepath,1, 0, 0, -1, -1,$tor, 2);search nv can tim
		 If not @error Then ; neu thay nv out
			Return $Result
		 Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 510 300"); di chuyen cuon len 1 chut
			Sleep(500)
		 EndIf
	  WEnd
	  Return SetError(3) ; ko tim thay return error
   EndFunc   ;==> Search NV

Func _searchNVAdvance($Handle, $imageHet, $imageCon,$torHet = 115, $torCon = 115 , $sizeSan = 6, $timeWaitHet = 1,$timeWaitCon = 1)
	  Local $i = 0
	  While $i < $sizeSan
		 $i = $i + 1
		 $Result = _HandleImgWaitExist($Handle, $imageHet,$timeWaitHet, 0, 0, -1, -1,$torHet, 2);search image het luot
		 If not @error Then ; neu thay image het NV -> out
			 Return SetError(3)
		 Else
			 $Result = _HandleImgWaitExist($Handle, $imageCon,$timeWaitCon, 0, 0, -1, -1,$torCon, 2);search image con luot
			 If not @error Then
				Return $Result
			 EndIf
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 510 300"); di chuyen cuon len 1 chut
			Sleep(500)
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
Func _anDanExp()
   Local $x_balo = 80
   If $isLDPlayer == True Then ; -> LDplayer
		 $x_balo = 114
   EndIf
   Local $flagAnExp = IniRead($pathImage&"1.tmp", $general, $anExp, ""); check flag an exp
   If $flagAnExp == "False" Then
	  Return
   EndIf

   ;check an Dan
   _findIconMenu($hwnd)
   Local $count = 0
   While $count < 5
	  $count = $count + 1
	  Local $ImageIconBalo = @ScriptDir & "\image\iconBalo.bmp"
	  Local $Result = _HandleImgWaitExist($hwnd, $ImageIconBalo,2, 687, 328, 45, 45,$x_balo, 2);search balo
	  If not @error Then ; thay balo -> click
		 writelog("Ăn đan EXP " & @CRLF) ; write console
		 _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+687, $Result[1][1]+328) ; click balo
		 Sleep(2000)
		 ;search Dan Exp
		 While 1
			;search exp lon
			Local $Imageexplon = @ScriptDir & "\image\expLon.bmp"
			$Result = _HandleImgWaitExist($hwnd,$Imageexplon,1, 0, 0, -1, -1,90, 10);search exp lon
			If not @error Then ; thay exp -> click
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo exp Lon
			   Sleep(1000)
			   Local $Imagesudungbtn = @ScriptDir & "\image\thembtn.bmp"
			   $Result = _HandleImgWaitExist($hwnd,$Imagesudungbtn,1, 0, 0, -1, -1,90, 10);search btn su dung
			   If not @error Then ; thay su dung btn -> click
				  _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+200, $Result[1][1]) ; click su dung btn
				  Sleep(1000)
				  ContinueLoop
			   EndIf
			EndIf
			;search exp nho
			Local $Imageexpnho = @ScriptDir & "\image\expNho.bmp"
			$Result = _HandleImgWaitExist($hwnd,$Imageexpnho,1, 0, 0, -1, -1,90, 10);search exp nho
			If not @error Then ; thay exp -> click
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo exp nho
			   Sleep(1000)
			   Local $Imagesudungbtn = @ScriptDir & "\image\thembtn.bmp"
			   $Result = _HandleImgWaitExist($hwnd,$Imagesudungbtn,1, 0, 0, -1, -1,90, 10);search btn su dung
			   If not @error Then ; thay su dung btn -> click
				  _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+200, $Result[1][1]) ; click su dung btn
				  Sleep(1000)
				  ContinueLoop
			   EndIf
			EndIf
			writelog("Da an het dan exp" & @CRLF) ; write console
			ExitLoop
		 WEnd
		 #Region mo hom
		 writelog("Mở rương boss" & @CRLF) ; write console
		 Local $x_tolerance_RuongVang = 85
		 If $isLDPlayer == True Then
			Local $x_tolerance_RuongVang = 95
		 EndIf
		 Local $x_tolerance_MoLanNua = 85
		 If $isLDPlayer == True Then
			Local $x_tolerance_MoLanNua = 95
		 EndIf
		 Local $x_tolerance_HuyChuong = 90
		 If $isLDPlayer == True Then
			Local $x_tolerance_HuyChuong = 95
		 EndIf
		 For $i = 1 To 5 Step + 1
			Local $Image_RuongVang = @ScriptDir & "\image\ruongvang.bmp"
			Local $Result = _HandleImgWaitExist($hwnd,$Image_RuongVang,1, 0, 0, -1, -1,$x_tolerance_RuongVang, 10);search ruong vang
			If Not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+5, $Result[1][1]+5) ; click ruong vang
			   Sleep(1200)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 750") ;click to mo
			   Sleep(1000)
			   For $ii = 1 To 20 Step + 1
				  Local $Image_MoLanNua = @ScriptDir & "\image\molannua.bmp"
				  _HandleImgWaitExist($hwnd,$Image_MoLanNua,1, 0, 0, -1, -1,$x_tolerance_MoLanNua, 10);search ruong vang
				  If Not @error Then
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 550") ;click to mo lan nua
					 Sleep(1500)
				  Else
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 550") ;click dong
					 Sleep(1000)
					 ExitLoop
				  EndIf
			   Next
			EndIf
			;Huy Chuong start
			Local $Image_HuyChuong = @ScriptDir & "\image\huychuongboss.bmp"
			Local $Result = _HandleImgWaitExist($hwnd,$Image_HuyChuong,1, 0, 0, -1, -1,$x_tolerance_HuyChuong, 10);search ruong vang
			If Not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+5, $Result[1][1]+5) ; click ruong vang
			   Sleep(1200)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 750") ;click to mo
			   Sleep(1000)
			   For $ii = 1 To 20 Step + 1
				  Local $Image_MoLanNua = @ScriptDir & "\image\molannua.bmp"
				  _HandleImgWaitExist($hwnd,$Image_MoLanNua,1, 0, 0, -1, -1,$x_tolerance_MoLanNua, 10);search ruong vang
				  If Not @error Then
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 550") ;click to mo lan nua
					 Sleep(1500)
				  Else
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 550") ;click dong
					 Sleep(1000)
					 ExitLoop
				  EndIf
			   Next
			EndIf
			;Huy Chuong End
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 900 650 900 510 200"); di chuyen cuon len 1 chut
			Sleep(1000)
		 Next
		 #EndRegion
		 _close($hwnd)
		 Return
	  Else
		 _close($hwnd)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1523 821") ; click vo kiem de chuyen menu
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
   Local $ImageThuongSoiNoi = @ScriptDir & "\image\thuongsoinoi_ld.bmp"
   Local $Result = _HandleImgWaitExist($hwnd, $ImageThuongSoiNoi,1, 0, 0, -1, -1,90, 2);search thuong soi noi
   If Not @error Then
	  _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+5, $Result[1][1]+5) ; click thuong soi noi
	  For $i = 1 To 10 Step + 1
		 Local $Imagelinhthuong = @ScriptDir & "\image\linhthuong2.bmp"
		 Local $Result = _HandleImgWaitExist($hwnd, $Imagelinhthuong,1, 0, 0, -1, -1,90, 2);search thuong soi noi
		 If Not @error Then
			_ControlClickExactly($Title, "", "","", 1,$Result[1][0]+5, $Result[1][1]+5) ; click linh thuong
			Sleep(500)
		 Else
			ExitLoop
		 EndIf

	  Next
	  _closeSimple($hwnd) ;close
   EndIf

   Local $Imagetreomayhetluot = @ScriptDir & "\image\treomayhetluot.bmp"
   Local $p = _searchNV($hwnd, $Imagetreomayhetluot) ; search NV treo may het luot
   If @error Then
	  Return
   Else
	  writelog("Di treo may" & @CRLF) ; write console
	  _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(10000);Cho 10s
   EndIf
EndFunc
Func _findIconMenu($Handle)
   Local $loopindex = 0
   While 1 ;tim den khi thay menu
	  Local $ImagePath = @ScriptDir & "\image\menu.bmp"
	  Local $Result = _HandleImgWaitExist($Handle, $ImagePath,1, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
      If @error Then ; ko thay menu
		 $loopindex = $loopindex + 1
		  writelog("Tim kiem menu " & @CRLF) ; write console
		  _close($Handle); close all window
		 Local $ImagePath_close = @ScriptDir & "\image\close.bmp"
		 If $isLDPlayer == True Then
			$ImagePath_close = @ScriptDir & "\image\close_ld.bmp"
		 EndIf
		 If Mod($loopindex,5) == 0 Then
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap "&Random(800,1200)&" 450") ;click giua man hinh
			Sleep(500)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 500 750 400 300"); di chuyen cuon len 1 chut
		 EndIf
		 If Mod($loopindex,20) == 0 Then
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
		 EndIf
		 Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
		 Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,1, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
		 If Not @error Then
			writelog("Dang Trong Pho Ban .. Thoat " & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 1,$rsthoatpb[1][0]+655, $rsthoatpb[1][1]+40) ; click thoat
			Sleep(700)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 985 600") ;click Xac nhan
			Sleep(6000)
			$Result2 = _HandleImgWaitExist($Handle, $ImagePath,2, 660,30, 60, 50,$x_toler_menu, 2);search nut menu again trong 5s
		 EndIf
	  Else
		 writelog("Tim thay menu " & _NowTime() & @CRLF) ; write console
		 $flag_in_game = True ; xac nhan da vo game
		 Return $Result
		 ExitLoop
	  EndIf
   WEnd
EndFunc

Func _outParty()
   _findIconMenu($hwnd)
   writelog("Thoat Party " & _NowTime() & @CRLF) ; write console
   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1572 465") ;click la co lan 1
   Sleep(1000)
   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1572 465") ;click la co lan 2
   Sleep(1000)
   Local $Imageroikhoidoi = @ScriptDir & "\image\roikhoidoibtn.bmp"
   Local $rsroikhoidoi = _HandleImgWaitExist($hwnd, $Imageroikhoidoi,1, 0, 0, -1, -1,80, 2);search btn roi khoi doi
   If Not @error Then
	  _ControlClickExactly($Title, "", "","", 1,$rsroikhoidoi[1][0], $rsroikhoidoi[1][1]) ; click thoat
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600") ;click xac nhan
	  Sleep(1000)
	  _closeSimple($hwnd)
	  Return
   EndIf
   Local $Imageroikhoi = @ScriptDir & "\image\roikhoibtn.bmp"
   Local $rsroikhoi = _HandleImgWaitExist($hwnd, $Imageroikhoi,1, 0, 0, -1, -1,80, 2);search btn roi khoi doi
   If Not @error Then
	  _ControlClickExactly($Title, "", "","", 1,$rsroikhoi[1][0], $rsroikhoi[1][1]) ; click thoat
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600") ;click xac nhan
	  Sleep(1000)
	  _closeSimple($hwnd)
	  Return
   EndIf
   _findIconMenu($hwnd)
EndFunc
Func _ControlClickExactly($Title,$text,$ctrID,$type,$click,$x,$y,$singleclick = False)
   If $isLDPlayer == True Then ; ko phai Nox -> LD player
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, $text, $ctrID,$type, 1,$x, $y-34) ; click dung title
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, $text, $ctrID,$type, 1,$x, $y-34) ; click dung title
   Else ; Nox
	  Opt("WinTitleMatchMode", 3)
      ControlClick($Title, $text, $ctrID,$type, $click,$x, $y) ; click dung title
   EndIf

EndFunc
Func _startAndLogin()
   Local $count = 0
     While 1 ;buoc vo game
		$count = $count + 1
		If $count > 50 Then
		   MsgBox(0,"","Lỗi không thể tự động đăng nhập. Vui lòng đăng nhập thủ công")
		   IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
		   Exit 0
		EndIf

		Local $Imageicon = @ScriptDir & "\image\iconMuVTD.bmp"
		If $isLDPlayer == True Then
			$Imageicon = @ScriptDir & "\image\iconMuVTD_ld.bmp"
		 EndIf
	    Local $Result = _HandleImgSearch($hwnd, $Imageicon, 0, 0, -1, -1,100, 2);search icon MU
		If not @error Then ; neu thay nv out
		    writelog("Game san sang " & _NowTime() & @CRLF) ; write console
			Sleep(6000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(1000);

			Local $Imagewait = @ScriptDir & "\image\wait.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf

			Sleep(2000)
			_ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
			ExitLoop
	    Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(4000) ;cho 5s
			Local $Imagewait = @ScriptDir & "\image\wait.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
		 EndIf
		 ;icon lon
	    Local $Imageiconbig = @ScriptDir & "\image\iconMuVTDbig.bmp"
		If $isLDPlayer == True Then
			$Imageiconbig = @ScriptDir & "\image\iconMuVTDbig_ld.bmp"
		 EndIf
	    Local $Result = _HandleImgSearch($hwnd, $Imageiconbig, 0, 0, -1, -1,100, 2);search icon MU big
		If not @error Then ; neu thay nv out
		    writelog("Game san sang " & _NowTime() & @CRLF) ; write console
			Sleep(6000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(1000);
			Local $Imagewait = @ScriptDir & "\image\waitBig.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
			_ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
			Sleep(3000)
			_resizeAuto()
			ExitLoop
	    Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Sleep(4000) ;cho 5s
			Local $Imagewait = @ScriptDir & "\image\waitBig.bmp"
			Local $Result1 = _HandleImgSearch($hwnd, $Imagewait, 0, 0, -1, -1,149, 2);search icon close App
			If not @error Then
			   _ControlClickExactly($Title, "", "","", 1,$Result1[1][0], $Result1[1][1]) ; click vo icon close app
			EndIf
	    EndIf
	 WEnd
	 Local $count = 0
	 AdLibRegister("_resolveBug", 6000);auto run every 6 s
	 AdLibRegister("_openGame", 15000);auto run this function every 15 s
	 While 1 ;buoc dang nhap
		$count = $count + 1
		If $count > 50 Then
		   MsgBox(0,"","Lỗi không thể tự động đăng nhập. Vui lòng đăng nhập thủ công")
		   IniWrite($pathAuto&$Title&".tmp", $run, $finish,True) ; update finish AUTO
		   Exit 0
		EndIf
		 Local $ImageiconTK = @ScriptDir & "\image\icontaikhoan.bmp"
		 Local $ResultTK = _HandleImgWaitExist($hwnd, $ImageiconTK,5, 0, 0, -1, -1,70, 2);search icon Tai Khoan
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
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+275, $Result[1][1]) ; click xac nhan
			EndIf
			Local $ImagePath3 = @ScriptDir & "\image\close2.bmp"
			$Result2 = _HandleImgWaitExist($hwnd, $ImagePath3,5, 0, 0, -1, -1,80, 2);search close button 2 trong 15s
			If not @error Then ; ko thay close
			   Opt("WinTitleMatchMode", 3)
			   _ControlClickExactly($Title, "", "","", 1,$Result2[1][0], $Result2[1][1]) ; click close
			EndIf
		 Else
		 EndIf
		 AdlibUnRegister("_resolveBug")
	  EndFunc
Func _openGame()
      If $flag_in_game == False Then
		 Local $Imageicon = @ScriptDir & "\image\iconMuVTD.bmp"
		 If $isLDPlayer == True Then
			$Imageicon = @ScriptDir & "\image\iconMuVTD_ld.bmp"
		 EndIf

		 Local $Result = _HandleImgSearch($hwnd, $Imageicon, 0, 0, -1, -1,100, 2);search icon MU
		 If not @error Then ; neu thay nv out
			_ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon game
		 EndIf
		 Local $ImageiconTK = @ScriptDir & "\image\icontaikhoan.bmp"
		 Local $ResultTK = _HandleImgSearch($hwnd, $ImageiconTK, 0, 0, -1, -1,70, 2);search icon Tai Khoan
		 If not @error Then
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 669") ;click to dang nhap
		 EndIf
		 Local $Imagepath = @ScriptDir & "\image\iconchonNV.bmp"
		 Local $ResultChonNV = _HandleImgSearch($hwnd, $Imagepath,0, 0, -1, -1,70, 2);search icon back
		 If not @error Then
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 800") ;click to bat dau
		 EndIf
      Else
		 AdlibUnRegister("_openGame"); stop this function
	  EndIf
   EndFunc
Func _GetDPI_Ratio()
    If isLDPlayer() Then ; -> LDplayer
	  $scale = 1
	  Return $scale
    EndIf
    Local $hWnd = 0
    Local $hDC = DllCall("user32.dll", "long", "GetDC", "long", $hWnd)
    Local $aRet = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $hDC[0], "long", 10)  ; = reported vert height (not logical, which is param=90)
    Local $bRet = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $hDC[0], "long", 117) ; = true vert pixels of desktop
    $hDC = DllCall("user32.dll", "long", "ReleaseDC", "long", $hWnd, "long", $hDC)
	$scale = $bRet[0] / $aRet[0]
    Return $scale;  Noxplayer
 EndFunc
Func isLDPlayer()
   If StringInStr($Title, "NoxPlayer",$STR_CASESENSE) == 0 Then ; -> LDplayer
	  $isLDPlayer = True
	  Return True
   Else
	  $isLDPlayer = False
	  Return False
   EndIf
EndFunc
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
 Func _resolveBug()
   Local $Imagelockwait = @ScriptDir & "\image\lockwait_ld.bmp"
   Local $Result = _HandleImgSearch($hwnd, $Imagelockwait, 0, 0, -1, -1,100, 2);search icon lock wait
   If not @error Then ;
	  _ControlClickExactly($Title, "", "","", 1,$Result[1][0], $Result[1][1]) ; click vo icon
   EndIf
 EndFunc   ;==>_ANSIToUnicode