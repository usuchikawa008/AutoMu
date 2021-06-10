Func _GotoNVTinhAnh($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
		 Local $Imageconluottinhanh = @ScriptDir & "\image\conluottinhanh.bmp"
		 Local $Imagehetluottinhanh = @ScriptDir & "\image\hetluottinhanh.bmp"
		 Local $p = _searchNVAdvance($Handle,$Imagehetluottinhanh,$Imageconluottinhanh,95,120);search nv tien thuong
		 If @error Then ; het luot
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
		 writelog("Di den pb Tinh Anh " & _NowTime() & @CRLF) ; write console
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
		 Sleep(4000)
		 Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
		 Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,4, 0, 0, -1, -1,90, 2);search icon thoat pho ban
		 If Not @error Then ;da vo pho ban
			Local $flag_weak_tinhanh = IniRead($pathconfig&$Title&".config", $config, $weaktinhanh, False)
			If $flag_weak_tinhanh == True Then ; yeu cau xuong tang thap hon
			   _doiTangBossCTC()
			EndIf
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1500 100");click to map
			Sleep(3000)
			Local $Imageiconmapthegioi = @ScriptDir & "\image\iconmapthegioi.bmp"
			Local $rs = _HandleImgWaitExist($Handle, $Imageiconmapthegioi,4, 0, 0, -1, -1,80, 2);search icon map the gioi
			If Not @error Then
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 750 274");click to toa do tinh anh
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			   Sleep(7000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1146 838");click to auto
			   Sleep(50000); cho 50s de finnish
			EndIf
		 EndIf
	   Sleep(2000)
	EndFunc   ;==>GotoPB
Func _GotoBossCTC($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
    EndIf
		 Local $ImageconluotBossCTC = @ScriptDir & "\image\bosschientruongconluot.bmp"
		 Local $ImagehetluotBossCTC = @ScriptDir & "\image\bosschientruonghetluot.bmp"
		 Local $p = _searchNVAdvance($Handle,$ImagehetluotBossCTC,$ImageconluotBossCTC,95,102);search boss CTC
		 If @error Then ; het luot
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
		 writelog("Tim boss CTC" & _NowTime() & @CRLF) ; write console
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
		 _doiTangCaoNhatBossCTC();
		 Local $checkbox_config_bossCTC_boss1 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss1, False)
		 Local $checkbox_config_bossCTC_boss2 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss2, False)
		 Local $checkbox_config_bossCTC_boss3 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss3, False)
		 Local $checkbox_config_bossCTC_boss4 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss4, False)
		 Local $checkbox_config_bossCTC_boss5 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss5, False)
		 Local $checkbox_config_bossCTC_boss6 = IniRead($pathconfig&$Title&".config", $config, $bosCTC_boss6, False)
		 Sleep(1500)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 500 650 500 300 300"); di chuyen cuon len 1 chut
		 Sleep(1500)
		 If $checkbox_config_bossCTC_boss6 == True Then ; boss thu 6
			Local $response = _checkBossCTC(410) ; toa do boss 6
			If $response == 2 then Return
			EndIf
		 If $checkbox_config_bossCTC_boss5 == True Then ; boss thu 5
			Local $response = _checkBossCTC(335) ; toa do boss 5
			If $response == 2 then Return
		 EndIf
		 If $checkbox_config_bossCTC_boss4 == True Then ; boss thu 4
			Local $response = _checkBossCTC(260) ; toa do boss 4
			If $response == 2 then Return
		 EndIf
		 If $checkbox_config_bossCTC_boss3 == True Then ; boss thu 3
			Local $response = _checkBossCTC(185) ; toa do boss 3
			If $response == 2 then Return
			EndIf
		 Sleep(1500)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 500 300 500 650 300"); di chuyen xuong 1 chut
		 Sleep(1500)
		 If $checkbox_config_bossCTC_boss2 == True Then ; boss thu 2
			Local $response = _checkBossCTC(280) ; toa do boss 2
			If $response == 2 then Return
		 EndIf
		 If $checkbox_config_bossCTC_boss1 == True Then ; boss thu 1
			Local $response = _checkBossCTC(205) ; toa do boss 1
			If $response == 2 then Return
		 EndIf
	   Sleep(2000)
