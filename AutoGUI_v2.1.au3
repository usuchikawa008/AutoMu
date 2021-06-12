#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay.
#include <AutoItConstants.au3>
#include <ListViewConstants.au3>
#include <GuiListView.au3>
#include <GUIConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#include <FontConstants.au3>
#include <Adapter.au3>
#include <GuiMenu.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>
#include <TabConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <DateTime.au3>
#include <ColorConstants.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <getPathProcess.au3>
#include <RestApiTest.au3>




;~  #include <_Dbug.au3>
Global $idDelete, $idEdit ,$oDictionary
$oDictionary = ObjCreate("Scripting.Dictionary")
Global $currentAuto
Global $dayofweek = _getDayofWeek()
;dir config file
Global Const $path = @ScriptDir&"\hoatdong\"
Global Const $pathconfig = @ScriptDir&"\config\"
Global Const $pathstatus = @ScriptDir&"\status\"
Global Const $pathAuto = @ScriptDir&"\auto\"
Global Const $pathImage = @ScriptDir&"\image\"
Global Const $pathLog = @ScriptDir&"\log\"
;config general
Global Const $general = "General"
Global Const $hardmode = "HardMode"
Global Const $mac = "MAC"
Global Const $noxpath = "NoxPath"
Global Const $ldplayerpath = "LDPlayerPath"
Global Const $anExp = "AnDonExp"
Global Const $camtrain = "CamTrain"
Global Const $ghepveblood = "GhepVeBlood"
Global Const $autoAnThit = "AutoAnThit"
Global Const $autoTruyenCong = "TruyenCong"
Global Const $codeClient = "CodeClient"
Global Const $version = "Version"
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
Global Const $bossthegioi = "BossTheGioi"
Global Const $bosschientruong = "BossChienTruong"
;config hoat dong End
;config start Auto
Global Const $run = "Run"
Global Const $finish = "Finish"
Global Const $pid = "PID"
Global Const $nameingame = "Name_In_Game"
Global Const $statusNox = "StatusNox"
Global Const $onl = "Onl"
Global Const $off = "Off"
Global Const $cmdStart = "cmdStart"
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
Global Const $bossTG_top1= "BossTGTop1"
Global Const $bossTG_top2 = "BossTGTop2"
Global Const $bossTG_top3 = "BossTGTop3"
Global Const $bosCTC_boss1 = "BossCTCBoss1"
Global Const $bosCTC_boss2 = "BossCTCBoss2"
Global Const $bosCTC_boss3 = "BossCTCBoss3"
Global Const $bosCTC_boss4 = "BossCTCBoss4"
Global Const $bosCTC_boss5 = "BossCTCBoss5"
Global Const $bosCTC_boss6 = "BossCTCBoss6"

#Region check update latest version
Global $versionPC = IniRead($pathImage&"version.ini", $general, $version, ""); doc config version
Local $jsonString = get_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account?Code=DGZRLD1RKC",""); get Json code version
Local $Obj = Json_Decode($jsonString)
Local $versionJson = Json_Get_Data($Obj, '[0]["MAC"]')
If $versionPC == "" Then
   IniWrite($pathImage&"version.ini", $general, $version, $versionJson); luu vo config
Else ; da co version o PC -> kiem tra co moi nhat ko
   If $versionPC == $versionJson Then
	  ConsoleWrite("Đã ở version mới nhất")
   Else
	  ConsoleWrite("Khác version")
	  Run("AutoUpdate")
	  IniWrite($pathImage&"version.ini", $general, $version, $versionJson); update version
	  Exit 0
   EndIf
EndIf

#EndRegion update version

#Region check ma code
Global $CodeData = IniRead($pathImage&"1.tmp", $general, $codeClient, ""); doc config code
If $CodeData == "" Then
   Local $sAnswer = InputBox("Input Code", "Nhập Mã Code Của Bạn "& @LF & "Nếu Xài Test Không Cần Nhập", "", "",- 1, -1, 0, 0)
   If @error = 1 Then ; cancel -> tat Auto
	  Exit 0
   EndIf
   If $sAnswer == "" Then ; ko nhap ji thi xai ban thu nghiem
	  ConsoleWrite("Bạn xài bản thử nghiệm")
	  Local $jsonString = get_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account?Code=B8RV0B2D5W","");bản text
	  Local $Obj = Json_Decode($jsonString)
	  Local $expireDate = Json_Get_Data($Obj, '[0]["DateExpire"]')
	  _checkExpireDate($expireDate) ; kiem tra het han auto
	  If @error Then
			msgbox(0, '' , "Auto has been expired")
	  Exit 0
	  EndIf
   Else ; xai ban chinh thuc
	  Local $AdapterList = GetAdaptersList(); ham get adapter
	  Local $MacString = $AdapterList[1][2] ;get dia chi Mac
	  Local $jsonString = get_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account?Code="&$sAnswer,"")
	  Local $Obj = Json_Decode($jsonString)
	  Local $CodeValue = Json_Get_Data($Obj, '[0]["Code"]')
	  Local $expireDate = Json_Get_Data($Obj, '[0]["DateExpire"]')
	  Local $MacValue = Json_Get_Data($Obj, '[0]["MAC"]')
	  If $CodeValue == $sAnswer Then ; Nhap Code Đúng
		 If $MacValue == "" Then ; chua co May nao xai code nay ; can put API update
			Local $idValue = Json_Get_Data($Obj, '[0]["id"]')
			put_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account/"&$idValue,'{"MAC":"'&$MacString&'"}')
			_checkExpireDate($expireDate) ; kiem tra het han auto
			If @error Then
			   msgbox(0, '' , "Auto has been expired")
			   Exit 0
			EndIf
			IniWrite($pathImage&"1.tmp", $general, $codeClient, $CodeValue); luu vo config
		 Else
			If $MacValue <> $MacString Then
			   MsgBox(0,'',"Auto đã được sử dụng ở máy khác")
			   Exit 0
			Else
			   ConsoleWrite("Auto Start")
			   _checkExpireDate($expireDate) ; kiem tra het han auto
			   If @error Then
				  msgbox(0, '' , "Auto has been expired")
				  Exit 0
			   EndIf
			   IniWrite($pathImage&"1.tmp", $general, $codeClient, $CodeValue); luu vo config
			EndIf
		 EndIf
	  Else
		 MsgBox(0,'',"Sai Code")
		 Exit 0
	  EndIf

   EndIf
Else
   Local $AdapterList = GetAdaptersList(); ham get adapter
   Local $MacString = $AdapterList[1][2] ;get dia chi Mac
   Local $jsonString = get_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account?Code="&$CodeData,"")
   Local $Obj = Json_Decode($jsonString)
	  Local $CodeValue = Json_Get_Data($Obj, '[0]["Code"]')
	  Local $expireDate = Json_Get_Data($Obj, '[0]["DateExpire"]')
	  Local $MacValue = Json_Get_Data($Obj, '[0]["MAC"]')
	  If $CodeValue == $CodeData Then ; Nhap Code Đúng
		 If $MacValue == "" Then ; chua co May nao xai code nay ; can put API update
			Local $idValue = Json_Get_Data($Obj, '[0]["id"]')
			put_authentication_test("https://60bf0f79320dac0017be452f.mockapi.io/Account/"&$idValue,'{"MAC":"'&$MacString&'"}')
			_checkExpireDate($expireDate) ; kiem tra het han auto
			If @error Then
			   msgbox(0, '' , "Auto has been expired")
			   Exit 0
			EndIf
			IniWrite($pathImage&"1.tmp", $general, $codeClient, $CodeValue); luu vo config
		 Else
			If $MacValue <> $MacString Then
			   MsgBox(0,'',"Auto đã được sử dụng ở máy khác")
			   Exit 0
			Else
			   ConsoleWrite("Auto Start")
			   _checkExpireDate($expireDate) ; kiem tra het han auto
			   If @error Then
				  msgbox(0, '' , "Auto has been expired")
				  Exit 0
			   EndIf
			   IniWrite($pathImage&"1.tmp", $general, $codeClient, $CodeValue); luu vo config
			EndIf
		 EndIf
	  Else
		 MsgBox(0,'',"Sai Code")
		 Exit 0
	  EndIf
