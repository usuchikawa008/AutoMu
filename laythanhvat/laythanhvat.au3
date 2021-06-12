Func _GotoLayThanhVat($Title,$emuport,$Handle)
	  If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	  EndIf
	   Local $Now = _NowTime(4);time hien tai
	   Local $Hotongbaotang = False
	   Local $dayofweek = _getDayofWeek()
	   If $dayofweek == $T2 OR $dayofweek == $T4 OR $dayofweek == $T6 Then
		  Local $Hotongbaotang = True
	   EndIf

	   $var1 = StringRegExpReplace($Now, "[:]", "")
	   Local $timestart = StringRegExpReplace("10:59", "[:]", "")
	   Local $timeend = StringRegExpReplace("5:00", "[:]", "")
	   Local $Risktimestart = StringRegExpReplace("21:00", "[:]", "")
	   Local $Risktimeend = StringRegExpReplace("22:00", "[:]", "")
	   If $var1 > $timestart Or $var1 < $timeend Then
			If $var1 > $Risktimestart And $var1 < $Risktimeend And $Hotongbaotang == True Then ; h nguy hiem ko nen lam NV nay
			   writelog("Ko nen lay thanh vat thoi diem nay" & _NowTime() & @CRLF) ; write console
			   Return
			EndIf
	   Else
		 Return
	   EndIf
	  Local $Imagelaythanhvat = @ScriptDir & "\image\laythanhvatconluot.bmp"
	  Local $Imagehetluotlaythanhvat = @ScriptDir & "\image\hetluotlaythanhvat.bmp"
	  $p = _searchNVAdvance($Handle,$Imagehetluotlaythanhvat,$Imagelaythanhvat,98,115);search nv tien thuong
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 Return
	  EndIf
	  writelog("Vô Lấy Thánh Vật" & _NowTime() & @CRLF) ; write console
	  Opt("WinTitleMatchMode", 3)
	  _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1260 800");click toi ngay
	  Local $maxloop = 0
	  Local $count = 0;
	  While $maxloop < 30
	  $maxloop = $maxloop + 1
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,2, 0, 0, -1, -1,95, 2);search icon thoat pho ban
	  If @error Then
		 ContinueLoop
	  Else ; neu tim thay nut thoat
		 If $count == 0 Then _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 750 650 750 570 800"); di chuyen vuot len 1 chut
		 Sleep(500)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1174 54");click server the gioi
		 Sleep(1500)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 300 200");click chien truong vang
		 Local $Imagehetluotkhaithac = @ScriptDir & "\image\hetluotkhaithac.bmp"
		 Local $rshetluotkhaithac = _HandleImgWaitExist($Handle, $Imagehetluotkhaithac,2, 0, 0, -1, -1,70, 2);search het luot khai thac
		 If Not @error Then ; neu tim thay la het luot khai thac
			_close($Handle)
			Sleep(1000)
			_ControlClickExactly($Title, "", "","", 1,$rsthoatpb[1][0], $rsthoatpb[1][1]) ; click thoat
			Sleep(1500)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 985 600") ;click Xac nhan
			Return SetError(3)
		 EndIf
		 _close($Handle)
		 $count = $count + 1
		 If $count == 3 Then
			Local $x = 380
			Local $y = 331
			$count = 0 ;reset
		 ElseIf $count == 2 Then
			Local $x = 673
			Local $y = 387
		 Else
			Local $x = 765
			Local $y = 325
		 EndIf
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1500 100");click to map
		 Sleep(3000)
		 ;click to toa do 1
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap "&$x&" "&$y);click to map
		 Sleep(1000)
		 _close($Handle)
		 Sleep(3000)
		 Local $Imagekhaithac = @ScriptDir & "\image\khaithacmo.bmp"
		 Local $rs2 = _HandleImgWaitExist($Handle, $Imagekhaithac,8, 0, 0, -1, -1,90, 2);search image duoc khai thac
		 If Not @error Then
			writelog("Khai Thac" & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 1,$rs2[1][0], $rs2[1][1]) ; click khai thac
			Sleep(11000)
		 Else
			ContinueLoop
		 EndIf
	  EndIf
	  WEnd
   EndFunc   ;==>GotoPB