EndFunc   ;==>GotoPB
Func _GotoBossTheGioi($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
		 Local $ImageconluotBossTG = @ScriptDir & "\image\bossthegioiconluot.bmp"
		 Local $ImagehetluotBossTG = @ScriptDir & "\image\bossthegioihetluot.bmp"
		 Local $p = _searchNVAdvance($Handle,$ImagehetluotBossTG,$ImageconluotBossTG,95,102);search nv tien thuong
		 If @error Then ; het luot
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
		 writelog("Vo boss TG" & _NowTime() & @CRLF) ; write console
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
		 Sleep(3000)
		 Local $checkbox_config_bosstop1 = IniRead($pathconfig&$Title&".config", $config, $bossTG_top1, False)
		 Local $checkbox_config_bosstop2 = IniRead($pathconfig&$Title&".config", $config, $bossTG_top2, False)
		 Local $checkbox_config_bosstop3 = IniRead($pathconfig&$Title&".config", $config, $bossTG_top3, False)
		 ;setup ve 1 Lock
		 _sapXepLaiListBossTG()
		 Sleep(1000)
		 Local $ImageBigLockBossTG = @ScriptDir & "\image\biglockBossTG.bmp"
		 Local $p = _HandleImgWaitExist($Handle,$ImageBigLockBossTG,1, 0,0, -1, -1,55, 5);search dau big lock
		 If not @error Then ; neu thay Lock sau khi da sap xep
			;Toa Do Lock
			Local $x = $p[1][0]
			Local $y = $p[1][1]
			If $checkbox_config_bosstop1 == True Then
			   Sleep(1000)
			   _ControlClickExactly($Title, "", "","", 1,$x, $y-75) ; click len phia tren lock boss
			   Local $Imagedahoisinh = @ScriptDir & "\image\bosstghoisinh.bmp"
			   Local $p = _HandleImgWaitExist($Handle,$Imagedahoisinh,1, $x+70,$y-75, 100, 40,112, 5);search top 1 boss hoi sinh
			   If not @error Then
				  Sleep(1000)
				  writelog("Boss top 1 San Sang" & _NowTime() & @CRLF) ; write console
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 800");click toi ngay
				  Sleep(5000)
				  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
				  Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,3, 0, 0, -1, -1,80, 2);search icon thoat pho ban
				  If not @error Then ; da vo pho ban
					 writelog("Vo PB Boss The Gioi" & _NowTime() & @CRLF) ; write console
					 Sleep(2000)
					 _Covu()
					 AdLibRegister("_cauGiupGuild", 10000);auto run this function every 13 s trigger cau giup guild
					 Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
					 Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,300, 660,30, 60, 50,94, 2);search nut menu trong 300 de ket thuc
					 AdlibUnRegister("_cauGiupGuild")
					 writelog("Ket Thuc Boss TG" & _NowTime() & @CRLF) ; write console
					 Return
				  EndIf
			   Else
				  writelog("Boss chua hoi sinh" & _NowTime() & @CRLF) ; write console
			   EndIf

			EndIf
			If $checkbox_config_bosstop2 == True Then
			   Local $i
			   For $i = 1 to 2 Step + 1
				  _ControlClickExactly($Title, "", "","", 1,$x, $y-(75*$i)) ; click len phia tren lock boss
				  Local $Imagedahoisinh = @ScriptDir & "\image\bosstghoisinh.bmp"
				  Local $p = _HandleImgWaitExist($Handle,$Imagedahoisinh,1, $x+70,$y-(75*$i), 100, 40,110, 5);search top i boss hoi sinh
				  If not @error Then
					 Sleep(1000)
					 writelog("Boss Top "&$i&" San Sang" & _NowTime() & @CRLF) ; write console
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 800");click toi ngay
					 Sleep(5000)
					 Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
					 Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,3, 0, 0, -1, -1,80, 2);search icon thoat pho ban
					 If not @error Then ; da vo pho ban
						writelog("Vo PB Boss The Gioi" & _NowTime() & @CRLF) ; write console
						Sleep(2000)
						_Covu()
						AdLibRegister("_cauGiupGuild", 10000);auto run this function every 10 s trigger cau giup guild
						Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
						Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,300, 660,30, 60, 50,94, 2);search nut menu trong 300 de ket thuc
						AdlibUnRegister("_cauGiupGuild")
						writelog("Ket Thuc Boss TG" & _NowTime() & @CRLF) ; write console
						Return
					 EndIf
				  EndIf
			   Next
			   writelog("Boss chua hoi sinh" & _NowTime() & @CRLF) ; write console
			EndIf
			If $checkbox_config_bosstop3 == True Then
			   Local $i
			   For $i = 1 to 3 Step + 1
				  _ControlClickExactly($Title, "", "","", 1,$x, $y-(75*$i)) ; click len phia tren lock boss
				  Local $Imagedahoisinh = @ScriptDir & "\image\bosstghoisinh.bmp"
				  Local $p = _HandleImgWaitExist($Handle,$Imagedahoisinh,1, $x+70,$y-(75*$i), 100, 40,110, 5);search top i boss hoi sinh
				  If not @error Then
					 Sleep(1000)
					 writelog("Boss Top "&$i&" San Sang" & _NowTime() & @CRLF) ; write console
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 800");click toi ngay
					 Sleep(5000)
					 Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
					 Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,3, 0, 0, -1, -1,80, 2);search icon thoat pho ban
					 If not @error Then ; da vo pho ban
						writelog("Vo PB Boss The Gioi" & _NowTime() & @CRLF) ; write console
						Sleep(2000)
						_Covu()
						AdLibRegister("_cauGiupGuild", 10000);auto run this function every 10 s trigger cau giup guild
						Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
						Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,300, 660,30, 60, 50,94, 2);search nut menu trong 300 de ket thuc
						AdlibUnRegister("_cauGiupGuild")
						writelog("Ket Thuc Boss TG" & _NowTime() & @CRLF) ; write console
						Return
					 EndIf
				  EndIf
			   Next
			   writelog("Boss chua hoi sinh" & _NowTime() & @CRLF) ; write console
			EndIf
		 Else;ko thay big lock boss
			writelog("Chua the danh boss TG luc nay" & _NowTime() & @CRLF) ; write console
		 Endif
	   Sleep(2000)
