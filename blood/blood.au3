Func GotoPBBlood($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(1000)
   Local $ImagePath = @ScriptDir & "\image\bloodconluot.bmp"
   Local $ImagePathHetLuot = @ScriptDir & "\image\bloodhetluot.bmp"
   Local $p = _searchNVAdvance($Handle,$ImagePathHetLuot,$ImagePath,105,120,2);search nv tien thuong
   If @error Then ; het luot
	  Return SetError(3)
   EndIf
   If $p == 2 Then ; ko tim thay hinh nao het
	  _closeSimple($Handle);tat cua so
	  Return
   EndIf
	 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi pb
	 ;cho menu blood xuat hien start
	 Sleep(1000)
	 Local $Imagetoikhieuchien = @ScriptDir & "\image\toikhieuchienblood.bmp"
	 Local $p = _HandleImgWaitExist($Handle, $Imagetoikhieuchien,30, 0, 0, -1, -1,80, 10); search trong vong 30s
        If @error Then
		   return
	    Else
		   Sleep(1500)
		   Local $Imagehetve = @ScriptDir & "\image\hetveblood.bmp"
	       Local $rshetve = _HandleImgSearch($Handle, $Imagehetve, 500, 440, 50, 50,120, 2);search so luot pb blood
		   If not @error Then
			   writelog("Het ve blood...." & _NowTime() & @CRLF) ; write console
			   ;xu li het ve
			   Local $flagghepVe = IniRead($pathImage&"1.tmp", $general, $ghepveblood, ""); check flag ghep ve
			   If $flagghepVe == True Then
					_ControlClickExactly($Title, "", "","", 1,$rshetve[1][0]+500, $rshetve[1][1]+440) ; click vao het ve
					Sleep(1000)
					_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 130");click lay
					Sleep(1000)
					Local $Imageghepve = @ScriptDir & "\image\ghepveblood.bmp"
					If isLDPlayer() Then
					    $Imageghepve = @ScriptDir & "\image\ghepveblood_ld.bmp"
					EndIf
					Local $rsghepve = _HandleImgWaitExist($Handle, $Imageghepve,2,570,270, 60, 60,110, 2);search icon gep ve
					If not @error Then
						 _ControlClickExactly($Title, "", "","", 1,$rsghepve[1][0]+570, $rsghepve[1][1]+270) ; click vao ghep ve
					Else
						 writelog("Loi..ko the ghep ve luc nay...." & _NowTime() & @CRLF) ; write console
						 Return
					 EndIf
					 Sleep(3000)
					 For $i = 0 to 10 Step + 1
						Sleep(100)
						_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1300 550");click + 10 lan
					 Next
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click ghep
					 _closeSimple($Handle)
					 Sleep(3000)
			   Else
				  Return SetError(3)
			   EndIf

			   EndIf
		   writelog("Chuan bi vao blood...." & _NowTime() & @CRLF) ; write console
		   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click Khieu chien
		   ;Confirm
		   Local $Imagekientrivao = @ScriptDir & "\image\kientrivaoblood.bmp"
		   Local $p1 = _HandleImgWaitExist($Handle, $Imagekientrivao,2, 0, 0, -1, -1,80, 2); search kien tri vao
		   If not @error Then
			  writelog("kien tri vao...." & _NowTime() & @CRLF) ; write console
			  _ControlClickExactly($Title, "", "","", 1,$p1[1][0], $p1[1][1]) ; click kien tri vao
		   EndIf
		EndIf
	 ;cho menu blood xuat hien end
	  Sleep(7000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
      _HandleImgWaitExist($Handle, $Imagethoatpb,5, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
	  Sleep(1000)
	  For $i = 0 to 5 Step + 1
		 Sleep(200)
	     _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
	  Next
	  Sleep(300)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
	  writelog("Xac nhan da vo pho ban blood wait 80s " & @CRLF) ; write console
	  Sleep(80000);cho 80s
	  writelog("Cho ket thuc pb blood...." & _NowTime() & @CRLF) ; write console
	  Local $ImagePath = @ScriptDir & "\image\menu.bmp"
	  Local $Result = _HandleImgWaitExist($Handle, $ImagePath,900, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
EndFunc   ;==>GotoPB



Func _GotoDevilSquare($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 325 130") ;chuyen sang tab hoat dong han gio
	  $Imagebossguild = @ScriptDir & "\image\devilicon.bmp"
	  Local $p = _HandleImgWaitExist($Handle,$Imagebossguild,2, 0, 0, -1, -1,110, 2);search devil icon
	  If @error Then ;ko tim thay -> tim cach khac
		 _closeSimple($Handle); dong cua so NV
		 While 1 ; tim icon devil
			Local $Imagexnho = @ScriptDir & "\image\xnho.bmp"
			Local $p_nho = _HandleImgWaitExist($Handle,$Imagexnho,1, 630, 190, 20, 20,100, 2);search dau X
			If Not @error Then ; thay x nho
			   Local $ImageIconDevil = @ScriptDir & "\image\devilicon2.bmp"
			   Local $rsDevil= _HandleImgWaitExist($Handle,$ImageIconDevil,1, 550, 225, 100, 100,80, 2);search icon boss guild
			   If Not @error Then ; thay icon Tu hoi click
				  _ControlClickExactly($Title, "", "","", 1,$rsDevil[1][0]+550, $rsDevil[1][1]+320) ; click toi ngay
				  ;click toi xac nhan
				  ExitLoop
			   EndIf
			   _ControlClickExactly($Title, "", "","", 1,$p_nho[1][0]+631, $p_nho[1][1]+191) ; click tat notify
			   Sleep(500)
			Else ; het icon nho
			   Return SetError(3)
			EndIf
		 WEnd
	  Else
		 Sleep(1000)
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+21) ; click toi
	  EndIf
	  Sleep(2000)
	  ;check devil da san sang
	  Local $Imagetabhoatdongguild = @ScriptDir & "\image\tabhoatdongguild.bmp"
	  _HandleImgWaitExist($Handle, $Imagetabhoatdongguild,12, 740,250, 100, 100,120, 5); cho menu devil xuat hien
	  ;check het ve hay ko ->>> here
	  Local $Imagehetvedevil = @ScriptDir & "\image\hetvedevil.bmp"
	  Local $rshetve = _HandleImgSearch($Handle, $Imagehetvedevil, 0,0, -1, -1,80, 5);search het ve devil
	  If not @error Then
		 writelog("Het ve devil...." & _NowTime() & @CRLF) ; write console
		 ;xu li het ve
		 Local $flagghepVe = IniRead($pathImage&"1.tmp", $general, $ghepveblood, ""); check flag ghep ve
		 If $flagghepVe == True Then
		   _ControlClickExactly($Title, "", "","", 1,$rshetve[1][0]+3, $rshetve[1][1]+3) ; click vao het ve
		   Sleep(1000)
		   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 130");click lay
		   Sleep(1000)
		   Local $Imageghepve = @ScriptDir & "\image\ghepveblood.bmp"
		   Local $x_ghepve_tolerance = 140
		   If isLDPlayer() Then
			   $Imageghepve = @ScriptDir & "\image\ghepveblood_ld.bmp"
			   $x_ghepve_tolerance = 80
			EndIf
		   Local $rsghepve = _HandleImgWaitExist($Handle, $Imageghepve,2,570,220, -1, -1,$x_ghepve_tolerance, 5);search icon gep ve
		   If not @error Then
				_ControlClickExactly($Title, "", "","", 1,$rsghepve[1][0]+570, $rsghepve[1][1]+220) ; click vao ghep ve
		   Else
				writelog("Loi..ko the ghep ve luc nay...." & _NowTime() & @CRLF) ; write console
				Return
			EndIf
			Sleep(3000)
			For $i = 0 to 10 Step + 1
			   Sleep(100)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1300 550");click + 10 lan
			Next
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click ghep
			_closeSimple($Handle)
			Sleep(3000)
		 EndIf

	  EndIf

	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
	  writelog("Vao Devil  " & _NowTime() & @CRLF) ; write console
	  Sleep(7000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  _HandleImgWaitExist($hwnd, $Imagethoatpb,6, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
	  _Covu()
	  Sleep(1000)
	  writelog("Cho 5 phut ket thuc Devil"& @CRLF) ; write console
	  Sleep(310000); cho 5p
	  $ImagePath = @ScriptDir & "\image\menu.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath,100, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
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
	  Local $Imagephaodai = @ScriptDir & "\image\phaodaidoconluot.bmp" ;image phao dai do
	  Local $p = _HandleImgWaitExist($Handle,$Imagephaodai,2, 0, 0, -1, -1,120, 2);search icon phao dai
	  If @error Then ;het luot
		 Return SetError(3)
	  Else
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi icon phao dai
		 writelog("Vao Phao Dai " & _NowTime() & @CRLF) ; write console
		 Sleep(2000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
		 ;click confirm neu dang trong party
		 writelog("Cho ket thuc phao dai...." & _NowTime() & @CRLF) ; write console
		 Sleep(180000)
		 Local $ImagePath = @ScriptDir & "\image\menu.bmp"
		 Local $Result = _HandleImgWaitExist($Handle, $ImagePath,660, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
	  EndIf
	  Sleep(2000)
   EndFunc   ;==>GotoPB


Func _GotoDiaLao($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
 	  Local $Imageconluotdialao = @ScriptDir & "\image\dialaonguyento_con.bmp"
	  Local $Imagehetluotdialao = @ScriptDir & "\image\dialaonguyento_het.bmp"
	  Local $p = _searchNVAdvance($Handle,$Imagehetluotdialao,$Imageconluotdialao,100,120);search nv tien thuong
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 _closeSimple($Handle);tat cua so
	  Return
	  EndIf
	  Sleep(1000)
	 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi icon dia lao
	  Sleep(1500)
	  ;check het luot
	  Local $x_hetluotdialao_tolerance = 105
	  If $isLDPlayer == True Then
		 $x_hetluotdialao_tolerance = 136
	  EndIf
	  Local $Imagehetluot = @ScriptDir & "\image\hetluotdialao.bmp" ;image het luot
	  _HandleImgWaitExist($Handle,$Imagehetluot,1, 400, 240, 100, 100,$x_hetluotdialao_tolerance, 2);search icon het luot
	  If not @error Then ; tim thay -> het luot
		 Return SetError(3)
	  EndIf
	  Local $Imagefight = @ScriptDir & "\image\fightdialao.bmp" ;image chien dau
	  Local $p = _HandleImgWaitExist($Handle,$Imagefight,2, 0, 0, -1, -1,100, 2);search icon chien dau
	  If @error Then ; ko tim thay -> lam lai luc khac
		 Return
	  Else
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0], $p[1][1]) ; click image
		 Sleep(1500)
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click toi khieu chien
		  Sleep(2000)
		  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
		 _HandleImgWaitExist($Handle, $Imagethoatpb,5, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
		 If @error Then ; ko tim thay -> lam lai luc khac
			Return
		 Else
			writelog("Vào khiêu chiến địa lao...." & _NowTime() & @CRLF) ; write console
			Local $ImagePath = @ScriptDir & "\image\menu.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,71, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
		 EndIf
	  EndIf
	  Sleep(2000)
   EndFunc   ;==>GotoPB


Func _GotoThanhDan($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
 	  Local $Imageconluotthanhdan = @ScriptDir & "\image\thanhdannguyento_con.bmp"
	  Local $Imagehetluotthanhdan = @ScriptDir & "\image\thanhdannguyento_het.bmp"
	  Local $p = _searchNVAdvance($Handle,$Imagehetluotthanhdan,$Imageconluotthanhdan,100,120);search nv thanhdan
	  If @error Then ; het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 _closeSimple($Handle);tat cua so
		 Return
	  EndIf
	  Sleep(1000)
	 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi icon thanh dan
	  Sleep(2000)
	  _chonTangThanhDan($Title,$emuport,$Handle)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click toi khieu chien
	  Sleep(1500)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 600 600");click kien tri
	  Sleep(4000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
	  _HandleImgWaitExist($Handle, $Imagethoatpb,5, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
	  If @error Then ; ko tim thay -> lam lai luc khac
		 Return
	  Else
		 AdLibRegister("_toiNgay", 5000);auto run this function every 5 s
		 writelog("Vào khiêu chiến thánh đàn...." & _NowTime() & @CRLF) ; write console
		 Sleep(8000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 250 300");click focus vo 1 tru
		 ;cho 60s
		 Sleep(60000)
		 Local $ImagePath = @ScriptDir & "\image\menu.bmp"
		 _HandleImgWaitExist($Handle, $ImagePath,300, 660,30, 60, 50,$x_toler_menu, 2);search nut menu
		 If not @error Then
			writelog("Kết thúc thánh đàn...." & _NowTime() & @CRLF) ; write console
		 EndIf
		 AdlibUnRegister("_toiNgay")
	  EndIf
	  Sleep(2000)
   EndFunc   ;==>GotoPB
Func _chonTangThanhDan($Title,$emuport,$Handle)
   Local $readconfig = IniRead($pathconfig&$Title&".config", $config, $tangthanhdan, 0)
   Switch $readconfig
    Case 0
        Return
    Case 1
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 230 250 600 100"); cuon xuong
		writelog("Chọn tầng 1"& @CRLF) ; write console
		_clickToaDo(222)
    Case 2
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 230 250 600 100"); cuon xuong
		writelog("Chọn tầng 2"& @CRLF) ; write console
		_clickToaDo(333)
    Case 3
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 230 250 600 100"); cuon xuong
		writelog("Chọn tầng 3"& @CRLF) ; write console
		_clickToaDo(444)
    Case 4
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 230 250 600 100"); cuon xuong
		writelog("Chọn tầng 4"& @CRLF) ; write console
		_clickToaDo(555)
    Case 5
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 230 250 600 100"); cuon xuong
		writelog("Chọn tầng 5"& @CRLF) ; write console
		_clickToaDo(666)
    Case 6
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 600 250 230 100"); cuon len
		writelog("Chọn tầng 6"& @CRLF) ; write console
		_clickToaDo(350)
    Case 7
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 600 250 230 100"); cuon len
		writelog("Chọn tầng 7"& @CRLF) ; write console
		_clickToaDo(450)
    Case 8
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 600 250 230 100"); cuon len
		writelog("Chọn tầng 8"& @CRLF) ; write console
		_clickToaDo(580)
    Case 9
        _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 250 600 250 230 100"); cuon len
		writelog("Chọn tầng 9"& @CRLF) ; write console
		_clickToaDo(681)
    Case Else
        writelog("Không tìm thấy tầng khiêu chiến....chạy mặc định" & _NowTime() & @CRLF) ; write console
		Return
   EndSwitch

EndFunc

Func _clickToaDo($y)
   Sleep(2000)
   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 250 "&$y);click
   Sleep(1000)
EndFunc

Func _toiNgay()
   Local $ImageXacNhan = @ScriptDir & "\image\toingay.bmp"
   Local $rs = _HandleImgSearch($hwnd, $ImageXacNhan,0, 0, -1, -1,100,5 );search icon xac nhan
   If not @error Then ; thay image
	  _ControlClickExactly($Title, "", "","", 1,$rs[1][0], $rs[1][1]) ; click toi ngay
	  AdlibUnRegister("_toiNgay")
   EndIf
EndFunc   ;==>GotoXac Nhan