Local $Conluotboss = false
Func _GotoPBBossCaNhan($Title,$emuport,$Handle)
	 If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1208 56");click BOSS
	  Sleep(1000)
	  Local $ImageIconBossCaNhan = @ScriptDir & "\image\bosscanhanicon.bmp"
	  Local $RsIconBoss = _HandleImgWaitExist($Handle,$ImageIconBossCaNhan,5, 0, 0, -1, -1,80, 2);search icon boss ca nhan
	  If not @error Then ; Neu tim thay boss ca nhan icon
		 _ControlClickExactly($Title, "", "","", 1,$RsIconBoss[1][0]+4, $RsIconBoss[1][1]+4) ; click toi cho vua tim
	  Else
		 Return
	  EndIf
      Sleep(1000)
	  Local $Imagetoingay = @ScriptDir & "\image\ToingaybossGuide.bmp"
	  Local $Rstoingay = _HandleImgWaitExist($Handle,$Imagetoingay,2, 565,440, 120, 50,91, 2);search icon toi ngay
	  If @error Then ; k tim thay thoat auto boss ca nhan
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 Return
	  Else
		 $Conluotboss = True
	  EndIf
	  If $Conluotboss == True Then
	  writelog("Click Toi Ngay Boss " & _NowTime() & @CRLF) ; write console
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1100 800");click TOI NGAY
      Sleep(3000)
	  $Imagehetluot = @ScriptDir & "\image\hetluotbosscanhan3.bmp"
	  Local $x_tolerance_hetluotboss = 129
	  If $isLDPlayer == True Then
		 $x_tolerance_hetluotboss = 130
	  EndIf

	  $Rshetluot = _HandleImgWaitExist($Handle,$Imagehetluot,2, 390, 230, 80, 60,$x_tolerance_hetluotboss, 2);search icon het luot boss
	  If not @error Then ; thay icon mua them luot => het luot boss ca nhan
		 writelog("Het Luot " & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 return SetError(3)
	  EndIf
	  ;check toi ngay again
	  Sleep(2000)
	  $Rstoingay = _HandleImgWaitExist($Handle,$Imagetoingay,1, 590,440, 100, 50,91, 2);search toi ngay icon lan 2
	  If not @error Then ; neu van tim thay toi ngay icon -> tim boss phu hop
		 writelog("Lựa chọn lại boss " & _NowTime() & @CRLF) ; write console
		 While 1
			Local $Imagelockboss = @ScriptDir & "\image\lockbosscanhan.bmp"
			Local $ResultFilter = _HandleImgWaitExist($Handle,$Imagelockboss,1, 70,70, 105, 505,60, 10);search lock boss
			If not @error Then ; filter boss
			   if $ResultFilter[0][0] > 2 Then
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input swipe 170 550 170 700 800"); di chuyen cuon len 1 chut
				  Sleep(2000)
			   Else
				  Sleep(2000)
				  _ControlClickExactly($Title, "", "","", 1,$ResultFilter[1][0]+75, $ResultFilter[1][1]+15) ; click vo tri boss gan lock boss nhat
				  Sleep(1000)
				  Local $Imagelockbossnho = @ScriptDir & "\image\lockbossnho.bmp"
			      Local $ResultCan = _HandleImgWaitExist($Handle,$Imagelockbossnho,1, 0,0, -1, -1,60, 2);search nv cu hay moi
				  If not @error Then ; filter boss
					 _ControlClickExactly($Title, "", "","", 1,$ResultFilter[1][0]+75, $ResultFilter[1][1]-45) ; click vo tri boss gan lock boss nhi
				  EndIf
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1100 800");click TOI NGAY
				  ExitLoop
			   EndIf

			Else ; ko thay boss nao bi lock
			   writelog("Chưa thể đánh boss cá nhân lúc này" & _NowTime() & @CRLF) ; write console
			   Return
			EndIf
		 WEnd
	  EndIf
	  ;check het luot lan 2
	  $Rshetluot = _HandleImgWaitExist($Handle,$Imagehetluot,1, 390, 230, 80, 60,$x_tolerance_hetluotboss, 2);search icon het luot boss
	  If not @error Then ; thay icon mua them luot => het luot boss ca nhan
		 writelog("Het Luot " & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 return SetError(3)
	  EndIf

	  ;check lan 3
	  $Imagexacnhan = @ScriptDir & "\image\Xacnhan1.bmp"
	  $ResultXacNhan = _HandleImgWaitExist($Handle,$Imagexacnhan,1, 0, 0, -1, -1,105, 2);search xac nhan
	  If not @error Then ; neu van tim thay toi ngay icon -> thoat auto boss
		 _ControlClickExactly($Title, "", "","", 1,$ResultXacNhan[1][0], $ResultXacNhan[1][1]) ; click toi cho vua tim
	  EndIf
	  ;check lan 4
	  $Imagexacnhan = @ScriptDir & "\image\xacnhanbtn.bmp"
	  $ResultXacNhan = _HandleImgWaitExist($Handle,$Imagexacnhan,1, 0, 0, -1, -1,105, 2);search xac nhan
	  If not @error Then ; neu van tim thay toi ngay icon -> thoat auto boss
		 _ControlClickExactly($Title, "", "","", 1,$ResultXacNhan[1][0], $ResultXacNhan[1][1]) ; click toi cho vua tim
	  EndIf
	  Sleep(5000)
	  Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
      _HandleImgWaitExist($Handle, $Imagethoatpb,5, 655, 40, 40, 40,$x_toler_thoatpb, 2);search icon thoat pho ban
	  If @error Then
		  writelog("Lỗi không thể vô BOSS Cá Nhân lúc này " & _NowTime() & @CRLF) ; write console
		  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 return
	  EndIf
	  writelog("Vao Boss Ca Nhan " & _NowTime() & @CRLF) ; write console
	  Sleep(20000)
	  writelog("cho pb ket thuc...." & _NowTime() & @CRLF) ; write console
	  $ImagePath = @ScriptDir & "\image\menu.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath,420, 660,30, 60, 50,$x_toler_menu, 2);search nut menu max 7p
	  If not @error Then
		 writelog("Ket Thuc " & _NowTime() & @CRLF) ; write console
	  EndIf
	  Else
		 Return SetError(3)
	  EndIf
EndFunc   ;==>GotoPB