EndFunc   ;==>GotoPB

Func _GotoNVBossGuild($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(1000)
	 Local $dayofweek = _getDayofWeek()
	 If $dayofweek == $T7 Then ; xu li vo boss thu 7
		_closeSimple($Handle); dong cua so NV
		While 1 ; tim icon boss guild
			Local $Imagexnho = @ScriptDir & "\image\xnho.bmp"
			Local $p = _HandleImgWaitExist($Handle,$Imagexnho,1, 630, 190, 20, 20,100, 2);search dau X
			If Not @error Then ; thay x nho
;~ 			   Local $ImagexpLon = @ScriptDir & "\image\expLon.bmp"
;~ 			   Local $pexplon = _HandleImgWaitExist($Handle,$ImagexpLon,1, 550, 245, 60, 60,80, 2);search expLon
;~ 			   If Not @error Then ; thay exp Lon
;~ 				  _ControlClickExactly($Title, "", "","", 1,$pexplon[1][0]+550, $pexplon[1][1]+320) ; click dung 1 cai
;~ 				  Sleep(1000)
;~ 				  ContinueLoop
;~ 			   EndIf
;~ 			   Local $ImagexpNho = @ScriptDir & "\image\expNho.bmp"
;~ 			   Local $pexpnho = _HandleImgWaitExist($Handle,$ImagexpNho,1, 550, 245, 60, 60,80, 2);search exp Nho
;~ 			   If Not @error Then ; thay exp Lon
;~ 				  _ControlClickExactly($Title, "", "","", 1,$pexpnho[1][0]+550, $pexpnho[1][1]+320) ; click dung 1 cai
;~ 				  Sleep(1000)
;~ 				  ContinueLoop
;~ 			   EndIf
			   Local $ImageIconBossGuild = @ScriptDir & "\image\iconboss12h.bmp"
			   Local $pBossGuild = _HandleImgWaitExist($Handle,$ImageIconBossGuild,1, 550, 225, 100, 100,80, 2);search icon boss guild
			   If Not @error Then ; thay exp Lon
				  _ControlClickExactly($Title, "", "","", 1,$pBossGuild[1][0]+550, $pBossGuild[1][1]+320) ; click vo boss guild
				  Sleep(2000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
				  ;click toi xac nhan
				  Sleep(6000)
				  _Covu()
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
				  ExitLoop
			   EndIf
			   _ControlClickExactly($Title, "", "","", 1,$p[1][0]+631, $p[1][1]+191) ; click tat notify
			EndIf
		WEnd
	 Else ;xu li boss nhung ngay con lai trong tuan
		_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 325 130") ;chuyen sang tab hoat dong han gio
		 Local $Imagebossguild = @ScriptDir & "\image\bossguild.bmp"
		 Local $p = _HandleImgWaitExist($Handle,$Imagebossguild,2, 0, 0, -1, -1,115, 2);search boss guild icon
		 If @error Then ;het luot
			writelog("Ko thay icon boss guild" & _NowTime() & @CRLF) ; write console
			Return SetError(3)
		 Else
			writelog("Vao Boss Guild 12h " & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi
			Sleep(2000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
			;click toi xac nhan
			Sleep(6000)
			_Covu()
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
		 EndIf
	  EndIf

	  ;wait boss die
	  Local $Now = _NowTime(4);time hien tai
	  Local $var1 = StringRegExpReplace($Now, "[:]", "")
	  Local $timeend = StringRegExpReplace("12:10", "[:]", "")
	  Local $remaintime = $timeend - $var1
	  writelog("Cho "&$remaintime &" phut ket thuc boss guild"& @CRLF) ; write console
	  Sleep($remaintime*60000)
	  Local $Imagebossguildfinish = @ScriptDir & "\image\toidaugia.bmp"
	  Local $pfinnish = _HandleImgWaitExist($Handle,$Imagebossguildfinish,60, 0, 0, -1, -1,90, 2);search toi ngay dau gia icon = finish boss guild
	  If not @error Then
		 Sleep(1500)
		 writelog("Ket thuc boss guild " & _NowTime() & @CRLF) ; write console
	  EndIf
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	  Sleep(2000)
	EndFunc   ;==>GotoPB


Func _GotoNVTuHoiGuild($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 325 130") ;chuyen sang tab hoat dong han gio
	  Local $Imagetuhoiguild = @ScriptDir & "\image\tuhoiguild.bmp"
	  Local $p = _HandleImgWaitExist($Handle,$Imagetuhoiguild,2, 0, 0, -1, -1,120, 2);search icon tu hoi guild
	  If @error Then ;het luot
		 Return SetError(3)
	  Else
		 Sleep(1000)
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi icon tu hoi guild
		 writelog("Vao Tu Hoi Guild " & _NowTime() & @CRLF) ; write console
		 Sleep(5000)
		 ;an thit
		 Local $flagAnthit = IniRead($pathImage&"1.tmp", $general, $autoAnThit, ""); check flag an thit
		 If $flagAnthit == True Then ; co an thit dc bat
			Local $ImageTruyenCong = @ScriptDir & "\image\truyencongbtn.bmp"
			Local $rsanthit = _HandleImgWaitExist($Handle,$ImageTruyenCong,10, 640, 260, 90, 50,90, 2);search image an thit
			If @error Then ; ko thay icon an thit bo qua
			   writelog("Ko tim thay icon an thit " & _NowTime() & @CRLF) ; write console
			Else
			   _ControlClickExactly($Title, "", "","", 1,$rsanthit[1][0]+750, $rsanthit[1][1]+270) ; click icon an thit
			   Local $Imagexacnhan = @ScriptDir & "\image\xacnhanbtn.bmp"
			   Local $rsxacnhan = _HandleImgWaitExist($Handle,$Imagexacnhan,10, 470,330, 100, 100,100, 2);search image xac nhan button
			   If @error Then ; ko thay icon xac nhan bo qua
				  writelog("Ko Thay Icon Xac Nhan1 " & _NowTime() & @CRLF) ; write console
			   Else ;thay buttion xac nhan
				  _ControlClickExactly($Title, "", "","", 1,$rsxacnhan[1][0]+470, $rsxacnhan[1][1]+330) ; click icon xac nhan
				  Local $Imagedung1cai = @ScriptDir & "\image\dung1cai.bmp"
				  Local $rsdung1cai = _HandleImgWaitExist($Handle,$Imagedung1cai,10, 0, 0, -1, -1,90, 2);search image dung 1 cai button
				  If not @error Then ; neu thay icon dung 1 cai click zdo
					 _ControlClickExactly($Title, "", "","", 1,$rsdung1cai[1][0], $rsdung1cai[1][1]) ; click icon dung 1 cai
				  EndIf
			   EndIf
			EndIf
		 EndIf
		 ;truyen cong
		 Sleep(2000)
		 _closeSimple($Handle); dong cua so NV
		 Local $flagtruyencong = IniRead($pathImage&"1.tmp", $general, $autoTruyenCong, ""); check flag truyen cong
		 If $flagtruyencong == True Then ; flag truyen cong was on
			writelog("Truyen Cong" & _NowTime() & @CRLF) ; write console
			Local $ImageTruyenCong = @ScriptDir & "\image\truyencongbtn.bmp"
			Local $rsTC = _HandleImgWaitExist($Handle,$ImageTruyenCong,10, 640, 260, 90, 50,90, 2);search image an thit
			If @error Then ; ko thay icon an thit bo qua
			   writelog("Ko tim thay icon truyen cong " & _NowTime() & @CRLF) ; write console
			Else
			   _ControlClickExactly($Title, "", "","", 1,$rsTC[1][0]+665, $rsTC[1][1]+265) ; click icon truyen cong
			   Sleep(2000)
			   Local $ImageMoiTC = @ScriptDir & "\image\moitc.bmp"
			   Local $rsMoiTC = _HandleImgWaitExist($Handle,$ImageMoiTC,2, 0,0, -1, -1,85, 5)
			   If @error Then ; ko thay icon Moi nao
				  writelog("Ko tim thay nguoi choi de truyen cong " & _NowTime() & @CRLF) ; write console
			   Else ;thay nguoi de moi TC
				  Local $index = 0
				  While $index < $rsMoiTC[0][0] ;so image tim thay
					 $index = $index + 1
					 Sleep(500)
					 _ControlClickExactly($Title, "", "","", 1,$rsMoiTC[$index][0], $rsMoiTC[$index][1]) ; click icon Moi
					 Sleep(1000)
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600");click xac nnhan
					 Sleep(1000)
				  WEnd
				  _closeSimple($Handle); dong cua so NV
			   EndIf
			EndIf
		 EndIf
	  ;loop den thoi gian boss
	  AdLibRegister("_xacNhan", 5000);auto run this function every 5 s
	  While 1
		 Sleep(10000)
		 Local $Imagecovukiem = @ScriptDir & "\image\covukiem.bmp"
		 Local $rscovukiem = _HandleImgWaitExist($Handle,$Imagecovukiem,5, 0, 0, -1, -1,90, 2);search image covu kiem
		 If not @error Then ; neu thay icon co vu kiem
			ExitLoop
		 EndIf
		 Local $Now = _NowTime(4);time hien tai
		 Local $var1 = StringRegExpReplace($Now, "[:]", "")
	     Local $timestart = StringRegExpReplace("20:01", "[:]", "")
	     Local $timeend = StringRegExpReplace("20:10", "[:]", "")
		 If $var1 > $timestart And $var1 < $timeend Then
			ExitLoop
		 EndIf
	  WEnd
	  AdlibUnRegister("_xacNhan")
	   _closeSimple($Handle); dong cua so
	  Sleep(1500)
	  _Covu()
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
	  EndIf
		 ;wait boss die
	  Local $Now = _NowTime(4);time hien tai
	  Local $var1 = StringRegExpReplace($Now, "[:]", "")
	  Local $timeend = StringRegExpReplace("20:10", "[:]", "")
	  Local $remaintime = $timeend - $var1
	  writelog("Cho "&$remaintime &" phut ket thuc boss guild"& @CRLF) ; write console
	  Sleep($remaintime*60000)
	  Local $Imagebossguildfinish = @ScriptDir & "\image\toidaugia.bmp"
	  Local $pfinnish = _HandleImgWaitExist($Handle,$Imagebossguildfinish,100, 0, 0, -1, -1,85, 2);search toi ngay dau gia icon = finish boss guild
	  If not @error Then
			writelog("Ket thuc boss guild " & _NowTime() & @CRLF) ; write console
		    Sleep(1500)
		 EndIf
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	  Sleep(2000)
EndFunc   ;==>GotoPB

Func _GotoHoTroGuild($Title,$emuport,$Handle)
    Global $flagbosstg = False
	Global $flagbossctc = False
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Sleep(1000)
	  $Imageyeucauhotro = @ScriptDir & "\image\yeucauhotro.bmp"
	  Local $p = _HandleImgWaitExist($Handle,$Imageyeucauhotro,2, 0, 0, -1, -1,100, 2);search icon ho tro guild
	  If not @error Then ; thay yeu cau ho tro
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+5, $p[1][1]+2) ; click toi yeu cau ho tro
	  Else
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 366 683");click to ho tro
	  EndIf
	  Sleep(3000)
	  writelog("Ho Tro Guild"& @CRLF) ; write console
	  Local $count = 0
	  While $count < 2
		 $count = $count + 1
		 Local $Imagebosstoihotro = @ScriptDir & "\image\toihotrobtn.bmp"
	     Local $p = _HandleImgSearch($Handle,$Imagebosstoihotro, 0, 0, -1, -1,89, 4);search btn toi ho tro
		 If not @error Then ; thay hon 3 b
			if $p[0][0] > 3 Then
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 350 200"); di chuyen cuon len den trang cuoi
			   Sleep(2000)
		    EndIf
		 Else ; ko thay ho tro nao
			ExitLoop
		 EndIf

	     #Region Support NV guild S
		 Local $flag_sp_NVrankS = IniRead($pathconfig&$Title&".config", $config, $sp_nvguildRankS, False)
		 If $flag_sp_NVrankS == True Then ; support NV rank S
			Local $ImagenvguildStext = @ScriptDir & "\image\nvguildStext.bmp"
			Local $Rs_Sp_Nv_Guild_S = _HandleImgWaitExist($Handle,$ImagenvguildStext,1, 0, 0, -1, -1,100, 5);search boss tg text
			If not @error Then ; thay boss the gioi
			   writelog("Ho Tro NV Guild S "& @CRLF) ; write console
			   _ControlClickExactly($Title, "", "","", 1,$Rs_Sp_Nv_Guild_S[1][0]+300, $Rs_Sp_Nv_Guild_S[1][1]+20) ; click ho tro
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 821 600");click giup ngay
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 977 600");click xac nhan
			   Local $waitTime_sp = IniRead($pathconfig&$Title&".config", $config, $sp_timewaitNvS, 60)
			   if $waitTime_sp < 5 Then
				  $waitTime_sp = 30
			   EndIf
			   writelog("Cho vo pb trong vong "&$waitTime_sp &" giay"& @CRLF) ; write console
			   Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
			   Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,$waitTime_sp+10, 0, 0, -1, -1,80, 2);search icon thoat pho ban
			   If not @error Then ; da vo pho ban
				  writelog("Da vo pb "&$waitTime_sp &" giay"& @CRLF) ; write console
				  Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
				  Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,150, 660,30, 60, 50,85, 2);search nut menu trong 120 de ket thuc
			   EndIf
			   _outParty()
			   Return
			EndIf
		 EndIf
		 #EndRegion support NV guild S
		 #Region Support Boss TG
		 Local $flag_sp_BossTG = IniRead($pathconfig&$Title&".config", $config, $spbossTG, False)
		 If $flag_sp_BossTG == True Then ; support boss TG
			Local $Imagebosstgtext = @ScriptDir & "\image\bosstgtext.bmp"
			Local $p = _HandleImgWaitExist($Handle,$Imagebosstgtext,1, 0, 0, -1, -1,108, 5);search boss tg text
			If not @error Then ; thay boss the gioi
			   writelog("Ho Tro Boss The Gioi"& @CRLF) ; write console
			   _ControlClickExactly($Title, "", "","", 1,$p[1][0]+300, $p[1][1]+20) ; click ho tro
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 821 600");click giup ngay
			   Sleep(6000)
			   Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
			   Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,1, 0, 0, -1, -1,80, 2);search icon thoat pho ban
			   If not @error Then ; da vo pho ban
				  $flagbosstg = True
				  ExitLoop
			   EndIf
			EndIf
		 EndIf


		 #EndRegion support Boss TG
		 #Region Support Boss CTC
		 Local $flag_sp_BossCTC = IniRead($pathconfig&$Title&".config", $config, $spbossctc, False)
		 If $flag_sp_BossCTC == True Then ; support boss TG
		    Local $Imagebosstgtext = @ScriptDir & "\image\bossctctext.bmp"
			Local $p = _HandleImgSearch($Handle,$Imagebosstgtext,0, 0, -1, -1,108, 2);search boss ctc text
			If not @error Then ; thay boss ctc
			   writelog("Ho Tro Boss Chien Truong"& @CRLF) ; write console
			   _ControlClickExactly($Title, "", "","", 1,$p[1][0]+300, $p[1][1]+20) ; click ho tro
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 821 600");click giup ngay
			   Sleep(6000)
			   Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
			   Local $rsthoatpbCTC = _HandleImgWaitExist($Handle, $Imagethoatpb,1, 0, 0, -1, -1,80, 2);search icon thoat pho ban
			   If not @error Then ; da vo pho ban
				  $flagbossctc = True
				  ExitLoop
			   EndIf
			EndIf
		 EndIf
		 #EndRegion support Boss CTC
		 #Region Support Doat Mo
		 Local $flag_sp_cuopmo = IniRead($pathconfig&$Title&".config", $config, $spcuopmo, False)
		 If $flag_sp_cuopmo == True Then ; support boss TG
			Local $Imagedoatmotext = @ScriptDir & "\image\doatmotext.bmp"
			Local $p = _HandleImgWaitExist($Handle,$Imagedoatmotext,1, 320, 120, 200, 350,100, 10);search doat mo text
			If not @error Then ; thay boss the gioi
   ;~ 		    writelog("Ho Tro Boss The Gioi"& @CRLF) ; write console
			   Local $index = 0
			   While $index < $p[0][0] ;so image tim thay
				  $index = $index + 1
				  _ControlClickExactly($Title, "", "","", 1,$p[$index][0]+300+320, $p[$index][1]+20+120) ; click toi ho tro
				  Sleep(1000)
				  Local $Imagehuychuong = @ScriptDir & "\image\huychuongdanhvong.bmp"
				  Local $Rs_Huychuong = _HandleImgWaitExist($Handle,$Imagehuychuong,1, 400, 240, 50, 50,105, 2);search hcdv
				  If not @error Then ; thay huy chuong
					 Sleep(1000)
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 821 600");click giup ngay
					 writelog("Ho Tro Cuop Mo"& @CRLF) ; write console
					 Sleep(10000) ;cho 10s vo battle
					 Local $ImagePath = @ScriptDir & "\image\menu.bmp"
					 Local $Result = _HandleImgWaitExist($Handle, $ImagePath,30, 660,30, 60, 50,85, 2);search nut menu
					 Return
				  Else ; ko tu support chinh minh -> next
					 ContinueLoop
				  EndIf
			   WEnd
			EndIf
		 EndIf
		 #EndRegion support Doat Mo
	  WEnd
	  If $flagbosstg == True Then
		 _Covu()
		 writelog("Vo PB Boss TG"& @CRLF) ; write console
		 While 1
			Local $ImagePath = @ScriptDir & "\image\toibtn.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,15, 19, 278, 50, 28,80, 2);search toi trong 15s
			If not @error Then ; thay toi ho tro\
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+26, $Result[1][1]+280) ; click toi
			   Sleep(10000)
			Else ;ket thuc bos
			   ExitLoop
			EndIf
		 WEnd
	  EndIf
	  If $flagbossctc == True Then
		 writelog("Vo PB Boss CTC"& @CRLF) ; write console
		 While 1
			Local $ImagePath = @ScriptDir & "\image\toibtn.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,15, 19, 278, 50, 28,80, 2);search toi
			If not @error Then ; thay toi ho tro\
			   _ControlClickExactly($Title, "", "","", 1,$Result[1][0]+21, $Result[1][1]+280) ; click toi
			   Sleep(10000)
			Else ;ket thuc bos
			   ExitLoop
			EndIf
		 WEnd
	  EndIf