EndIf; end check ma code
#EndRegion check ma code
Local $nox_start = True
#Region check Nox Path valid
   Local $temppath = IniRead($pathImage&"1.tmp", $general, $noxpath, ""); doc config
   If StringInStr($temppath, "Nox",$STR_CASESENSE) == 0 Then ; neu chua tim dc path Nox -> tim lai
	  Local $Nox_PathFull = _WinGetPath("NoxPlayer") ;get path cua Nox
	  If StringInStr($Nox_PathFull, "Nox",$STR_CASESENSE) == 0 Then
		 $nox_start = False
	  EndIf
	  Local $Nox_Path = StringLeft($Nox_PathFull,StringInStr($Nox_PathFull,"\",0,-1)-1)
	  IniWrite($pathImage&"1.tmp", $general, $noxpath, $Nox_Path); luu vo config
   EndIf
#EndRegion check Nox Path valid
Local $ldp_start = True
#Region check LDplayer valid
   Local $temppath = IniRead($pathImage&"1.tmp", $general, $ldplayerpath, ""); doc config
   If StringInStr($temppath, "LDPlayer",$STR_CASESENSE) == 0 Then ; neu chua tim dc path LDplayer -> tim lai
	  Local $LD_PathFull = _WinGetPath("LDPlayer") ;get path cua LDplayer
	  If StringInStr($LD_PathFull, "LDPlayer",$STR_CASESENSE) == 0 Then
		 $ldp_start = False
	  EndIf
	  Local $LD_Path = StringLeft($LD_PathFull,StringInStr($LD_PathFull,"\",0,-1)-1)
	  IniWrite($pathImage&"1.tmp", $general, $ldplayerpath, $LD_Path); luu vo config
   EndIf
#EndRegion check LDplayer valid
If $nox_start == False and $ldp_start == False Then
   MsgBox(0,"","không tìm thấy đường dẫn của giả lập, vui lòng mở Ldplayer hoặc Nox")
   Exit 0
EndIf

Func _checkExpireDate($expireDate)
	   Local $currentDate = _getCurrentDate() ;MM/DD/YYYY
	   $current = StringRegExpReplace($currentDate, "[/]", "")
	   $expire = StringRegExpReplace($expireDate, "[/]", "")
	   If $current > $expire Then Return SetError(3)
EndFunc   ;==> check ExpireDate
;config path end

_checkMacIP()
_setHardMode(False)
_setAnExp(True)
_setCamTrainKhiHetNV(True)
_setAutoGhepVeBlood(True)
_setAutoAnThit(True)
_setAutoTruyenCong(True)

Gui()
Func Gui()

   ; Font type to be used for setting the font of the controls.
    Local Const $sFont = "Comic Sans Ms"
    ; Create a GUI with various controls.
	$TitleAuto = "Auto Mu Vượt Thời Đại"
    Local $hGUI = GUICreate($TitleAuto, 350, 735)
	GUISetBkColor(0xf2f2f2) ; will change background color
;~ 	Global $g_hStatus = _GUICtrlStatusBar_Create($hGUI)
    Global $JblNotify = GUICtrlCreateLabel("",5,710,200,30)
	GUICtrlSetFont($JblNotify, 9, 800, 0,"",$DEFAULT_QUALITY)
	;create list view
	Global $hListEmulators = GUICtrlCreateListView("List of emulators |Name|Status", 10, 10, 330, 100,$WS_DLGFRAME) ;,$LVS_SORTDESCENDING)
;~ 	Global $hList = GUICtrlGetHandle($hListEmulators)
	Global $ContextMenu = GUICtrlCreateContextMenu($hListEmulators)
	Global $hCMenuTextDel = GUICtrlCreateMenuItem("Delele", $ContextMenu)
	Global $sItemText,$indexItem,$sItemTextHoatDong,$indexItemHoatDong
    _GUICtrlListView_SetExtendedListViewStyle($hListEmulators, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
	GUICtrlSetFont($hListEmulators, 8, 800, 0, $sFont)
    Local $idButton_Close = GUICtrlCreateButton("Close", 271, 705, 70, 25)
    Local $idButton_Clean = GUICtrlCreateButton("Clean Log", 192, 705, 70, 25)
	Global $textarea = GUICtrlCreateEdit("", 10, 600, 330, 100) ; will not accept drag&drop files
	Local $idTab = GUICtrlCreateTab(10, 115, 332, 430) ;tao tab
	GUICtrlSetFont($idTab,11)
	Global $tabItemHoatDong = GUICtrlCreateTabItem("Hoạt động")
	Global $hListHoatDong = GUICtrlCreateListView("Nhiệm Vụ | Status | Setting  |", 10, 145, 330, 400,$WS_DLGFRAME) ;,$LVS_SORTDESCENDING)
	Global $hWndListHoatDong = GUICtrlGetHandle($hListHoatDong)
	_GUICtrlListView_SetColumnWidth($hListHoatDong, 2, 80)
;~ 	GUICtrlSetState($hListHoatDong,@SW_HIDE)
    Global $ContextMenuHoatDong = GUICtrlCreateContextMenu($hListHoatDong)
	Global $hCMenuTextWait = GUICtrlCreateMenuItem("Wait", $ContextMenuHoatDong)
	Global $hCMenuTextDone = GUICtrlCreateMenuItem("Done", $ContextMenuHoatDong)
	_GUICtrlListView_SetExtendedListViewStyle($hListHoatDong, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
	_GUICtrlListView_SetHoverTime($hListHoatDong, 1234)
	Global $countDevices = 0;
	Global $aCheck[10]    ; Array of CheckBoxes
	#Region get list emulator online
   ; Retrieve a list of window handles.
    Local $aList = WinList("[CLASS:Qt5QWindowIcon]") ; list Nox
	Local $aListLDPlayer = WinList("[CLASS:LDPlayerMainFrame]") ; list LD
	_ArrayAdd($aList,$aListLDPlayer) ; add LDplayer to Nox List
    ; Loop through the array displaying only visable windows with a title.
	#EndRegion
	Global $listNoxRunning[10]
    For $i = 1 To UBound($aList)-1
        If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) And (StringInStr($aList[$i][0], "NoxPlayer") OR StringInStr($aList[$i][0], "LDPlayer")) Then
		   $countDevices = $countDevices + 1
		   $listNoxRunning[$countDevices] = $aList[$i][0]&".tmp" ;set vo array
		   $aCheck[$countDevices] = GUICtrlCreateListViewItem($aList[$i][0], $hListEmulators) ;add emulators
;~ 		   GUICtrlSetFont($hListEmulators, 9, 800, 0, $sFont)
		   _FileCreate($path&$aList[$i][0]&".tmp")
		   _FileCreate($pathAuto&$aList[$i][0]&".tmp")
		   _FileCreate($pathstatus&$aList[$i][0]&".tmp")
		   _FileCreate($pathLog&$aList[$i][0]&".log")
		   _FileCreate($pathconfig&$aList[$i][0]&".config")
		   ; init checkbox
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $huyencanh, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $blood, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $bosscanhan, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $tienthuong, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $daomo, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $cuopmo, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $treomay, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $nvguild, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $tinhanh, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $laythanhvat, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $bossguild12h, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $tuhoiguild8h, True)
		   If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $devil, True)
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $baotang, True)
		   Else
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $devil, False)
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $baotang, False)
		   EndIf
		   If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $phaodai, True)
		   Else
			  IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $phaodai, False)
		   EndIf
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $hotroguild, True)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $bossthegioi, False)
		   IniWrite($path&$aList[$i][0]&".tmp", $hoatdong, $bosschientruong, False)
		   ; init status
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $huyencanh, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $blood, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $bosscanhan, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $tienthuong, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $daomo, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $cuopmo, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $treomay, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $nvguild, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $tinhanh, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $laythanhvat, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $bossguild12h, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $tuhoiguild8h, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $devil, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $baotang, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $phaodai, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $hotroguild, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $bossthegioi, $notyet)
		   IniWrite($pathstatus&$aList[$i][0]&".tmp", $status, $bosschientruong, $notyet)
		   ; init Run
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $pid, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $finish, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $nameingame, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $statusNox, $onl)
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $cmdStart, _setCmdStart($aList[$i][0]))
		   ; init Config
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $nvguildRankS, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $timewaitNvS, 60);60s
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $weaktinhanh, False)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $baotang11h, False)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $baotang21h, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $spbossTG, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $spbossctc, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $spcuopmo, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $sp_nvguildRankS, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $sp_timewaitNvS, 60);60s
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $cuop_mo_de, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $cuop_mo_thuong, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $cuop_mo_kho, False)
			;init config boss
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bossTG_top1, True)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bossTG_top2, False)
		   IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bossTG_top3, False)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss1, False)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss2, False)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss3, False)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss4, True)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss5, True)
			IniWrite($pathconfig&$aList[$i][0]&".config", $config, $bosCTC_boss6, True)
	    EndIf
	 Next
	 ;search tat ca gia lap da tung chay o foler config
	 $NoxList = _FileListToArrayRec($pathAuto, "*tmp", $FLTAR_FILES,0,0, $FLTAR_NOPATH )
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf

	_findAddEmulator($NoxList,$listNoxRunning);add emulator offlines


	Local $idButton_ResetStatus = GUICtrlCreateButton("Reset status", 256, 550, 85, 25)
	GUICtrlSetTip( -1, "Reset status của tất cả hoạt động về Wait")
    GUICtrlSetFont($idButton_ResetStatus, 9, $FW_MEDIUM ,  $GUI_FONTITALIC , $sFont) ; Set the font of the controlID stored in $iLabel3.
	Local $idCheckBoxCheckAll = GUICtrlCreateCheckbox("CHECK ALL", 10, 545, 100, 25)
	GUICtrlSetTip( -1, "Check hoặc bỏ check tất cả hoạt động")
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked

	Local $idCheckBoxHardMod = GUICtrlCreateCheckbox("HARD MODE", 10, 570, 100, 25)
	GUICtrlSetTip( -1, "Check : Auto sẽ không bao giờ dừng lại cho tới khi làm hết tất cả NV"&@CR&"Uncheck : Auto chỉ quét 1 lần")
	   ; Display the GUI.
	   ;;add list hoat dong
	$currentAuto = _GUICtrlListView_GetItemText($hListEmulators,0)

    Global $idItemHuyenCanh = GUICtrlCreateListViewItem("Huyễn Cảnh Trên Không||", $hListHoatDong)
	Global $idItemBlood = GUICtrlCreateListViewItem("Blood Castle||", $hListHoatDong)
	Global $idItemBossCaNhan = GUICtrlCreateListViewItem("Boss Cá Nhân||", $hListHoatDong)
	Global $idItemTienThuong = GUICtrlCreateListViewItem("Tiền Thưởng||", $hListHoatDong)
	Global $idItemDaoMo = GUICtrlCreateListViewItem("Đào Mỏ||", $hListHoatDong)
	Global $idItemCuopMo = GUICtrlCreateListViewItem("Cướp Mỏ||Config", $hListHoatDong)
	Global $idItemTreoMay = GUICtrlCreateListViewItem("Treo Máy||", $hListHoatDong)
	Global $idItemNVGuild = GUICtrlCreateListViewItem("Nhiệm Vụ Guild||Config", $hListHoatDong)
	Global $idItemTinhAnh = GUICtrlCreateListViewItem("Săn Tinh Anh||Config", $hListHoatDong)
	Global $idItemLayThanhVat = GUICtrlCreateListViewItem("Lấy Thánh Vật Thường ||", $hListHoatDong)
	Global $idItemBossGuild12h = GUICtrlCreateListViewItem("Boss Guild 12h ||", $hListHoatDong)
	Global $idItemTuHoiGuild12h = GUICtrlCreateListViewItem("Tụ Hội + Boss Guild 8h ||", $hListHoatDong)
	Global $idItemDevil = GUICtrlCreateListViewItem("Devil Square ||", $hListHoatDong)
	Global $idItemBaoTang = GUICtrlCreateListViewItem("Hộ Tống Bảo Tàng ||Config", $hListHoatDong)
	Global $idItemPhaoDai = GUICtrlCreateListViewItem("Pháo Đài Đỏ ||", $hListHoatDong)
	Global $idItemHoTro = GUICtrlCreateListViewItem("Hỗ Trợ Guild ||Config", $hListHoatDong)
	Global $idItemBossTG = GUICtrlCreateListViewItem("Boss Thế Giới ||Config", $hListHoatDong)
	Global $idItemBossCTC = GUICtrlCreateListViewItem("Boss Chiến Trường ||Config", $hListHoatDong)
