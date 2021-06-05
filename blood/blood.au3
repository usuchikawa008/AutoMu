Func GotoPBBlood($Title,$emuport,$Handle)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(1000)
	 ; check xem blood het luot hay chua
    Local $ImagePathHetLuot = @ScriptDir & "\image\bloodhetluot.bmp"
	Local $result = _HandleImgWaitExist($Handle, $ImagePathHetLuot,1, 0, 0, -1, -1,105, 10);search blood het luot
	 If not @error Then
		Return SetError(3)
	 EndIf
    Local $ImagePath = @ScriptDir & "\image\bloodconluot.bmp"
	Local $p = _HandleImgSearch($Handle, $ImagePath, 0, 0, -1, -1,120, 10);search so luot pb blood
	If @error Then
	   writelog("Blood chua san sang ...." & _NowTime() & @CRLF) ; write console
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
					Local $rsghepve = _HandleImgWaitExist($Handle, $Imageghepve,2,570,270, 60, 60,80, 2);search icon gep ve
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
	  Sleep(10000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
	  For $i = 0 to 5 Step + 1
		 Sleep(1000)
	     _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
	  Next
	  Sleep(1000)
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
	  writelog("Xac nhan da vo pho ban blood wait 80s " & @CRLF) ; write console
	  Sleep(80000);cho 80s
	  writelog("Cho ket thuc pb blood...." & _NowTime() & @CRLF) ; write console
	  Local $ImagePath = @ScriptDir & "\image\menu.bmp"
	  Local $Result = _HandleImgWaitExist($Handle, $ImagePath,480, 660,30, 60, 50,91, 2);search nut menu
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
	  $p = _HandleImgWaitExist($Handle,$Imagebossguild,2, 0, 0, -1, -1,110, 2);search boss guild icon
	  If @error Then ;het luot
		 Return SetError(3)
	  Else
		 writelog("Vao Devil  " & _NowTime() & @CRLF) ; write console
		 _ControlClickExactly($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+15) ; click toi
		 Sleep(2000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1150 800");click xac nhan
		 ;click toi xac nhan
		 Sleep(7000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
		 For $i = 0 to 5 Step + 1
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
		 Next
		 Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu
		 Sleep(1000)
;~ 		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1431 700");click auto
		 EndIf
		 writelog("Cho 5 phut ket thuc Devil"& @CRLF) ; write console
		 Sleep(310000); cho 5p
	   $ImagePath = @ScriptDir & "\image\menu.bmp"
	   $Result = _HandleImgWaitExist($Handle, $ImagePath,100, 660,30, 60, 50,94, 2);search nut menu
	   Sleep(2000)
EndFunc   ;==>GotoPB


