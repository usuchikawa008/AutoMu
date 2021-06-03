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




;~  #include <_Dbug.au3>
Global $idDelete, $idEdit ,$oDictionary
$oDictionary = ObjCreate("Scripting.Dictionary")
Global $currentAuto
Global $dayofweek = _getDayofWeek()
;dir config file
Global Const $path = @ScriptDir&"\hoatdong\"
Global Const $pathstatus = @ScriptDir&"\status\"
Global Const $pathAuto = @ScriptDir&"\auto\"
Global Const $pathImage = @ScriptDir&"\image\"
Global Const $pathLog = @ScriptDir&"\log\"
Global Const $general = "General"
Global Const $hardmode = "HardMode"
Global Const $mac = "MAC"
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
_checkMacIP()
_setHardMode(False)
_setAnExp(True)
_setCamTrainKhiHetNV(True)
_setAutoGhepVeBlood(True)
_setAutoAnThit(True)
_setAutoTruyenCong(True)
_setBoQuaQuestS(True)
$Nox_PathFull = _WinGetPath("NoxPlayer") ;get path cua Nox
Global $Nox_Path = StringLeft(StringSplit($Nox_PathFull,'.')[1],StringLen(StringSplit($Nox_PathFull,'.')[1])-4)
Local $temp = IniRead($pathImage&"1.tmp", $general, $noxpath, ""); doc config
If $temp == "" Then
   IniWrite($pathImage&"1.tmp", $general, $noxpath, $Nox_Path); luu vo config
EndIf
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
	GUICtrlCreateTabItem("Hoạt động")
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
   ; Retrieve a list of window handles.
    Local $aList = WinList("[CLASS:Qt5QWindowIcon]")
    ; Loop through the array displaying only visable windows with a title.
	Global $listNoxRunning[10]
    For $i = 1 To $aList[0][0]
        If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) And StringInStr($aList[$i][0], "NoxPlayer") Then
		   $countDevices = $countDevices + 1
		   $listNoxRunning[$countDevices] = $aList[$i][0]&".tmp" ;set vo array
		   $aCheck[$countDevices] = GUICtrlCreateListViewItem($aList[$i][0], $hListEmulators) ;add emulators
;~ 		   GUICtrlSetFont($hListEmulators, 9, 800, 0, $sFont)
		   _FileCreate($path&$aList[$i][0]&".tmp")
		   _FileCreate($pathAuto&$aList[$i][0]&".tmp")
		   _FileCreate($pathstatus&$aList[$i][0]&".tmp")
		   _FileCreate($pathLog&$aList[$i][0]&".log")
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
		   ; init Run
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $pid, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $finish, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $nameingame, "")
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $statusNox, $onl)
		   IniWrite($pathAuto&$aList[$i][0]&".tmp", $run, $cmdStart, _setCmdStart($aList[$i][0]))
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
	Global $idItemCuopMo = GUICtrlCreateListViewItem("Cướp Mỏ||", $hListHoatDong)
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
	Local $idCheckBoxNVGuildRankS = GUICtrlCreateCheckbox("Bỏ qua nv guild cấp S ", 20, 270, 150, 25)
	GUICtrlSetState(-1, $GUI_CHECKED) ;Default checked

    #region Panel1
    Global $DefaultChildGui = GUICreate("", 319, 367, 12, 123, Default, $WS_EX_MDICHILD, $hGUI) ;;;WHLT
    Local $idBtn_Close = GUICtrlCreateButton("Close", 10, 300, 70, 25)
    $iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($DefaultChildGui), $GWL_STYLE)
    $iExStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($DefaultChildGui), $GWL_EXSTYLE)
    GUISetStyle(BitOR($iStyle, $WS_VISIBLE), $iExStyle, $DefaultChildGui)
	#endregion Panel1
    GUISetState(@SW_SHOW, $hGUI)
	GUISetState(@SW_HIDE, $DefaultChildGui)
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
			   Case $idCheckBoxNVGuildRankS
				   If _IsChecked($idCheckBoxNVGuildRankS) Then
					  _setBoQuaQuestS(True)
				   Else
					  _setBoQuaQuestS(False)
				   EndIf
			EndSwitch
		 Case $DefaultChildGui
			Switch $iGuiMsg[0]
			   Case $idBtn_Close
				   ConsoleWrite("2222222222")
				   WinSetState($hWndListHoatDong,"",@SW_SHOW)
				   GUISetState(@SW_HIDE, $DefaultChildGui)

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
				 $sItemText =  _GUICtrlListView_GetItemText($hWndListView1, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem")) ;store the item text in a global variable in case the get text option is clicked.
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
					$sItemTextHoatDong =  _GUICtrlListView_GetItemText($hWndListView2, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem")) ;store the item text in a global variable in case the get text option is clicked.
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
					$sItemTextHoatDong =  _GUICtrlListView_GetItemText($hWndListView2, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem")) ;store the item text in a global variable in case the get text option is clicked.
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
	 ;Auto resize column
;~ 	 _GUICtrlListView_SetColumnWidth($hListHoatDong, 2, $LVSCW_AUTOSIZE) ;auto size column emulator
	 _GUICtrlListView_SetColumnWidth($hListHoatDong, 1, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status
	 _GUICtrlListView_SetColumnWidth($hListEmulators, 0, $LVSCW_AUTOSIZE_USEHEADER) ;auto size column status
;~ 	 _ProcessResume(_getProcess());resume
  EndFunc
Func _reloadEmu($switch)
     $currentAuto =  $switch
;~      GUICtrlSetData($idItemHuyenCanh, "||")
;~ 	 GUICtrlSetData($idItemBlood, "||")
;~ 	 GUICtrlSetData($idItemBossCaNhan, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemTienThuong, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemDaoMo, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemCuopMo, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemTreoMay, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemNVGuild, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemTinhAnh, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemLayThanhVat, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemBossGuild12h, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemTuHoiGuild12h, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemDevil, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemBaoTang, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemPhaoDai, "||"&$currentAuto)
;~ 	 GUICtrlSetData($idItemHoTro, "||"&$currentAuto)
     _updateAcTion()
	 _refeshLogAuto()
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
Func _setBoQuaQuestS($sState)
     IniWrite($pathImage&"1.tmp", $general, $boquaQuestS, $sState)
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
;~ 	  _ArrayDisplay($ListNox)
	  Local $count = 0
	  Local $NoxRunning[10]
	  For $i = 1 To $ListNox[0][0]
        If $ListNox[$i][0] <> "" And BitAND(WinGetState($ListNox[$i][1]), 2) And StringInStr($ListNox[$i][0], "NoxPlayer") Then
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
		; init Run
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $pid, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $finish, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $nameingame, "")
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $statusNox, $off)
		IniWrite($pathAuto&$NoxOff&".tmp", $run, $cmdStart, _setCmdStart($NoxOff))
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
	  EndSwitch
	  _updateAcTion()
EndFunc   ;==>
Func checkConfigurator()
   ConsoleWrite($sItemTextHoatDong&@CRLF)
   ConsoleWrite($indexItemHoatDong&@CRLF)
   if ($sItemTextHoatDong == "Config") Then
		 WinSetState($hWndListHoatDong,"",@SW_HIDE)
		 GUISetState(@SW_SHOW, $DefaultChildGui)
   EndIf




EndFunc   ;==>Copy2Dsktp
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
EndFunc

Func _WinGetPath($Title="", $strComputer='localhost')
    $win = WinGetTitle($Title)
   Local $pid = WinGetProcess($win)
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