;~ 	_GUICtrlStatusBar_SetText($g_hStatus, "Current Emulator: " & $currentAuto); set default
	GUICtrlSetData($JblNotify,"Current Emulator: " & $currentAuto)
	_GUICtrlListView_SetColumnWidth($hListHoatDong, 0, $LVSCW_AUTOSIZE) ;auto size column hoat dong
	_GUICtrlListView_SetColumnWidth($hListHoatDong, 1, $LVSCW_AUTOSIZE) ;auto size column status
;~ 	_GUICtrlListView_SetColumnWidth($hListHoatDong, 2, $LVSCW_AUTOSIZE) ;auto size column emulator
	_GUICtrlListView_SetColumnWidth($hListEmulators, 0, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status

	GUICtrlCreateTabItem("Tiện ích")
	Local $idCheckBoxAnExp = GUICtrlCreateCheckbox("Tự ăn đan EXP khi làm xong hết NV ", 20, 145, 200, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked
	Local $idCheckBoxCamTrain = GUICtrlCreateCheckbox("Cắm train khi hết NV ", 20, 170, 120, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked
	Local $idCheckBoxGhepVeBlood = GUICtrlCreateCheckbox("Tự ghép vé blood khi hết ", 20, 195, 140, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked
	Local $idCheckBoxAnThitTuHoi = GUICtrlCreateCheckbox("Tự ăn thịt trong tụ hội guild ", 20, 220, 150, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked
	Local $idCheckBoxTruyenCong = GUICtrlCreateCheckbox("Tự truyền công trong tụ hội guild ", 20, 245, 200, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked
    #region Panel1 config
    Global $ChildGuiConfig = GUICreate("", 319, 367, 12, 123, Default, $WS_EX_MDICHILD, $hGUI) ;;;WHLT
	;group NV Guild
	GUICtrlCreateGroup("Nhiệm Vụ Guild", 2, 5, 320, 45)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBoxNVGuildRankS = GUICtrlCreateCheckbox("NV cấp S", 10, 20, 70, 25)
	Global $idInputTimeWaitNVRankS = GUICtrlCreateInput("",110,23,25,15,$ES_NUMBER)
	Global $idLableText = GUICtrlCreateLabel("Đợi",90,25,20,15)
	Global $idLableText2 = GUICtrlCreateLabel("giây sau đó bỏ qua NV này",138,25,140,15)
	GUICtrlSetLimit(-1, 3) ; to limit the entry to 3 chars
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	;group NV Tinh Anh
	GUICtrlCreateGroup("Săn Tinh Anh", 2, 55, 320, 45)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBoxSanTinhAnh = GUICtrlCreateCheckbox("Săn tinh anh ở tầng thấp hơn 1 bậc", 10, 70, 200, 25)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
    ;group Hộ Tống Bảo Tàng
	GUICtrlCreateGroup("Hộ Tống Bảo Tàng", 2, 105, 320, 45)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBox11h = GUICtrlCreateCheckbox("11h -> 12h", 10, 120, 70, 25)
	Global $idCheckBox21h = GUICtrlCreateCheckbox("21h -> 22h", 110, 120, 70, 25)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	;group Hỗ Trợ Guild
	GUICtrlCreateGroup("Hỗ Trợ Guild", 2, 155, 320, 75)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBoxSPBossTG = GUICtrlCreateCheckbox("Boss TG", 10, 170, 80, 25)
	Global $idCheckBoxSPBossCTC = GUICtrlCreateCheckbox("Boss CTC", 110, 170, 100, 25)
	Global $idCheckBoxSPBossCuopLaiMo = GUICtrlCreateCheckbox("Cướp lại mỏ", 210, 170, 100, 25)
	Global $idCheckBoxSPNvS = GUICtrlCreateCheckbox("NV Guild S", 10, 195, 100, 25)
    Global $idInputSPWait = GUICtrlCreateInput("",130,198,25,15,$ES_NUMBER)
	Global $idLableSPText = GUICtrlCreateLabel("Đợi",110,200,20,15)
	Global $idLableSPText2 = GUICtrlCreateLabel("giây sau đó bỏ qua hỗ trợ",158,200,150,15)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	;group Cướp mỏ
	GUICtrlCreateGroup("Cướp Mỏ", 2, 235, 320, 45)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBoxMoDe = GUICtrlCreateCheckbox("Mỏ Dễ", 10, 250, 80, 25)
	Global $idCheckBoxMoThuong = GUICtrlCreateCheckbox("Mỏ thường", 110, 250, 100, 25)
	Global $idCheckBoxMoKho = GUICtrlCreateCheckbox("Mỏ khó", 210, 250, 100, 25)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	;Button Save
    Local $idBtn_Save = GUICtrlCreateButton("Save", 250, 365, 70, 25)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
	GUICtrlSetBkColor(-1, 0xf2f2f2)
    $iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($ChildGuiConfig), $GWL_STYLE)
    $iExStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($ChildGuiConfig), $GWL_EXSTYLE)
    GUISetStyle(BitOR($iStyle, $WS_VISIBLE), $iExStyle, $ChildGuiConfig)
	#endregion Panel1 config
	#region Panel1 config boss
    Global $ChildGuiConfig_Boss = GUICreate("", 319, 367, 12, 123, Default, $WS_EX_MDICHILD, $hGUI) ;;;WHLT
	;group Boss The Gioi
	GUICtrlCreateGroup("Boss Thế Giới", 2, 5, 320, 65)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idChonBossTop= GUICtrlCreateLabel("Chọn boss top ", 10, 20, 150, 25)
	Global $idRadio1 = GUICtrlCreateRadio("Top 1", 10, 40, 60, 20)
    Global $idRadio2= GUICtrlCreateRadio("Top 2", 110, 40, 60, 20)
    Global $idRadio3= GUICtrlCreateRadio("Top 3", 210, 40, 60, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	;group Boss CTC
	GUICtrlCreateGroup("Boss Chiến Trường", 2, 75, 320, 70)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
    Global $idCheckBoxCon1 = GUICtrlCreateCheckbox("Boss 1 (yếu nhất)", 10, 90, 100, 25)
    Global $idCheckBoxCon2 = GUICtrlCreateCheckbox("Boss 2", 110, 90, 50, 25)
    Global $idCheckBoxCon3 = GUICtrlCreateCheckbox("Boss 3", 210, 90, 50, 25)
    Global $idCheckBoxCon4 = GUICtrlCreateCheckbox("Boss 4", 10, 110, 50, 25)
    Global $idCheckBoxCon5 = GUICtrlCreateCheckbox("Boss 5", 110, 110, 50, 25)
    Global $idCheckBoxCon6 = GUICtrlCreateCheckbox("Boss 6 (mạnh nhất)", 210, 110, 110, 25)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
    ;Button Save boss config
    Local $idBtn_Save_Config = GUICtrlCreateButton("Save", 250, 365, 70, 25)
	GUICtrlSetFont(-1, 9, 800, 0,"",$DEFAULT_QUALITY)
	GUICtrlSetBkColor(-1, 0xf2f2f2)
    $iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($ChildGuiConfig_Boss), $GWL_STYLE)
    $iExStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($ChildGuiConfig_Boss), $GWL_EXSTYLE)
    GUISetStyle(BitOR($iStyle, $WS_VISIBLE), $iExStyle, $ChildGuiConfig_Boss)
	#endregion Panel1 config boss
    GUISetState(@SW_SHOW, $hGUI)
	GUISetState(@SW_HIDE, $ChildGuiConfig)
    GUISetState(@SW_HIDE, $ChildGuiConfig_Boss)
    GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
;~ 	GUICtrlSetState(-1, $GUI_SHOW) ; Use this!
	; Loop until the user exits.
    Local $iGuiMsg
	AdLibRegister("_updateAcTion", 6000);auto run this function every 5 s
	AdLibRegister("_updateEmulatorAuto", 5146);auto run this function every 5 s
    AdLibRegister("_updateStatusAuto", 3123);auto run this function every 3 s
	AdLibRegister("_refeshLogAuto", 3000);auto run this function every 3s
	_updateAcTion()
	_updateEmulatorAuto()

    While True
		$iGuiMsg = GUIGetMsg(1)
		Switch $iGuiMsg[1]
	     Case $hGUI
			Switch $iGuiMsg[0]
			   Case $GUI_EVENT_CLOSE ,$idButton_Close
				   _turnOffAuto()
				   ExitLoop
			   Case $idButton_Clean
				   _FileCreate($pathLog&$currentAuto&".log")
				   _refeshLogAuto()
   ;~ 			Case $aCheck[1] to $aCheck[$countDevices]  ; Put any other cases above this
   ;~                 ; Try to find a checkbox handle that matches the message
   ;~                 Local $vCheckIndex = FindCheckBox($aCheck, $iGuiMsg)
   ;~                 ; If there was a match
   ;~ 			   MsgBox(0, "listview item", _GUICtrlListView_GetItemTextString($hListEmulators, $vCheckIndex-1) & "    " & @CRLF & "Line Checked = " & $vCheckIndex, 2)
			   Case $idCheckBoxCheckAll
				   If _IsChecked($idCheckBoxCheckAll) Then
					  _checkAndUncheckAll(True);check
				   Else
					  _checkAndUncheckAll(False);uncheck
				   EndIf
			   Case $idButton_ResetStatus
				   _resetStatus()
			   Case $hCMenuTextDel
				   deleteItemEmulator()
			   Case $hCMenuTextWait
				   changeStatus($notyet)
			   Case $hCMenuTextDone
				   changeStatus($done)
			   Case $idCheckBoxHardMod
				   If _IsChecked($idCheckBoxHardMod) Then
					  _setHardMode(True)
				   Else
					  _setHardMode(False)
				   EndIf
			   Case $idCheckBoxAnExp
				   If _IsChecked($idCheckBoxAnExp) Then
					  _setAnExp(True)
				   Else
					  _setAnExp(False)
				   EndIf
			   Case $idCheckBoxCamTrain
				   If _IsChecked($idCheckBoxCamTrain) Then
					  _setCamTrainKhiHetNV(True)
				   Else
					  _setCamTrainKhiHetNV(False)
				   EndIf
			   Case $idCheckBoxGhepVeBlood
				   If _IsChecked($idCheckBoxGhepVeBlood) Then
					  _setAutoGhepVeBlood(True)
				   Else
					  _setAutoGhepVeBlood(False)
				   EndIf
			   Case $idCheckBoxAnThitTuHoi
				   If _IsChecked($idCheckBoxAnThitTuHoi) Then
					  _setAutoAnThit(True)
				   Else
					  _setAutoAnThit(False)
				   EndIf
			   Case $idCheckBoxTruyenCong
				   If _IsChecked($idCheckBoxTruyenCong) Then
					  _setAutoTruyenCong(True)
				   Else
					  _setAutoTruyenCong(False)
				   EndIf
			EndSwitch
		 Case $ChildGuiConfig ;button Save config
			Switch $iGuiMsg[0]
			   Case $idBtn_Save
				   writeconfig()
				   WinSetState($hWndListHoatDong,"",@SW_SHOW)
				   GUISetState(@SW_HIDE, $ChildGuiConfig)
				   GUISetState(@SW_HIDE, $ChildGuiConfig_Boss)
				   GUICtrlSetState($tabItemHoatDong, $GUI_SHOW) ; Use this!
			EndSwitch
		 Case $ChildGuiConfig_Boss ;button Save config boss
			Switch $iGuiMsg[0]
			   Case $idBtn_Save_Config
				   writeconfig()
				   WinSetState($hWndListHoatDong,"",@SW_SHOW)
				   GUISetState(@SW_HIDE, $ChildGuiConfig)
				   GUISetState(@SW_HIDE, $ChildGuiConfig_Boss)
				   GUICtrlSetState($tabItemHoatDong, $GUI_SHOW) ; Use this!
			EndSwitch
		 EndSwitch
    WEnd

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>Example

	 ; Check if the passed handle is in the array, and return location or False
Func FindCheckBox($aCheckBoxes, $hCheck)
        For $col=1 To $countDevices
            If $aCheckBoxes[$col] = $hCheck Then
                Return $col
            EndIf
        Next
    Return False
 EndFunc
Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func ItemChecked_Proc_RunAuto($iIndex,$iItem, $sState)
;~     ConsoleWrite("<" & $iItem & "> is checked = " & $sState & "Index = "& $iIndex &@CRLF)
	If $sState == True Then
	   ;xoa log
	   _FileCreate($pathLog&$currentAuto&".log")
	   ;neu Nox dang off -> tang them time wait
	  Local $statusNoxx = IniRead($pathAuto&$iItem&".tmp", $run, $statusNox, "")
	  If $statusNoxx == $off Then
		 AdlibUnRegister("_updateStatusAuto")
	  EndIf
	  $filename = $iItem
	  If $oDictionary.Exists($currentAuto) Then
		 $sreadPID = IniRead($pathAuto&$currentAuto&".tmp", $run, $pid, "")
		 $sreadPID = $oDictionary.Item($currentAuto)
		 If $sreadPID <> "" Then
			If ProcessExists($sreadPID) Then
			ProcessClose($sreadPID)
			EndIf
		 EndIf
		 $oDictionary.Remove($currentAuto)
      EndIf

	  Local $iPID = Run("NoxPlayer"&" "&$filename)
	  IniWrite($pathAuto&$currentAuto&".tmp", $run, $pid, $iPID)
	  IniWrite($pathAuto&$currentAuto&".tmp", $run, $finish, "")
	  ConsoleWrite("Start PID = "&$iPID &@CRLF)
	  $oDictionary.Add($currentAuto,$iPID)
	  If $statusNoxx == $off Then
		 Sleep(1000)
		 AdLibRegister("_updateStatusAuto", 4000);auto run this function every 4 s
	  EndIf
   Else
	  $sreadPID = IniRead($pathAuto&$currentAuto&".tmp", $run, $pid, "")
	  $sreadPID = $oDictionary.Item($currentAuto)
	  ConsoleWrite("End PID = "&$sreadPID &@CRLF)
	  If ProcessExists($sreadPID) Then
		 $oDictionary.Remove($currentAuto)
		 ProcessClose($sreadPID)
	  EndIf
	EndIf
EndFunc
 Func ItemChecked_Proc_TurnOnOffAction($iIndex,$iItem, $sState)
    ConsoleWrite("<" & $iItem & "> is checked = " & $sState & "Index = "& $iIndex &@CRLF)
	  Switch $iIndex
		  Case 0 ;huyen canh tren khong
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $huyencanh, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $huyencanh, False)
			  EndIf
		  Case 1 ; blood
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $blood, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $blood, False)
			  EndIf
		  Case 2 ; boss ca nhan
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosscanhan, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosscanhan, False)
			  EndIf
		  Case 3 ; tien thuong
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tienthuong, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tienthuong, False)
			  EndIf
		  Case 4 ; daomo
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $daomo, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $daomo, False)
			  EndIf
		  Case 5 ; cuop mo
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $cuopmo, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $cuopmo, False)
			  EndIf
		  Case 6 ; treo may
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $treomay, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $treomay, False)
			  EndIf
		  Case 7 ; nv guild
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $nvguild, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $nvguild, False)
			  EndIf
		  Case 8 ; san tinh anh
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tinhanh, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tinhanh, False)
			  EndIf
		  Case 9 ; lay thanh vat
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $laythanhvat, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $laythanhvat, False)
			  EndIf
		  Case 10 ; boss guild 12h
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossguild12h, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossguild12h, False)
			  EndIf
		  Case 11 ; Tu hoi + boss guild 8h
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tuhoiguild8h, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tuhoiguild8h, False)
			  EndIf
		  Case 12 ; Devil square
			  If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
			     If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, True)
				 Else
					IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, False)
				 EndIf
			  Else
				 If $sState == True Then
				   MsgBox(0,"","Hôm nay không có devil",2)
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, False)
				   _updateAcTion()
				 Else
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, False)
				 EndIf
			  EndIf
		  Case 13 ; Hộ Tống
			  If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
			     If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, True)
				 Else
					IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, False)
				 EndIf
			  Else
				 If $sState == True Then
				   MsgBox(0,"","Hôm nay không có Hộ Tống Bảo Tàng",2)
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, False)
				   _updateAcTion()
				 Else
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, False)
				 EndIf
			  EndIf

		 Case 14 ; Pháo Đài
			  If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
			     If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, True)
				 Else
					IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, False)
				 EndIf
			  Else
				 If $sState == True Then
				   MsgBox(0,"","Hôm nay không có Pháo Đài Đỏ",2)
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, False)
				   _updateAcTion()
				 Else
				   IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, False)
				 EndIf
			  EndIf
		  Case 15 ; hỖ TRỢ guild
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $hotroguild, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $hotroguild, False)
			  EndIf
		  Case 16 ; Boss TG
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossthegioi, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossthegioi, False)
			  EndIf
		  Case 17 ; Boss CTC
			  If $sState == True Then
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosschientruong, True)
			  Else
				 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosschientruong, False)
			  EndIf
		EndSwitch