Return 1


EndFunc   ;==>GotoPB

Func _Covu()
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
	  Sleep(1000)
	  For $i = 0 to 4 Step + 1
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
		 Sleep(300)
	  Next
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
	  Sleep(1000)
   EndFunc   ;==>GotoCoVu
Func _xacNhan()
   Local $ImageXacNhan = @ScriptDir & "\image\xacnhanbtn.bmp"
   Local $rs = _HandleImgSearch($hwnd, $ImageXacNhan,0, 0, -1, -1,100,5 );search icon xac nhan
   If not @error Then ; thay toi ho tro\
	  _ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click xac nhan
   EndIf
EndFunc   ;==>GotoXac Nhan

Func _cauGiupGuild()
   Local $ImageCauGiupGuild = @ScriptDir & "\image\caugiupguild.bmp"
   Local $rs = _HandleImgSearch($hwnd, $ImageCauGiupGuild,0, 0, -1, -1,78,5 );search icon xac nhan
   If not @error Then ; thay toi ho tro\
	  _ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click cau giup guild
   EndIf
EndFunc   ;==>GotoXac Nhan
Func _sapXepLaiListBossTG()
   Local $i
   For $i = 0 to 20 Step + 1
	  Local $ImageBigLockBossTG = @ScriptDir & "\image\biglockBossTG.bmp"
	  Local $p = _HandleImgWaitExist($hwnd,$ImageBigLockBossTG,1, 0,0, -1, -1,55, 5);search dau big lock
	  If not @error Then ;thay lock boss
		 If $p[0][0] > 1 Then ; nhiu hon 1 lock
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 500 570 500 650 500"); di chuyen cuon xun 1 chut
			ContinueLoop
		 EndIf
		 If $p[0][0] == 1 Then ; nhiu hon 1 lock ; sap xep thanh cong
			ExitLoop
		 EndIf
      Else ; ko thay lock nao
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 500 650 500 570 500"); di chuyen cuon len 1 chut
	  EndIf
   Next
