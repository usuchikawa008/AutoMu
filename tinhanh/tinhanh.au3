
Func _GotoNVTinhAnh($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
		 Local $Imageconluottinhanh = @ScriptDir & "\image\conluottinhanh.bmp"
		 Local $Imagehetluottinhanh = @ScriptDir & "\image\hetluottinhanh.bmp"
		 $p = _searchNVAdvance($Handle,$Imagehetluottinhanh,$Imageconluottinhanh,95,120);search nv tien thuong
		 If @error Then ; het luot
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
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
;~ 				  ControlClick($Title, "", "","", 1,$pexplon[1][0]+550, $pexplon[1][1]+320) ; click dung 1 cai
;~ 				  Sleep(1000)
;~ 				  ContinueLoop
;~ 			   EndIf
;~ 			   Local $ImagexpNho = @ScriptDir & "\image\expNho.bmp"
;~ 			   Local $pexpnho = _HandleImgWaitExist($Handle,$ImagexpNho,1, 550, 245, 60, 60,80, 2);search exp Nho
;~ 			   If Not @error Then ; thay exp Lon
;~ 				  ControlClick($Title, "", "","", 1,$pexpnho[1][0]+550, $pexpnho[1][1]+320) ; click dung 1 cai
;~ 				  Sleep(1000)
;~ 				  ContinueLoop
;~ 			   EndIf
			   Local $ImageIconBossGuild = @ScriptDir & "\image\iconboss12h.bmp"
			   Local $pBossGuild = _HandleImgWaitExist($Handle,$ImageIconBossGuild,1, 550, 225, 100, 100,80, 2);search icon boss guild
			   If Not @error Then ; thay exp Lon
				  ControlClick($Title, "", "","", 1,$pBossGuild[1][0]+550, $pBossGuild[1][1]+320) ; click vo boss guild
				  Sleep(2000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
				  ;click toi xac nhan
				  Sleep(6000)
				  _Covu()
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
				  ExitLoop
			   EndIf
			   ControlClick($Title, "", "","", 1,$p[1][0]+631, $p[1][1]+191) ; click tat notify
			EndIf
		WEnd
	 Else ;xu li boss nhung ngay con lai trong tuan
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
	  $Imagebossguildfinish = @ScriptDir & "\image\toidaugia.bmp"
	  $pfinnish = _HandleImgWaitExist($Handle,$Imagebossguildfinish,100, 0, 0, -1, -1,90, 2);search toi ngay dau gia icon = finish boss guild
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
		 ;an thit
		 Local $flagAnthit = IniRead($pathImage&"1.tmp", $general, $autoAnThit, ""); check flag an thit
		 If $flagAnthit == True Then ; co an thit dc bat
			$ImageTruyenCong = @ScriptDir & "\image\truyencongbtn.bmp"
			$rsanthit = _HandleImgWaitExist($Handle,$ImageTruyenCong,10, 640, 260, 90, 50,90, 2);search image an thit
			If @error Then ; ko thay icon an thit bo qua
			   writelog("Ko tim thay icon an thit " & _NowTime() & @CRLF) ; write console
			Else
			   ControlClick($Title, "", "","", 1,$rsanthit[1][0]+750, $rsanthit[1][1]+270) ; click icon an thit
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
		 EndIf
		 ;truyen cong
		 Local $flagtruyencong = IniRead($pathImage&"1.tmp", $general, $autoTruyenCong, ""); check flag truyen cong
		 If $flagtruyencong == True Then ; flag truyen cong was on
			writelog("Truyen Cong sau 1 phut nua" & _NowTime() & @CRLF) ; write console
			Sleep(60000)
			$ImageTruyenCong = @ScriptDir & "\image\truyencongbtn.bmp"
			Local $rsanthit = _HandleImgWaitExist($Handle,$ImageTruyenCong,10, 640, 260, 90, 50,90, 2);search image an thit
			If @error Then ; ko thay icon an thit bo qua
			   writelog("Ko tim thay icon truyen cong " & _NowTime() & @CRLF) ; write console
			Else
			   ControlClick($Title, "", "","", 1,$rsanthit[1][0]+640, $rsanthit[1][1]+260) ; click icon truyen cong
			   $ImageMoiTC = @ScriptDir & "\image\moitc.bmp"
			   $rsMoiTC = _HandleImgWaitExist($Handle,$ImageMoiTC,2, 0,0, -1, -1,85, 5)
			   If @error Then ; ko thay icon Moi nao

			   Else ;thay nguoi de moi TC
				  Local $index = 0
				  While $index < $rsMoiTC[0][0] ;so image tim thay
					 $index = $index + 1
					 ControlClick($Title, "", "","", 1,$rsMoiTC[$index][0], $rsMoiTC[$index][1]) ; click icon Moi
					 Sleep(1000)
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600");click xac nnhan
					 Sleep(1000)
				  WEnd
				  _closeSimple($Handle); dong cua so NV
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
		 Local $Now = _NowTime(4);time hien tai
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
	  Local $Now = _NowTime(4);time hien tai
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

Func _GotoPhaoDaiDo($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 325 130") ;chuyen sang tab hoat dong han gio
	  $Imagephaodai = @ScriptDir & "\image\tuhoiguild.bmp" ;image phao dai do
	  $p = _HandleImgWaitExist($Handle,$Imagephaodai,2, 0, 0, -1, -1,120, 2);search icon phao dai
	  If @error Then ;het luot
		 Return SetError(3)
	  Else
		 ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi icon phao dai
		 writelog("Vao Phao Dai " & _NowTime() & @CRLF) ; write console
		 Sleep(2000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
		 ;click confirm neu dang trong party
	  writelog("Cho ket thuc phao dai...." & _NowTime() & @CRLF) ; write console
	  $ImagePath = @ScriptDir & "\image\menu.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath,660, 660,30, 60, 50,85, 2);search nut menu
	  EndIf
	  Sleep(2000)
EndFunc   ;==>GotoPB
Func _GotoHoTroGuild($Title,$emuport,$Handle)
    Local $flagbosstg = False
	Local $flagbossctc = False
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
		 ControlClick($Title, "", "","", 1,$p[1][0]+20, $p[1][1]+2) ; click toi yeu cau ho tro
	  Else
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 366 683");click to ho tro
	  EndIf
	  Sleep(3000)
	  Local $count = 0
	  While $count < 2
		 writelog("Ho Tro Guild"& @CRLF) ; write console
		$count = $count + 1

		Local $Imagebosstgtext = @ScriptDir & "\image\bosstgtext.bmp"
	    Local $p = _HandleImgWaitExist($Handle,$Imagebosstgtext,1, 0, 0, -1, -1,108, 5);search boss tg text
		If not @error Then ; thay boss the gioi
		    writelog("Ho Tro Boss The Gioi"& @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$p[1][0]+300, $p[1][1]+20) ; click ho tro
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

	    Local $Imagebosstgtext = @ScriptDir & "\image\bossctctext.bmp"
	    Local $p = _HandleImgSearch($Handle,$Imagebosstgtext,0, 0, -1, -1,108, 2);search boss ctc text
		If not @error Then ; thay boss ctc
		    writelog("Ho Tro Boss Chien Truong"& @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$p[1][0]+300, $p[1][1]+20) ; click ho tro
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 821 600");click giup ngay
			Sleep(6000)
			Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
			Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,1, 0, 0, -1, -1,80, 2);search icon thoat pho ban
			If not @error Then ; da vo pho ban
			   $flagbossctc = True
			   ExitLoop
			EndIf
		 EndIf

		 ;doat mo
		Local $Imagedoatmotext = @ScriptDir & "\image\doatmotext.bmp"
	    Local $p = _HandleImgWaitExist($Handle,$Imagedoatmotext,1, 0, 0, -1, -1,88, 10);search doat mo text
		If not @error Then ; thay boss the gioi
;~ 		    writelog("Ho Tro Boss The Gioi"& @CRLF) ; write console
			Local $index = 0
			While $index < $p[0][0] ;so image tim thay
			   $index = $index + 1
			   ControlClick($Title, "", "","", 1,$p[$index][0]+300, $p[$index][1]+20) ; click toi ho tro
			   Sleep(1000)
			   Local $Imagehuychuong = @ScriptDir & "\image\huychuongdanhvong.bmp"
			   Local $Rs_Huychuong = _HandleImgWaitExist($Handle,$Imagehuychuong,1, 0, 0, -1, -1,88, 2);search hcdv
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

		 Sleep(1000)
		 Local $Imagebosstoihotro = @ScriptDir & "\image\toihotrobtn.bmp"
	     Local $p = _HandleImgSearch($Handle,$Imagebosstoihotro, 0, 0, -1, -1,89, 4);search btn toi ho tro
		 If not @error And $p[0][0] > 3 Then ; thay hon 3 btn toi ho tro
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 400 200"); di chuyen cuon len den trang cuoi
	  Else
		 Return
	  EndIf
   WEnd
	  If $flagbosstg == True Then
		 _Covu()
		 While 1
			Local $ImagePath = @ScriptDir & "\image\toibtn.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,15, 19, 278, 50, 28,80, 2);search toi trong 15s
			If not @error Then ; thay toi ho tro\
			   ControlClick($Title, "", "","", 1,$Result[1][0]+21, $Result[1][1]+280) ; click toi
			   Sleep(5000)
			Else ;ket thuc bos
			   ExitLoop
			EndIf
		 WEnd
	  EndIf
	  If $flagbossctc == True Then
		 While 1
			Local $ImagePath = @ScriptDir & "\image\toibtn.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,15, 19, 278, 50, 28,80, 2);search toi
			If not @error Then ; thay toi ho tro\
			   ControlClick($Title, "", "","", 1,$Result[1][0]+21, $Result[1][1]+280) ; click toi
			   Sleep(5000)
			Else ;ket thuc bos
			   ExitLoop
			EndIf
		 WEnd
	 EndIf



EndFunc   ;==>GotoPB

Func _Covu()
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
	  For $i = 0 to 4 Step + 1
		 Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
	  Next
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
	  Sleep(1000)
EndFunc   ;==>GotoPB