EndFunc
Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView
    $hWndListView1 = $hListEmulators
    If Not IsHWnd($hListEmulators) Then $hWndListView1 = GUICtrlGetHandle($hListEmulators)
    $hWndListView2 = $hListHoatDong
    If Not IsHWnd($hListHoatDong) Then $hWndListView2 = GUICtrlGetHandle($hListHoatDong)
    $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    Switch $hWndFrom
        Case $hWndListView1 ;list gia lap
            Switch $iCode
			   Case $NM_CLICK; click trai
				  Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
				  Local $iIndex = DllStructGetData($tInfo, "Index")
				  If $iIndex <> -1 Then
				  Local $iX = DllStructGetData($tInfo, "X")
				  Local $iPart = 1
				  If _GUICtrlListView_GetView($hListEmulators) = 1 Then $iPart = 2 ;for large icons view

				  Local $aIconRect = _GUICtrlListView_GetItemRect($hListEmulators, $iIndex, $iPart)

				  If $iX < $aIconRect[0] And $iX >= 5 Then
					   _reloadEmu(_GUICtrlListView_GetItemText($hListEmulators, $iIndex)) ;reload Hoat dong
					  ItemChecked_Proc_RunAuto($iIndex,_GUICtrlListView_GetItemText($hListEmulators, $iIndex), _
						  _GUICtrlListView_GetItemChecked($hListEmulators, $iIndex) = 0)
					  Return 0
				  Else;click vo item without checkbox