Func _GotoHoTongBaoTang($Title,$emuport,$Handle)
	  Local $flagHoTong = False
	  If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Local $Now = _NowTime(4);time hien tai
	  Local $flag_baotang_11h = IniRead($pathconfig&$Title&".config", $config, $baotang11h, False)
	  If $flag_baotang_11h == True Then
		 Local $var1 = StringRegExpReplace($Now, "[:]", "")
		 Local $timestart = StringRegExpReplace("11:00", "[:]", "")
		 Local $timeend = StringRegExpReplace("12:00", "[:]", "")
		 If $var1 > $timestart And $var1 < $timeend Then
			$flagHoTong = True
		 Else
			writelog("Khong trong thoi gian Ho Tong 11h -> 12h" & _NowTime() & @CRLF) ; write console
		 EndIf
	  EndIf
	  Local $flag_baotang_21h = IniRead($pathconfig&$Title&".config", $config, $baotang21h, False)
	  If $flag_baotang_21h == True Then
		 Local $var1 = StringRegExpReplace($Now, "[:]", "")
		 Local $timestart = StringRegExpReplace("21:00", "[:]", "")
		 Local $timeend = StringRegExpReplace("22:00", "[:]", "")
		 If $var1 > $timestart And $var1 < $timeend Then
			$flagHoTong = True
		 Else
			writelog("Khong trong thoi gian Ho Tong 21h -> 22h" & _NowTime() & @CRLF) ; write console
		 EndIf
	  EndIf
	  If $flagHoTong <> True Then
		 writelog("Khong the ho tong luc nay" & _NowTime() & @CRLF) ; write console
		 Return
	  EndIf
	  Local $ImageHoTong = @ScriptDir & "\image\conluothotong.bmp"
	  Local $ImagehetluotHoTong = @ScriptDir & "\image\hetluothotong.bmp"
	  Local $p = _searchNVAdvance($Handle,$ImagehetluotHoTong,$ImageHoTong,105,100,3);search nv ho tong
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 Return
	  EndIf
	  Opt("WinTitleMatchMode", 3)
	  _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1260 800");click toi ngay
	  Sleep(3000)
	  Local $ImageBaoTangGolbin = @ScriptDir & "\image\baotangicon.bmp"
	  Local $rs = _HandleImgWaitExist($Handle, $ImageBaoTangGolbin,10, 0, 0, -1, -1,90, 2);search image Bao Tang Golbin
	  If Not @error Then
		 _ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click toi image
		 Sleep(2000)
		 Local $Image1tren3 = @ScriptDir & "\image\theluc1tren3.bmp"
		 Local $rs = _HandleImgWaitExist($Handle, $Image1tren3,1, 400, 430, 100, 50,90, 2);search image 1/3 the luc
		 ;chon loai ho tong
		 If Not @error Then ; xu li ho tong 1 the luc
			writelog("Di Bao Tang Bac" & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 500 450");click to Bao Tang Bac
		 Else ;xu li 2 the luc ho tong
			writelog("Di Bao Tang Vang" & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 450");click to Bao Tang Vang
		 EndIf
		 ;ho tong
		 Sleep(3000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 750");click to Cau ho tro
		 Sleep(1000)
		 Local $ImageCauHoTro = @ScriptDir & "\image\cauhotrobtn.bmp"
		 Local $rs = _HandleImgWaitExist($Handle, $ImageCauHoTro,1, 0, 0, -1, -1,80, 2);search image cau ho tro
		 If Not @error Then ; thay cau ho tro thi chon doi ho tong
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 400 400");click to team 1
			Sleep(500)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 650 400");click to team 2
			Sleep(500)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 400");click to team 3
			Sleep(500)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 750");click to Cau ho tro
		 EndIf
		 Local $count = 0
		 While $count < 4
			$count = $count + 1
			Local $ImageBatdauNgay = @ScriptDir & "\image\batdaungayHoTong.bmp"
		    Local $rs = _HandleImgWaitExist($Handle, $ImageBatdauNgay,60, 0, 0, -1, -1,90, 2);search image bat dau ngay trong 60
			If Not @error Then ; thay thi click
			   _ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click bat dau luon
			   $count = 0
			   ExitLoop
			Else ; het 60s ko thay thi bam Cau Ho tro again
			   Sleep(2000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 750");click to Cau ho tro
			EndIf
		 WEnd
		 If $count == 0 Then ; da vo pho ban
			writelog("Bat Dau Ho Tong" & _NowTime() & @CRLF) ; write console
			Local $ImageTrieuHoiVS = @ScriptDir & "\image\trieutapvesi.bmp"
			While 1
			   Local $rs = _HandleImgWaitExist($Handle, $ImageTrieuHoiVS,15, 0, 0, -1, -1,70, 2);search image trieu tap ve si
			   If Not @error Then ; van thay icon trieu hoi nghia la chua ho tong xong
				  Sleep(15000); cho 15s kiem tra 1 lan
			   Else ; ko thay la ket thuc ho tong roi
				  writelog("Cho 15 Giay Ket Thuc Ho Tong" & _NowTime() & @CRLF) ; write console
				  Sleep(15000); cho 15 ket thuc ho tong
				  ExitLoop
			   EndIf
			WEnd
		 EndIf
	  EndIf
EndFunc   ;==>GotoPB