EndFunc   ;==>SetupOneLockBoss
Func _doiTangBossCTC()
	#Region doi tang
   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1500 100");click doi tang
   Sleep(2000)
   Local $ImagelockbossCTC = @ScriptDir & "\image\lockbossCTC.bmp"
   Local $rslockBoss = _HandleImgWaitExist($hwnd, $ImagelockbossCTC,1, 0, 0, -1, -1,80, 5);search icon lock boss CTC
   If Not @error Then ; thay lock boss nghia la dang o tang cao nhat
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 217 134");click sang tang yeu hon
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1129 800");click toi ngay
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 600 600");click van toi
	  Sleep(2000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  Local $rsthoatpb = _HandleImgWaitExist($hwnd, $Imagethoatpb,10, 0, 0, -1, -1,90, 2);search icon thoat pho ban
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 500");click van toi
   EndIf
   #EndRegion
EndFunc   ;==>doi tang


Func _doiTangCaoNhatBossCTC()
   #Region doi tang cao nhat
   Local $i
   For $i = 1 to 3 Step + 1
	  Local $ImagelockbossCTC = @ScriptDir & "\image\lockbossCTC.bmp"
	  Local $rslockBoss = _HandleImgWaitExist($hwnd, $ImagelockbossCTC,1, 0, 0, -1, -1,80, 5);search icon lock boss CTC
	  If Not @error Then ; thay lock boss nghia la dang o tang cao nhat
		 ExitLoop
	  Else; xu li chuuyen qua tang cao nhat
		  writelog("Next Floor" & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 678 134");click sang tang cao hon
		  Sleep(1000)
	  EndIf
   Next
   #EndRegion
EndFunc   ;==>doi tang
Func _checkBossCTC($y)
   Local $Imagedahoisinh = @ScriptDir & "\image\bosstghoisinh.bmp"
   Local $p = _HandleImgWaitExist($hwnd,$Imagedahoisinh,1, 320, $y, 100, 40,110, 5);search boss 6 toa do hoi sinh
   If not @error Then
	  Sleep(500)
	  _ControlClickExactly($Title, "", "","", 1,$p[1][0]+320, $p[1][1]+$y) ; click vo diem vua tim thay
	  Sleep(1500)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 800");click toi ngay
	  Sleep(5000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  Local $rsthoatpb = _HandleImgWaitExist($hwnd, $Imagethoatpb,4, 0, 0, -1, -1,80, 2);search icon thoat pho ban
	  If not @error Then ; da vo pho ban
		 writelog("Vao pb CTC" & _NowTime() & @CRLF) ; write console
		 Sleep(10000); cho toi boss
		 Local $ImageCauGiupGuild = @ScriptDir & "\image\caugiupguild.bmp"
		 Local $rs = _HandleImgWaitExist($hwnd, $ImageCauGiupGuild,20,0, 0, -1, -1,78,5 );search icon cau giup guild
		 If not @error Then ; thay icon cau giup guild ngia la da gap boss
			_ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click vo diem vua tim thay
			AdLibRegister("_cauGiupGuild", 11000);auto run this function every 11 s trigger cau giup guild
			Local $i
			For $i = 1 to 50 Step + 1
			   Local $rs = _HandleImgWaitExist($hwnd, $ImageCauGiupGuild,15,662, 272, 100, 40,80, 2 );search icon cau giup guild
			   If not @error Then
				  Sleep(10000)
			   Else
				  writelog("Ket thuc boss CTC" & _NowTime() & @CRLF) ; write console
				  ExitLoop
			   EndIf
			Next
			AdlibUnRegister("_cauGiupGuild")
			Return 2

		 Else
			writelog("Tam thoi ko the danh boss luc nay" & _NowTime() & @CRLF) ; write console
			Return 2
		 EndIf
	  Else
		 writelog("Tam thoi ko the danh boss luc nay" & _NowTime() & @CRLF) ; write console
		 Return 2
	  EndIf
   EndIf; end search boss 6
EndFunc   ;==>doi tang