;~ 							  ConsoleWrite(_GUICtrlListView_GetItemText($hListEmulators, $iIndex))
					 _reloadEmu(_GUICtrlListView_GetItemText($hListEmulators, $iIndex));reload Hoat dong
				  EndIf
			   EndIf
			  Case $NM_RCLICK ;If it was a right click...to list gia lap
				 $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam) ;get the information about the item clicked.
				 ;store the item text in a global variable in case the get text option is clicked.
				 $sItemText =  _GUICtrlListView_GetItemText($hWndListView1, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
			     $indexItem = _GUICtrlListView_GetHotItem($hWndListView1) ;store the item index in a global variable in case the get text option is clicked.
			  Case $NM_DBLCLK,$NM_RDBLCLK ; double click trai or phai
			  Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
			  Local $iIndex = DllStructGetData($tInfo, "Index")
			  If $iIndex <> -1 Then
				  Local $iX = DllStructGetData($tInfo, "X")
				  Local $iPart = 1
				  If _GUICtrlListView_GetView($hListEmulators) = 1 Then $iPart = 2 ;for large icons view

				  Local $aIconRect = _GUICtrlListView_GetItemRect($hListEmulators, $iIndex, $iPart)

				  If $iX < $aIconRect[0] And $iX >= 5 Then
					   _reloadEmu(_GUICtrlListView_GetItemText($hListEmulators, $iIndex)) ;reload Hoat dong
					  ItemChecked_Proc_RunAuto($iIndex,_GUICtrlListView_GetItemText($hListEmulators, $iIndex), _
						  _GUICtrlListView_GetItemChecked($hListEmulators, $iIndex) = 0)
					  Return 0
				   Else;click vo item without checkbox
						Opt("WinTitleMatchMode", 3)
						WinActivate(_GUICtrlListView_GetItemText($hListEmulators, $iIndex))
						_reloadEmu(_GUICtrlListView_GetItemText($hListEmulators, $iIndex));reload Hoat dong
				   EndIf

			  EndIf
		    EndSwitch
		 Case $hWndListView2 ; list hoat dong
            Switch $iCode
                Case $NM_CLICK, $NM_DBLCLK
                    Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					;store the item text in a global variable in case the get text option is clicked.
					$sItemTextHoatDong =  _GUICtrlListView_GetItemText($hWndListView2, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
			        $indexItemHoatDong = _GUICtrlListView_GetHotItem($hWndListView2) ;store the item index in a global variable in case the get text option is clicked.
                    Local $iIndex = DllStructGetData($tInfo, "Index")

                    If $iIndex <> -1 Then
                        Local $iX = DllStructGetData($tInfo, "X")
                        Local $iPart = 1
                        If _GUICtrlListView_GetView($hListHoatDong) = 1 Then $iPart = 2 ;for large icons view

                        Local $aIconRect = _GUICtrlListView_GetItemRect($hListHoatDong, $iIndex, $iPart)

                        If $iX < $aIconRect[0] And $iX >= 5 Then ;click vo checkbox
                            ItemChecked_Proc_TurnOnOffAction($iIndex,_GUICtrlListView_GetItemText($hListHoatDong, $iIndex), _
                                _GUICtrlListView_GetItemChecked($hListHoatDong, $iIndex) = 0)
                            Return 0
						 Else
							checkConfigurator()
						 EndIf
					  EndIf
			   Case $NM_RCLICK ;If it was a right click...to list hoat dong
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam) ;get the information about the item clicked.
					;store the item text in a global variable in case the get text option is clicked.
					$sItemTextHoatDong =  _GUICtrlListView_GetItemText($hWndListView2, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
					$indexItemHoatDong = _GUICtrlListView_GetHotItem($hWndListView2) ;store the item index in a global variable in case the get text option is clicked.
;~ 			   Case $LVN_HOTTRACK ; Sent by a list-view control when the user moves the mouse over an item
;~                     $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
;~                     ListView_HOTTRACK(DllStructGetData($tInfo, "SubItem"))
            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
 EndFunc

Func _updateAcTion()
;~      _ProcessSuspend(_getProcess()) ;pause script
     ;update huyen canh line 0
     Local $sReadhuyencanh = IniRead($path&$currentAuto&".tmp", $hoatdong, $huyencanh, False)
	 Local $statushuyencanh = IniRead($pathstatus&$currentAuto&".tmp", $status, $huyencanh, $notyet)
	 GUICtrlSetData($idItemHuyenCanh, "|"&$statushuyencanh&"")
	 GUICtrlSetColor($idItemHuyenCanh,_changeColor($statushuyencanh))
	 If $sReadhuyencanh == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 0)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 0,False)
	 EndIf
     ;update blood line 1
     Local $sReadblood = IniRead($path&$currentAuto&".tmp", $hoatdong, $blood, False)
	 Local $statusblood = IniRead($pathstatus&$currentAuto&".tmp", $status, $blood, $notyet)
	 GUICtrlSetData($idItemBlood, "|"&$statusblood)
	 GUICtrlSetColor($idItemBlood,_changeColor($statusblood))
	 If $sReadblood == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 1)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 1,False)
	 EndIf
	 ;update boss ca nhan line 2
     Local $sReadbosscanhan = IniRead($path&$currentAuto&".tmp", $hoatdong, $bosscanhan, False)
	 Local $statusbosscanhan = IniRead($pathstatus&$currentAuto&".tmp", $status, $bosscanhan, $notyet)
	 GUICtrlSetData($idItemBossCaNhan, "|"&$statusbosscanhan)
	 GUICtrlSetColor($idItemBossCaNhan,_changeColor($statusbosscanhan))
	 If $sReadbosscanhan == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 2)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 2,False)
	 EndIf
     ;update nv tien thuong line 3
     Local $sReadtienthuong = IniRead($path&$currentAuto&".tmp", $hoatdong, $tienthuong, False)
	 Local $statustienthuong = IniRead($pathstatus&$currentAuto&".tmp", $status, $tienthuong, $notyet)
	 GUICtrlSetData($idItemTienThuong, "|"&$statustienthuong)
	 GUICtrlSetColor($idItemTienThuong,_changeColor($statustienthuong))
	 If $sReadtienthuong == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 3)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 3,False)
	 EndIf
	 ;update dao mo line 4
     Local $sReaddaomo = IniRead($path&$currentAuto&".tmp", $hoatdong, $daomo, False)
	 Local $statusdaomo = IniRead($pathstatus&$currentAuto&".tmp", $status, $daomo, $notyet)
	 GUICtrlSetData($idItemDaoMo, "|"&$statusdaomo)
	 GUICtrlSetColor($idItemDaoMo,_changeColor($statusdaomo))
	 If $sReaddaomo == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 4)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 4,False)
	 EndIf
	 ;update cuop mo line 5
     Local $sReadcuopmo = IniRead($path&$currentAuto&".tmp", $hoatdong, $cuopmo, False)
	 Local $statuscuopmo = IniRead($pathstatus&$currentAuto&".tmp", $status, $cuopmo, $notyet)
	 GUICtrlSetData($idItemCuopMo, "|"&$statuscuopmo)
	 GUICtrlSetColor($idItemCuopMo,_changeColor($statuscuopmo))
	 If $sReadcuopmo == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 5)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 5,False)
	 EndIf
	  ;update treomay line 6
     Local $sReadtreomay = IniRead($path&$currentAuto&".tmp", $hoatdong, $treomay, False)
	 Local $statustreomay = IniRead($pathstatus&$currentAuto&".tmp", $status, $treomay, $notyet)
	 GUICtrlSetData($idItemTreoMay, "|"&$statustreomay)
	 GUICtrlSetColor($idItemTreoMay,_changeColor($statustreomay))
	 If $sReadtreomay == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 6)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 6,False)
	 EndIf
	  ;update nv guild line 7
     Local $sReadnvguild = IniRead($path&$currentAuto&".tmp", $hoatdong, $nvguild, False)
	 Local $statusnvguild = IniRead($pathstatus&$currentAuto&".tmp", $status, $nvguild, $notyet)
	 GUICtrlSetData($idItemNVGuild, "|"&$statusnvguild)
	 GUICtrlSetColor($idItemNVGuild,_changeColor($statusnvguild))
	 If $sReadnvguild == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 7)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 7,False)
	 EndIf
	  ;update nv tinh anh line 8
     Local $sReadnvtinhanh = IniRead($path&$currentAuto&".tmp", $hoatdong, $tinhanh, False)
	 Local $statustinhanh = IniRead($pathstatus&$currentAuto&".tmp", $status, $tinhanh, $notyet)
	 GUICtrlSetData($idItemTinhAnh, "|"&$statustinhanh)
	 GUICtrlSetColor($idItemTinhAnh,_changeColor($statustinhanh))
	 If $sReadnvtinhanh == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 8)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 8,False)
	 EndIf
	  ;update nv lay thanh vat line 9
     Local $sReadLayThanhVat = IniRead($path&$currentAuto&".tmp", $hoatdong, $laythanhvat, False)
	 Local $statuslaythanhvat = IniRead($pathstatus&$currentAuto&".tmp", $status, $laythanhvat, $notyet)
	 GUICtrlSetData($idItemLayThanhVat, "|"&$statuslaythanhvat)
	 GUICtrlSetColor($idItemLayThanhVat,_changeColor($statuslaythanhvat))
	 If $sReadLayThanhVat == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 9)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 9,False)
	 EndIf
      ;update bossguild 12h line 10
     Local $sReadBossGuild12h = IniRead($path&$currentAuto&".tmp", $hoatdong, $bossguild12h, False)
	 Local $statusbossguild12h = IniRead($pathstatus&$currentAuto&".tmp", $status, $bossguild12h, $notyet)
	 GUICtrlSetData($idItemBossGuild12h, "|"&$statusbossguild12h)
	 GUICtrlSetColor($idItemBossGuild12h,_changeColor($statusbossguild12h))
	 If $sReadBossGuild12h == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 10)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 10,False)
	 EndIf
	  ;update bossguild 12h line 11
     Local $sReadTuHoiGuild = IniRead($path&$currentAuto&".tmp", $hoatdong, $tuhoiguild8h, False)
	 Local $statusTuHoiGuild = IniRead($pathstatus&$currentAuto&".tmp", $status, $tuhoiguild8h, $notyet)
	 GUICtrlSetData($idItemTuHoiGuild12h, "|"&$statusTuHoiGuild)
	 GUICtrlSetColor($idItemTuHoiGuild12h,_changeColor($statusTuHoiGuild))
	 If $sReadTuHoiGuild == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 11)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 11,False)
	 EndIf
	 ;update devil square 8h30 line 12
     Local $sReadDevil = IniRead($path&$currentAuto&".tmp", $hoatdong, $devil, False)
	 Local $statusDevil = IniRead($pathstatus&$currentAuto&".tmp", $status, $devil, $notyet)
	 GUICtrlSetData($idItemDevil, "|"&$statusDevil)
	 GUICtrlSetColor($idItemDevil,_changeColor($statusDevil))
	 If $sReadDevil == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 12)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 12,False)
	 EndIf

	 ;update Hộ Tống Bảo Tàng 11h > 12h and 9h > 10h line 13
     Local $sReadBaoTang = IniRead($path&$currentAuto&".tmp", $hoatdong, $baotang, False)
	 Local $statusBaoTang = IniRead($pathstatus&$currentAuto&".tmp", $status, $baotang, $notyet)
	 GUICtrlSetData($idItemBaoTang, "|"&$statusBaoTang)
	 GUICtrlSetColor($idItemBaoTang,_changeColor($statusBaoTang))
	 If $sReadBaoTang == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 13)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 13,False)
	 EndIf
	 ;update Pháo đài đỏ 20h30 line 14
     Local $sReadPhaoDai = IniRead($path&$currentAuto&".tmp", $hoatdong, $phaodai, False)
	 Local $statusPhaoDai = IniRead($pathstatus&$currentAuto&".tmp", $status, $phaodai, $notyet)
	 GUICtrlSetData($idItemPhaoDai, "|"&$statusPhaoDai)
	 GUICtrlSetColor($idItemPhaoDai,_changeColor($statusPhaoDai))
	 If $sReadPhaoDai == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 14)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 14,False)
	 EndIf
	 ;auto update ho tro guild line 15
	 Local $sReadHoTro = IniRead($path&$currentAuto&".tmp", $hoatdong, $hotroguild, False)
	 Local $statusHotro = IniRead($pathstatus&$currentAuto&".tmp", $status, $hotroguild, $notyet)
	 GUICtrlSetData($idItemHoTro, "|"&$statusHotro)
	 GUICtrlSetColor($idItemHoTro,_changeColor($statusHotro))
	 If $sReadHoTro == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 15)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 15,False)
	 EndIf
	 ;auto update boss tg line 16
	 Local $sReadBossTG = IniRead($path&$currentAuto&".tmp", $hoatdong, $bossthegioi, False)
	 Local $statusBossTG = IniRead($pathstatus&$currentAuto&".tmp", $status, $bossthegioi, $notyet)
	 GUICtrlSetData($idItemBossTG, "|"&$statusBossTG)
	 GUICtrlSetColor($idItemBossTG,_changeColor($statusBossTG))
	 If $sReadBossTG == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 16)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 16,False)
	 EndIf
	 ;auto update boss ctc line 17
	 Local $sReadBossCTC = IniRead($path&$currentAuto&".tmp", $hoatdong, $bosschientruong, False)
	 Local $statusBossCTC = IniRead($pathstatus&$currentAuto&".tmp", $status, $bosschientruong, $notyet)
	 GUICtrlSetData($idItemBossCTC, "|"&$statusBossCTC)
	 GUICtrlSetColor($idItemBossCTC,_changeColor($statusBossCTC))
	 If $sReadBossCTC == True Then
		_GUICtrlListView_SetItemChecked($hListHoatDong, 17)
	 Else
		_GUICtrlListView_SetItemChecked($hListHoatDong, 17,False)
	 EndIf
	 ;Auto resize column
	 _GUICtrlListView_SetColumnWidth($hListHoatDong, 1, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status
	 _GUICtrlListView_SetColumnWidth($hListEmulators, 0, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status
;~ 	 _ProcessResume(_getProcess());resume
  EndFunc
Func _reloadEmu($switch)
     $currentAuto =  $switch
     _updateAcTion()
	 _refeshLogAuto()
	 readconfig()
	 ;update staus bar
;~ 	 _GUICtrlStatusBar_SetText($g_hStatus, "Current Emulator: " & $currentAuto)
	 GUICtrlSetData($JblNotify,"Current Emulator: " & $currentAuto)

EndFunc
Func _changeColor($status)
	 IF $status == $done then Return 0xFF0000
	 If $status == $doing Then Return 0x0000FF
     Return 0
EndFunc
Func _resetStatus()
     IniWrite($pathstatus&$currentAuto&".tmp", $status, $huyencanh, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $blood, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $bosscanhan, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $tienthuong, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $daomo, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $cuopmo, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $treomay, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $nvguild, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $tinhanh, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $laythanhvat, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $bossguild12h, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $tuhoiguild8h, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $devil, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $baotang, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $phaodai, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $hotroguild, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $bossthegioi, $notyet)
	 IniWrite($pathstatus&$currentAuto&".tmp", $status, $bosschientruong, $notyet)
     _updateAcTion()

EndFunc
Func _checkAndUncheckAll($sState)
     IniWrite($path&$currentAuto&".tmp", $hoatdong, $huyencanh, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $blood, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosscanhan, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tienthuong, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $daomo, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $cuopmo, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $treomay, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $nvguild, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tinhanh, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $laythanhvat, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossguild12h, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $tuhoiguild8h, $sState)
	 IniWrite($path&$currentAuto&".tmp", $hoatdong, $hotroguild, $sState)
	 If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
		 IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, $sState)
		 IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, $sState)
	 Else
		 If $sState == True Then
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, False)
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, False)
		 Else
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $devil, $sState)
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $baotang, $sState)
		 EndIf
	  EndIf
	  If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
		 IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, $sState)
	 Else
		 If $sState == True Then
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, False)
		 Else
			IniWrite($path&$currentAuto&".tmp", $hoatdong, $phaodai, $sState)
		 EndIf
	  EndIf
	  IniWrite($path&$currentAuto&".tmp", $hoatdong, $bossthegioi, $sState)
	  IniWrite($path&$currentAuto&".tmp", $hoatdong, $bosschientruong, $sState)
     _updateAcTion()

