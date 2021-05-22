$Conluotboss = false
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
	  $ImageIconBossCaNhan = @ScriptDir & "\image\bosscanhanicon.bmp"
	  $RsIconBoss = _HandleImgWaitExist($Handle,$ImageIconBossCaNhan,2, 0, 0, -1, -1,80, 2);search icon boss ca nhan
	  If not @error Then ; Neu tim thay boss ca nhan icon
		 ControlClick($Title, "", "","", 1,$RsIconBoss[1][0]+4, $RsIconBoss[1][1]+4) ; click toi cho vua tim
	  Else
		 Return
	  EndIf
      Sleep(1000)
	  Local $Imagetoingay = @ScriptDir & "\image\ToingaybossGuide.bmp"
	  $Rstoingay = _HandleImgWaitExist($Handle,$Imagetoingay,2, 590,440, 100, 50,91, 2);search icon toi ngay
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
	  $Rshetluot = _HandleImgWaitExist($Handle,$Imagehetluot,2, 0, 0, -1, -1,115, 10);search icon het luot boss
	  If not @error Then
		 writelog("Het Luot " & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 return SetError(3)
	  EndIf
	  ;check toi ngay again
	  Sleep(2000)
	  $Rstoingay = _HandleImgWaitExist($Handle,$Imagetoingay,1, 590,440, 100, 50,91, 2);search toi ngay icon lan 2
	  If not @error Then ; neu van tim thay toi ngay icon -> thoat auto boss
		 writelog("Chua the danh boss ca nhan luc nay " & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111") ; press 'esc'
		 Return
	  EndIf
	  ;check lan 3
	  $Imagexacnhan = @ScriptDir & "\Images\Xacnhan1.bmp"
	  $ResultXacNhan = _HandleImgWaitExist($Handle,$Imagexacnhan,1, 0, 0, -1, -1,105, 2);search xac nhan
	  If not @error Then ; neu van tim thay toi ngay icon -> thoat auto boss
		 ControlClick($Title, "", "","", 1,$ResultXacNhan[1][0], $ResultXacNhan[1][1]) ; click toi cho vua tim
	  EndIf
	  writelog("chuan bi vo boss ca nhan.... waiting 30s " & _NowTime() & @CRLF) ; write console
	  Sleep(30000)
	  writelog("cho pb ket thuc...." & _NowTime() & @CRLF) ; write console
	  $ImagePath = @ScriptDir & "\image\menu.bmp"
	  $Result = _HandleImgWaitExist($Handle, $ImagePath,420, 660,30, 60, 50,85, 2);search nut menu max 7p
	  If not @error Then
		 writelog("Ket Thuc " & _NowTime() & @CRLF) ; write console
	  EndIf
	  Else
		 Return SetError(3)
	  EndIf
EndFunc   ;==>GotoPB

