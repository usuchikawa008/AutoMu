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
	  $p = _searchNVAdvance($Handle,$Imagehetluotlaythanhvat,$Imagelaythanhvat,95,115);search nv tien thuong
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 Return
	  EndIf
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1260 800");click toi ngay
	  $maxloop = 0
	  Local $count = 0;
	  While $maxloop < 30
	  $maxloop = $maxloop + 1
	  $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,2, 0, 0, -1, -1,95, 2);search icon thoat pho ban
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
			ControlClick($Title, "", "","", 1,$rsthoatpb[1][0], $rsthoatpb[1][1]) ; click thoat
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
		 Sleep(4000)
		 $Imageduoockhaithac = @ScriptDir & "\image\duockhaithac.bmp"
		 $rs = _HandleImgWaitExist($Handle, $Imageduoockhaithac,4, 0, 0, -1, -1,125, 2);search image duoc khai thac
		 If Not @error Then
			writelog("Thay Mo" & _NowTime() & @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click toi image duoc khai thac
			Sleep(2000)
		 EndIf
		 $Imagekhaithac = @ScriptDir & "\image\khaithacmo.bmp"
		 $rs2 = _HandleImgWaitExist($Handle, $Imagekhaithac,2, 0, 0, -1, -1,80, 2);search image duoc khai thac
		 If Not @error Then
			writelog("Khai Thac" & _NowTime() & @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$rs2[1][0], $rs2[1][1]) ; click khai thac
			Sleep(11000)
		 Else
			ContinueLoop
		 EndIf
	  EndIf
	  WEnd
   EndFunc   ;==>GotoPB



Func _GotoHoTongBaoTang($Title,$emuport,$Handle)
	  If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	  EndIf
	   Local $Now = _NowTime(4);time hien tai
	   Local $Hotongbaotang = False
	   Local $dayofweek = _getDayofWeek()
	   If $dayofweek == $T3 OR $dayofweek == $T5 OR $dayofweek == $T7 Then
	   EndIf

;~ 	   $var1 = StringRegExpReplace($Now, "[:]", "")
;~ 	   Local $timestart = StringRegExpReplace("21:00", "[:]", "")
;~ 	   Local $timeend = StringRegExpReplace("22:00", "[:]", "")
;~ 	   If $var1 > $timestart And $var1 < $timeend Then

;~ 	   Else
;~ 		 Return
;~ 	   EndIf
	   Local $ImageHoTong = @ScriptDir & "\image\conluothotong.bmp"
	   Local $ImagehetluotHoTong = @ScriptDir & "\image\hetluothotong.bmp"
	   $p = _searchNVAdvance($Handle,$ImagehetluotHoTong,$ImageHoTong,90,90,3);search nv ho tong
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 Return
	  EndIf
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1260 800");click toi ngay
	  Sleep(3000)
	  $ImageBaoTangGolbin = @ScriptDir & "\image\baotangicon.bmp"
	  $rs = _HandleImgWaitExist($Handle, $ImageBaoTangGolbin,10, 0, 0, -1, -1,90, 2);search image Bao Tang Golbin
	  If Not @error Then
		 ControlClick($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click toi image
		 Sleep(2000)
		 $Image1tren3 = @ScriptDir & "\image\theluc1tren3.bmp"
		 $rs = _HandleImgWaitExist($Handle, $Image1tren3,1, 0, 0, -1, -1,80, 2);search image 1/3 the luc
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
		 $ImageCauHoTro = @ScriptDir & "\image\cauhotrobtn.bmp"
		 $rs = _HandleImgWaitExist($Handle, $ImageCauHoTro,1, 0, 0, -1, -1,80, 2);search image cau ho tro
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
			$ImageBatdauNgay = @ScriptDir & "\image\batdaungayHoTong.bmp"
		    $rs = _HandleImgWaitExist($Handle, $ImageBatdauNgay,60, 0, 0, -1, -1,90, 2);search image bat dau ngay trong 60
			If Not @error Then ; thay thi click
			   writelog("Bat Dau Ho Tong" & _NowTime() & @CRLF) ; write console
			   ControlClick($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click bat dau luon
			   $count = 0
			   ExitLoop
			Else ; het 60s ko thay thi bam Cau Ho tro again
			   Sleep(2000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 800 750");click to Cau ho tro
			EndIf
		 WEnd
		 If $count == 0 Then ; da vo pho ban
			$ImageTrieuHoiVS = @ScriptDir & "\image\trieutapvesi.bmp"
			While 1
			   $rs = _HandleImgWaitExist($Handle, $ImageTrieuHoiVS,15, 0, 0, -1, -1,90, 2);search image trieu tap ve si
			   If Not @error Then ; van thay icon trieu hoi nghia la chua ho tong xong
				  Sleep(15000); cho 15s kiem tra 1 lan
			   Else ; ko thay la ket thuc ho tong roi
				  writelog("Cho 15 Giay Ket Thuc Ho Tong" & _NowTime() & @CRLF) ; write console
				  Sleep(15000); cho 15 ket thuc ho tong
			   EndIf
			WEnd
		 EndIf
	  EndIf
EndFunc   ;==>GotoPB