EndFunc

Func _setHardMode($sState)
     IniWrite($pathImage&"1.tmp", $general, $hardmode, $sState)
  EndFunc
Func _setAnExp($sState)
     IniWrite($pathImage&"1.tmp", $general, $anExp, $sState)
  EndFunc
Func _setCamTrainKhiHetNV($sState)
     IniWrite($pathImage&"1.tmp", $general, $camtrain, $sState)
  EndFunc
Func _setAutoGhepVeBlood($sState)
     IniWrite($pathImage&"1.tmp", $general, $ghepveblood, $sState)
  EndFunc
Func _setAutoAnThit($sState)
     IniWrite($pathImage&"1.tmp", $general, $autoAnThit, $sState)
  EndFunc
Func _setAutoTruyenCong($sState)
     IniWrite($pathImage&"1.tmp", $general, $autoTruyenCong, $sState)
  EndFunc

Func _updateEmulatorAuto() ; refresh status AUTO emulator
     For $i = 0 to _GUICtrlListView_GetItemCount($hListEmulators)-1 ;total list size item
		$checkfn = IniRead($pathAuto&_GUICtrlListView_GetItemText($hListEmulators, $i)&".tmp", $run, $finish, False)
		If $checkfn == True Then _GUICtrlListView_SetItemChecked($hListEmulators,$i ,False)
	    ;check name character and statusNox
		Local $name = IniRead($pathAuto&_GUICtrlListView_GetItemText($hListEmulators, $i)&".tmp", $run, $nameingame, "")
		Local $statusNoxx = IniRead($pathAuto&_GUICtrlListView_GetItemText($hListEmulators, $i)&".tmp", $run, $statusNox, "")
	    GUICtrlSetData($aCheck[$i+1], "|"&$name&"|"&$statusNoxx)
	 Next
	 _GUICtrlListView_SetColumnWidth($hListEmulators, 0, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column hoat dong
	 _GUICtrlListView_SetColumnWidth($hListEmulators, 1, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status
  EndFunc
Func _updateStatusAuto() ; update status AUTO emulator
	  Local $NoxListConfig = _FileListToArrayRec($pathAuto, "*tmp", $FLTAR_FILES,0,0, $FLTAR_NOPATH )
	  Local $ListNox = WinList("[CLASS:Qt5QWindowIcon]"); list Nox
	  Local $ListLDPlayer = WinList("[CLASS:LDPlayerMainFrame]"); list LDPlayer
	  _ArrayAdd($ListNox,$ListLDPlayer) ; add LDplayer to Nox List
;~ 	  _ArrayDisplay($ListNox)
	  Local $count = 0
	  Local $NoxRunning[10]
	  For $i = 1 To UBound($ListNox)-1
        If $ListNox[$i][0] <> "" And BitAND(WinGetState($ListNox[$i][1]), 2) And (StringInStr($ListNox[$i][0], "NoxPlayer") Or StringInStr($ListNox[$i][0], "LDPlayer")) Then
		   $count = $count + 1
		   $NoxRunning[$count] = $ListNox[$i][0]&".tmp" ;set vo array
	    EndIf
	 Next
;~ 	 _ArrayDisplay($NoxRunning)
	  For $i = 1 To UBound($NoxListConfig)-1
        $found = _ArraySearch($NoxRunning, $NoxListConfig[$i])
        If $found = -1 Then ; ko search thay la Nox Off
		    Local $NoxOff = StringSplit($NoxListConfig[$i],".")[1]
;~             ConsoleWrite("Nox Off :"&$NoxOff&@CRLF)
			IniWrite($pathAuto&$NoxListConfig[$i], $run, $statusNox, $off)
			;Tat Auto
			IniWrite($pathAuto&$NoxListConfig[$i], $run, $finish,True) ; update finish AUTO
			Local $sreadPID = IniRead($pathAuto&$NoxListConfig[$i], $run, $pid, "")
			If $sreadPID <> "" Then ;exit Auto.exe
			   If ProcessExists($sreadPID) Then
			   ProcessClose($sreadPID)
			   EndIf
			EndIf
		 Else
			Local $NoxOnl = StringSplit($NoxListConfig[$i],".")[1]
;~ 			ConsoleWrite("Nox On :"&$NoxOnl&@CRLF)
			IniWrite($pathAuto&$NoxListConfig[$i], $run, $statusNox, $onl)
		 EndIf

    Next
EndFunc

Func _refeshLogAuto() ; Clear LOG AUTO emulator
   GUICtrlSetData($textarea, FileRead($pathLog&$currentAuto&".log"));clear log
EndFunc
Func _turnOffAuto() ; Turn off all auto
     For $i = 0 to _GUICtrlListView_GetItemCount($hListEmulators)-1 ;total list size item
		Local $item = _GUICtrlListView_GetItemText($hListEmulators, $i)
		If $oDictionary.Exists($item) Then
		 $checkPID = $oDictionary.Item($item)
		 If ProcessExists($checkPID) Then
			ProcessClose($checkPID)
		 EndIf
		EndIf
	 Next
EndFunc
Func _checkMacIP() ; check moi may chi xai dc 1 auto
   $AdapterList = GetAdaptersList(); ham get adapter
   $MacString = $AdapterList[1][2] ;get dia chi Mac
   $checkMac = IniRead($pathImage&"1.tmp", $general, $mac, False) ; kiem tra xong config
   If $checkMac == False Then
	  IniWrite($pathImage&"1.tmp", $general, $mac, $MacString)
   Else
	  If $MacString == $checkMac Then
	  Else
		 MsgBox(0,"","Auto da dc su dung o may khac")
		 Exit
	  EndIf
   EndIf
EndFunc
Func _findAddEmulator($NoxList,$listNoxRunning)
   For $i = 1 To UBound($NoxList)-1
	 $found = _ArraySearch($listNoxRunning, $NoxList[$i])
	 If $found = -1 Then ; ko search thay list out ra
		 $NoxOff = StringSplit($NoxList[$i],".")[1]
		 $countDevices = $countDevices + 1
		 $aCheck[$countDevices] = GUICtrlCreateListViewItem($NoxOff, $hListEmulators) ;add emulators
		 _FileCreate($pathLog&$NoxOff&".log")
		 _FileCreate($pathconfig&$NoxOff&".config")
		 ; init checkbox
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $huyencanh, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $blood, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $bosscanhan, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $tienthuong, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $daomo, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $cuopmo, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $treomay, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $nvguild, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $tinhanh, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $laythanhvat, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $bossguild12h, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $tuhoiguild8h, True)
		If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $devil, True)
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $baotang, True)
		Else
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $devil, False)
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $baotang, False)
		EndIf
		If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $phaodai, True)
		Else
		   IniWrite($path&$NoxOff&".tmp", $hoatdong, $phaodai, False)
		EndIf
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $hotroguild, True)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $bossthegioi, False)
		IniWrite($path&$NoxOff&".tmp", $hoatdong, $bosschientruong, False)
		; init status
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $huyencanh, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $blood, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $bosscanhan, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $tienthuong, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $daomo, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $cuopmo, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $treomay, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $nvguild, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $tinhanh, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $laythanhvat, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $bossguild12h, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $tuhoiguild8h, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $devil, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $baotang, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $phaodai, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $hotroguild, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $bossthegioi, $notyet)
		IniWrite($pathstatus&$NoxOff&".tmp", $status, $bosschientruong, $notyet)
		; init Run
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $pid, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $finish, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $nameingame, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $statusNox, $off)
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $cmdStart, _setCmdStart($NoxOff))
	    ; init Config
		IniWrite($pathconfig&$NoxOff&".config", $config, $nvguildRankS, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $timewaitNvS, 60);60s
		IniWrite($pathconfig&$NoxOff&".config", $config, $weaktinhanh, False)
		IniWrite($pathconfig&$NoxOff&".config", $config, $baotang11h, False)
		IniWrite($pathconfig&$NoxOff&".config", $config, $baotang21h, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $spbossTG, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $spbossctc, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $spcuopmo, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $sp_nvguildRankS, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $sp_timewaitNvS, 60);60s
		IniWrite($pathconfig&$NoxOff&".config", $config, $cuop_mo_de, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $cuop_mo_thuong, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $cuop_mo_kho, False)
		 ;init config boss

		IniWrite($pathconfig&$NoxOff&".config", $config, $bossTG_top1, True)
		IniWrite($pathconfig&$NoxOff&".config", $config, $bossTG_top2, False)
		IniWrite($pathconfig&$NoxOff&".config", $config, $bossTG_top3, False)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss1, False)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss2, False)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss3, False)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss4, True)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss5, True)
		 IniWrite($pathconfig&$NoxOff&".config", $config, $bosCTC_boss6, True)
	 EndIf
   Next
 EndFunc


