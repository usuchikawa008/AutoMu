
Func _GotoNVTinhAnh($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 550 550"); di chuyen 1 chut
	 Sleep(1500)
		 $Imageconluottinhanh = @ScriptDir & "\image\conluottinhanh.bmp"
		 $p = _HandleImgSearch($Handle,$Imageconluottinhanh, 0, 0, -1, -1,120, 2);search nv treo may con luot
		 If @error Then ;het luot
			Return SetError(3)
		 Else
			writelog("Di den pb Tinh Anh " & _NowTime() & @CRLF) ; write console
			Opt("WinTitleMatchMode", 3)
			ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
			Sleep(4000)
			Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
		    Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,4, 0, 0, -1, -1,90, 2);search icon thoat pho ban
			If Not @error Then
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
		 EndIf
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
	 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 325 130") ;chuyen sang tab hoat dong han gio
		 $Imagebossguild = @ScriptDir & "\image\bossguild.bmp"
		 $p = _HandleImgWaitExist($Handle,$Imagebossguild,2, 0, 0, -1, -1,120, 2);search boss guild icon
		 If @error Then ;het luot
			Return SetError(3)
		 Else
			writelog("Vao Boss Guild 12h " & _NowTime() & @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi
			Sleep(2000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
			;click toi xac nhan
			Sleep(6000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
			For $i = 0 to 4 Step + 1
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
			Next
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
		 EndIf
		 ;wait boss die
		 Local $Now = _getCurrentTime();time hien tai
		 Local $var1 = StringRegExpReplace($Now, "[:]", "")
		 Local $timeend = StringRegExpReplace("12:10", "[:]", "")
		 Local $remaintime = $timeend - $var1
		 writelog("Cho "&$remaintime &" phut ket thuc boss guild"& @CRLF) ; write console
		 Sleep($remaintime*60000)
		 $Imagebossguildfinish = @ScriptDir & "\image\toidaugia.bmp"
		 $pfinnish = _HandleImgWaitExist($Handle,$Imagebossguildfinish,100, 0, 0, -1, -1,85, 2);search toi ngay dau gia icon = finish boss guild
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
	  $Imagetuhoiguild = @ScriptDir & "\image\tuhoiguild.bmp"
	  $p = _HandleImgWaitExist($Handle,$Imagetuhoiguild,2, 0, 0, -1, -1,120, 2);search icon tu hoi guild
	  If @error Then ;het luot
		 Return SetError(3)
	  Else
		 ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi icon tu hoi guild
		 writelog("Vao Tu Hoi Guild " & _NowTime() & @CRLF) ; write console
		 Sleep(5000)
		 $Imageanthit = @ScriptDir & "\image\anthit.bmp"
		 $rsanthit = _HandleImgWaitExist($Handle,$Imageanthit,10, 0, 0, -1, -1,105, 2);search image an thit
		 If @error Then ; ko thay icon an thit bo qua
			writelog("Ko tim thay icon an thit " & _NowTime() & @CRLF) ; write console
		 Else
			ControlClick($Title, "", "","", 1,$rsanthit[1][0], $rsanthit[1][1]) ; click icon an thit
			$Imagexacnhan = @ScriptDir & "\image\xacnhanbtn.bmp"
			$rsxacnhan = _HandleImgWaitExist($Handle,$Imagexacnhan,10, 0, 0, -1, -1,90, 2);search image xac nhan button
			If @error Then ; ko thay icon xac nhan bo qua

			Else ;thay buttion xac nhan
			   ControlClick($Title, "", "","", 1,$rsxacnhan[1][0], $rsxacnhan[1][1]) ; click icon xac nhan
			   $Imagedung1cai = @ScriptDir & "\image\dung1cai.bmp"
			   $rsdung1cai = _HandleImgWaitExist($Handle,$Imagedung1cai,10, 0, 0, -1, -1,90, 2);search image dung 1 cai button
			   If not @error Then ; neu thay icon dung 1 cai click zdo
				  ControlClick($Title, "", "","", 1,$rsdung1cai[1][0], $rsdung1cai[1][1]) ; click icon dung 1 cai
			   EndIf
			EndIf
		 EndIf
	  ;loop den thoi gian boss
	  While 1
		 Local $Imagecovukiem = @ScriptDir & "\image\covukiem.bmp"
		 Local $rscovukiem = _HandleImgWaitExist($Handle,$Imagecovukiem,5, 0, 0, -1, -1,90, 2);search image covu kiem
		 If not @error Then ; neu thay icon co vu kiem
			ExitLoop
		 EndIf
		 Local $Now = _getCurrentTime();time hien tai
		 $var1 = StringRegExpReplace($Now, "[:]", "")
	     $timestart = StringRegExpReplace("20:01", "[:]", "")
	     $timeend = StringRegExpReplace("20:10", "[:]", "")
		 If $var1 > $timestart And $var1 < $timeend Then
			ExitLoop
		 EndIf
	  WEnd
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
	  For $i = 0 to 4 Step + 1
		 Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
	  Next
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
	  EndIf
		 ;wait boss die
	  Local $Now = _getCurrentTime();time hien tai
	  Local $var1 = StringRegExpReplace($Now, "[:]", "")
	  Local $timeend = StringRegExpReplace("20:10", "[:]", "")
	  Local $remaintime = $timeend - $var1
	  writelog("Cho "&$remaintime &" phut ket thuc boss guild"& @CRLF) ; write console
	  Sleep($remaintime*60000)
	  $Imagebossguildfinish = @ScriptDir & "\image\toidaugia.bmp"
	  $pfinnish = _HandleImgWaitExist($Handle,$Imagebossguildfinish,100, 0, 0, -1, -1,85, 2);search toi ngay dau gia icon = finish boss guild
	  If not @error Then
			writelog("Ket thuc boss guild " & _NowTime() & @CRLF) ; write console
		    Sleep(1500)
		 EndIf
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	  Sleep(2000)
EndFunc   ;==>GotoPB