Func deleteItemEmulator()
   ConsoleWrite($sItemText&@CRLF)
   ConsoleWrite($indexItem&@CRLF)
   $statsChecked = _GUICtrlListView_GetItemChecked($hListEmulators, $indexItem)
   if $statsChecked == True Then
	  MsgBox($MB_SYSTEMMODAL, "Information", "Không Thể Xóa Auto Đang Chạy")
   Else
	  _GUICtrlListView_DeleteItem($hListEmulators, $indexItem); delete item in list emulator
	  FileDelete($path&$sItemText&".tmp");delete file in config
	  FileDelete($pathstatus&$sItemText&".tmp");delete file in config
	  FileDelete($pathAuto&$sItemText&".tmp");delete file in config
	  if $indexItem == 0 Then ; neu xoa vi tri 0.. update lai current Auto
		 $currentAuto = _GUICtrlListView_GetItemText($hListEmulators,0)
		 _reloadEmu($currentAuto)
	  EndIf
   EndIf
EndFunc   ;==>
Func changeStatus($statusHoatDong)
	  Switch $indexItemHoatDong
		  Case 0 ;huyen canh tren khong
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $huyencanh, $statusHoatDong)
		  Case 1 ; blood
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $blood, $statusHoatDong)
		  Case 2 ; boss ca nhan
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $bosscanhan, $statusHoatDong)
		  Case 3 ; tien thuong
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $tienthuong, $statusHoatDong)
		  Case 4 ; daomo
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $daomo, $statusHoatDong)
		  Case 5 ; cuop mo
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $cuopmo, $statusHoatDong)
		  Case 6 ; treo may
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $treomay, $statusHoatDong)
		  Case 7 ; nv guild
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $nvguild, $statusHoatDong)
		  Case 8 ; san tinh anh
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $tinhanh, $statusHoatDong)
		  Case 9 ; lay thanh vat
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $laythanhvat, $statusHoatDong)
		  Case 10 ; boss guild 12h
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $bossguild12h, $statusHoatDong)
		  Case 11 ; Tu hoi + boss guild 8h
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $tuhoiguild8h, $statusHoatDong)
		  Case 12 ; Devil square
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $devil, $statusHoatDong)
		  Case 13 ; Hộ Tống
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $baotang, $statusHoatDong)

		  Case 14 ; Pháo Đài
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $phaodai, $statusHoatDong)
		  Case 15 ; hỖ TRỢ guild
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $hotroguild, $statusHoatDong)
		  Case 16 ; hỖ TRỢ guild
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $bossthegioi, $statusHoatDong)
		  Case 17 ; hỖ TRỢ guild
			   IniWrite($pathstatus&$currentAuto&".tmp", $status, $bosschientruong, $statusHoatDong)
	  EndSwitch
	  _updateAcTion()
EndFunc   ;==>
Func checkConfigurator()
   ConsoleWrite($sItemTextHoatDong&@CRLF)
   ConsoleWrite($indexItemHoatDong&@CRLF)
   if $sItemTextHoatDong == "Config" Then
	  WinSetState($hWndListHoatDong,"",@SW_HIDE)
	  readconfig()
	  If $indexItemHoatDong == 16 Or $indexItemHoatDong == 17 then ;config boss
		 GUISetState(@SW_SHOW, $ChildGuiConfig_Boss)
	  else
		 GUISetState(@SW_SHOW, $ChildGuiConfig)
	  endif

   EndIf
EndFunc   ;==>Copy2Dsktp

Func readconfig()
     ;NV GUILD
     Local $checkbox_config_NvGuildS = IniRead($pathconfig&$currentAuto&".config", $config, $nvguildRankS, False)
	 If $checkbox_config_NvGuildS == True Then
		GUICtrlSetState($idCheckBoxNVGuildRankS,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxNVGuildRankS,$GUI_UNCHECKED)
	 EndIf
     Local $checkbox_config_time_wait = IniRead($pathconfig&$currentAuto&".config", $config, $timewaitNvS, 60)
	 GUICtrlSetData($idInputTimeWaitNVRankS,$checkbox_config_time_wait)
	 ;NV San Tinh Anh
	 Local $checkbox_config_weaktinhanh = IniRead($pathconfig&$currentAuto&".config", $config, $weaktinhanh, False)
	 If $checkbox_config_weaktinhanh == True Then
		GUICtrlSetState($idCheckBoxSanTinhAnh,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxSanTinhAnh,$GUI_UNCHECKED)
	 EndIf
	 ;Ho Tong Bao Tang config
	 Local $checkbox_config_baotang11h = IniRead($pathconfig&$currentAuto&".config", $config, $baotang11h, False)
	 If $checkbox_config_baotang11h == True Then
		GUICtrlSetState($idCheckBox11h,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBox11h,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_baotang21h = IniRead($pathconfig&$currentAuto&".config", $config, $baotang21h, False)
	 If $checkbox_config_baotang21h == True Then
		GUICtrlSetState($idCheckBox21h,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBox21h,$GUI_UNCHECKED)
	 EndIf
	 ;Ho Tro Boss Guild
	 Local $checkbox_config_sp_bosstg = IniRead($pathconfig&$currentAuto&".config", $config, $spbossTG, False)
	 If $checkbox_config_sp_bosstg == True Then
		GUICtrlSetState($idCheckBoxSPBossTG,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxSPBossTG,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_sp_bossctc = IniRead($pathconfig&$currentAuto&".config", $config, $spbossctc, False)
	 If $checkbox_config_sp_bossctc == True Then
		GUICtrlSetState($idCheckBoxSPBossCTC,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxSPBossCTC,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_sp_cuopmo = IniRead($pathconfig&$currentAuto&".config", $config, $spcuopmo, False)
	 If $checkbox_config_sp_cuopmo == True Then
		GUICtrlSetState($idCheckBoxSPBossCuopLaiMo,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxSPBossCuopLaiMo,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_sp_NvS = IniRead($pathconfig&$currentAuto&".config", $config, $sp_nvguildRankS, False)
	 If $checkbox_config_sp_NvS == True Then
		GUICtrlSetState($idCheckBoxSPNvS,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxSPNvS,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_sp_time_wait = IniRead($pathconfig&$currentAuto&".config", $config, $sp_timewaitNvS, 60)
	 GUICtrlSetData($idInputSPWait,$checkbox_config_sp_time_wait)
     ;Cuop Mo config
     Local $checkbox_config_cuopmo_de = IniRead($pathconfig&$currentAuto&".config", $config, $cuop_mo_de, False)
	 If $checkbox_config_cuopmo_de == True Then
		GUICtrlSetState($idCheckBoxMoDe,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxMoDe,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_cuopmo_thuong = IniRead($pathconfig&$currentAuto&".config", $config, $cuop_mo_thuong, False)
	 If $checkbox_config_cuopmo_thuong == True Then
		GUICtrlSetState($idCheckBoxMoThuong,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxMoThuong,$GUI_UNCHECKED)
	 EndIf
	 Local $checkbox_config_cuopmo_kho = IniRead($pathconfig&$currentAuto&".config", $config, $cuop_mo_kho, False)
	 If $checkbox_config_cuopmo_kho == True Then
		GUICtrlSetState($idCheckBoxMoKho,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxMoKho,$GUI_UNCHECKED)
	 EndIf
     ;Boss TG config
     Local $checkbox_config_bosstop1 = IniRead($pathconfig&$currentAuto&".config", $config, $bossTG_top1, False)
     If $checkbox_config_bosstop1 == True Then
		GUICtrlSetState($idRadio1,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idRadio1,$GUI_UNCHECKED)
	 EndIf
	  Local $checkbox_config_bosstop2 = IniRead($pathconfig&$currentAuto&".config", $config, $bossTG_top2, False)
     If $checkbox_config_bosstop2 == True Then
		GUICtrlSetState($idRadio2,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idRadio2,$GUI_UNCHECKED)
	 EndIf
     Local $checkbox_config_bosstop3 = IniRead($pathconfig&$currentAuto&".config", $config, $bossTG_top3, False)
     If $checkbox_config_bosstop3 == True Then
		GUICtrlSetState($idRadio3,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idRadio3,$GUI_UNCHECKED)
	 EndIf
	  ;Boss CTC config
	  Local $checkbox_config_bossCTC_boss1 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss1, False) ;con 1
     If $checkbox_config_bossCTC_boss1 == True Then
		GUICtrlSetState($idCheckBoxCon1,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon1,$GUI_UNCHECKED)
	 EndIf
	  Local $checkbox_config_bossCTC_boss2 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss2, False); con 2
     If $checkbox_config_bossCTC_boss2 == True Then
		GUICtrlSetState($idCheckBoxCon2,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon2,$GUI_UNCHECKED)
	 EndIf
     Local $checkbox_config_bossCTC_boss3 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss3, False) ; con 3
     If $checkbox_config_bossCTC_boss3 == True Then
		GUICtrlSetState($idCheckBoxCon3,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon3,$GUI_UNCHECKED)
	 EndIf
	  Local $checkbox_config_bossCTC_boss4 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss4, False) ; con 4
     If $checkbox_config_bossCTC_boss4 == True Then
		GUICtrlSetState($idCheckBoxCon4,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon4,$GUI_UNCHECKED)
	 EndIf
     Local $checkbox_config_bossCTC_boss5 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss5, False) ; con 5
     If $checkbox_config_bossCTC_boss5 == True Then
		GUICtrlSetState($idCheckBoxCon5,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon5,$GUI_UNCHECKED)
	 EndIf
	  Local $checkbox_config_bossCTC_boss6 = IniRead($pathconfig&$currentAuto&".config", $config, $bosCTC_boss6, False) ; con 6
     If $checkbox_config_bossCTC_boss6 == True Then
		GUICtrlSetState($idCheckBoxCon6,$GUI_CHECKED)
	 Else
		GUICtrlSetState($idCheckBoxCon6,$GUI_UNCHECKED)
	 EndIf
EndFunc   ;=> readconfig
Func writeconfig()
     ;NV GUILD
	 If GUICtrlRead($idCheckBoxNVGuildRankS) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $nvguildRankS, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $nvguildRankS, False)
	 EndIf
	 IniWrite($pathconfig&$currentAuto&".config", $config, $timewaitNvS, GUICtrlRead($idInputTimeWaitNVRankS)) ; luu time wait
	 ;NV San Tinh Anh
	 If GUICtrlRead($idCheckBoxSanTinhAnh) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $weaktinhanh, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $weaktinhanh, False)
	 EndIf
	 ;Ho Tong Bao Tang config
	 If GUICtrlRead($idCheckBox11h) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $baotang11h, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $baotang11h, False)
	 EndIf
	 If GUICtrlRead($idCheckBox21h) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $baotang21h, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $baotang21h, False)
	 EndIf
	 ;Ho Tro Boss Guild
	 If GUICtrlRead($idCheckBoxSPBossTG) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $spbossTG, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $spbossTG, False)
	 EndIf
	 If GUICtrlRead($idCheckBoxSPBossCTC) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $spbossctc, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $spbossctc, False)
	 EndIf
	 If GUICtrlRead($idCheckBoxSPBossCuopLaiMo) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $spcuopmo, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $spcuopmo, False)
	 EndIf
	 If GUICtrlRead($idCheckBoxSPNvS) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $sp_nvguildRankS, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $sp_nvguildRankS, False)
	 EndIf
	 IniWrite($pathconfig&$currentAuto&".config", $config, $sp_timewaitNvS, GUICtrlRead($idInputSPWait)) ; luu time wait sp
     ;Cuop Mo config
	 If GUICtrlRead($idCheckBoxMoDe) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_de, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_de, False)
	 EndIf
	 If GUICtrlRead($idCheckBoxMoThuong) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_thuong, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_thuong, False)
	 EndIf
	 If GUICtrlRead($idCheckBoxMoKho) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_kho, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $cuop_mo_kho, False)
	 EndIf
	  ;Boss TG write config
     If GUICtrlRead($idRadio1) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top1, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top1, False)
	 EndIf
	  If GUICtrlRead($idRadio2) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top2, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top2, False)
	 EndIf
     If GUICtrlRead($idRadio3) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top3, True)
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bossTG_top3, False)
	 EndIf
    ;Boss CTC write config
	  If GUICtrlRead($idCheckBoxCon1) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss1, True) ;con 1
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss1, False)
	 EndIf
	  If GUICtrlRead($idCheckBoxCon2) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss2, True) ;con 2
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss2, False)
	 EndIf
	  If GUICtrlRead($idCheckBoxCon3) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss3, True) ;con 3
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss3, False)
	 EndIf
	  If GUICtrlRead($idCheckBoxCon4) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss4, True) ;con 4
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss4, False)
	 EndIf
	  If GUICtrlRead($idCheckBoxCon5) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss5, True) ;con 5
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss5, False)
	 EndIf
	  If GUICtrlRead($idCheckBoxCon6) = $GUI_CHECKED Then
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss6, True) ;con 6
	 Else
		IniWrite($pathconfig&$currentAuto&".config", $config, $bosCTC_boss6, False)
	 EndIf
EndFunc   ;=> writeconfig
Func _setCmdStart($Title) ; set cmd to start Nox
   If $Title == "NoxPlayer" Then
	  Return "Nox.exe"
   EndIf
   If $Title == "NoxPlayer(1)" Then
	  Return "Nox.exe -clone:Nox_1"
   EndIf
   If $Title == "NoxPlayer(2)" Then
	  Return "Nox.exe -clone:Nox_2"
   EndIf
   If $Title == "NoxPlayer(3)" Then
	  Return "Nox.exe -clone:Nox_3"
   EndIf
   If $Title == "NoxPlayer(4)" Then
	  Return "Nox.exe -clone:Nox_4"
   EndIf
   If $Title == "NoxPlayer(5)" Then
	  Return "Nox.exe -clone:Nox_5"
   EndIf
   If $Title == "LDPlayer" Then
	  Return "dnconsole.exe launch --index 0"
   EndIf
   If $Title == "LDPlayer-1" Then
	  Return "dnconsole.exe launch --index 1"
   EndIf
   If $Title == "LDPlayer-2" Then
	  Return "dnconsole.exe launch --index 2"
   EndIf
   If $Title == "LDPlayer-3" Then
	  Return "dnconsole.exe launch --index 3"
   EndIf
   If $Title == "LDPlayer-4" Then
	  Return "dnconsole.exe launch --index 4"
   EndIf
   If $Title == "LDPlayer-5" Then
	  Return "dnconsole.exe launch --index 5"
   EndIf
   Return ""
EndFunc

Func _WinGetPath($Title="")
   Local $pathNox = ""
   Opt("WinTitleMatchMode", 3)
   $win = WinGetTitle($Title)
   If $win == "" then Return $pathNox
   Local $processID = WinGetProcess($win)
   $pathNox = _WinAPI_ProcessGetPathname($processID)
   Return $pathNox
EndFunc

Func _getProcess() ; pause script
   If $oDictionary.Exists($currentAuto) Then
	  Local $sreadPID = $oDictionary.Item($currentAuto)
;~ 	  ConsoleWrite($sreadPID)
	  Return $sreadPID
   EndIf
EndFunc

Func ListView_HOTTRACK($iSubItem)
    Local $iHotItem = _GUICtrlListView_GetHotItem($hListHoatDong)
;~     If $iHotItem <> -1 Then _GUICtrlStatusBar_SetText($g_hStatus, "Hot Item: " & $iHotItem & " SubItem: " & $iSubItem)
EndFunc   ;==>ListView_HOTTRACK