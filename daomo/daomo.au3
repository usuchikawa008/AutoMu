Func GotoDaoMo($Title,$emuport,$Handle)
   Local $daomoflag = False
    If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1480 459");click to menu dao mo
	  ;Check Thu Hoach Mo

	  $Imagethuhoach = @ScriptDir & "\image\checkthuhoach.bmp"
	  $p = _HandleImgWaitExist($Handle,$Imagethuhoach,2, 0, 0, -1, -1,90, 10);search xem thu hoach
	  If not @error Then
		 writelog("Thu Hoach... " & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1142 785");click to thu hoach
		 Sleep(800)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 778 766");click to xac nhan
		 Sleep(1000)
	  EndIf

	 ;CHECK LUOT DAO MO CON HAY HET
	 Sleep(1000)
	  $Imagehetluot = @ScriptDir & "\image\hetluotdaomo1.bmp"
	  $p = _HandleImgSearch($Handle,$Imagehetluot, 0, 0, -1, -1,100, 2);search het luot dao mo
	  If @error Then ; con luot dao
		 $Imagebatdau = @ScriptDir & "\image\batdaudaomo1.bmp"
		 $p = _HandleImgSearch($Handle,$Imagebatdau, 0, 0, -1, -1,100, 2);search nut bat dau
		 If @error Then; ko thay not bat dau => out
			writelog("Dao mo chua san sang " & _NowTime() & @CRLF) ; write console
			$sNewTime = _DateAdd('n', 5, _NowCalc()); lay time hien tai + 5p
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
			Return $sNewTime
		 Else
			$daomoflag = True ;dao mo san sang
		 EndIf
	  Else
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
		 Return SetError(3)
	  EndIf
	  Sleep(1000)
	  If $daomoflag Then ; CODE DAO MO
		 $Image2landao = @ScriptDir & "\image\con2landao.bmp"
		 $p = _HandleImgWaitExist($Handle,$Image2landao, 1,0, 0, -1, -1,100, 2);search 2 lan dao
		 If not @error Then ; con 2 lan dao
			writelog("Con 2 luot " & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1212 780");click bat dau
			Sleep(1000)
			$Imagetieuhao = @ScriptDir & "\image\tieuhao.bmp"
			$p1 = _HandleImgWaitExist($Handle,$Imagetieuhao,2,0, 0, -1, -1,90, 2);search image tieu hao
			If not @error Then ;neu het luot tang cap quoc
			   writelog("Het luot nang cap quoc " & _NowTime() & @CRLF) ; write console
			Else
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 719 746");click to tang cap quoc
			EndIf
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 770");click to bat dau dao mo
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 600");click xac nhan
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
		 Else ;con 1 lan dao ; develop later
			writelog("Con 1 luot " & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1212 780");click bat dau
			Sleep(1000)
			While 1
			   Sleep(1000)
			   $Imagetieuhao = @ScriptDir & "\image\tieuhao.bmp"
		       $p1 = _HandleImgWaitExist($Handle,$Imagetieuhao, 1,0, 0, -1, -1,96, 2);search image tieu hao
			   If not @error Then ;neu het luot tang cap quoc
				  writelog("Het luot nang cap quoc " & _NowTime() & @CRLF) ; write console
				  ExitLoop
			   Else
				  Sleep(1000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 719 746");click to tang cap quoc
			   EndIf
			WEnd
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 770");click to bat dau dao mo
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 600");click xac nhan
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
			Return SetError(3) ;het luot dao mo
		 EndIf
		 $sNewTime = _DateAdd('n', 40, _NowCalc()); lay time hien tai + 40p
		 Return $sNewTime
	  EndIf

_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
Sleep(2000)
EndFunc   ;==>GotoPB



Func GotoCuopMo($Title,$emuport,$Handle) ;;function cuop mo
    Local $cuopmoflag = False
    If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1480 459");click to menu dao mo
	Sleep(1000)
	;check het luot cuop hay chua
	Local $Imagehetluot = @ScriptDir & "\image\hetluotcuop.bmp"
    Local $p = _HandleImgSearch($Handle,$Imagehetluot, 0, 0, -1, -1,100, 10);search con luot hay ko
    If not @error Then;het luot
	   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1485 211");back to menu hoat dong
	   Return SetError(3)
	EndIf
	_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 300 770");click danh sach cuop doat
	Sleep(1500)

	  ;cuop mo thuong
	  Local $flagcuop_mo_kho = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_kho, False)
	  If $flagcuop_mo_kho == True Then
		 Local $Imagecuopmokho = @ScriptDir & "\image\cuopmokho.bmp"
		 Local $pkho = _HandleImgSearch($Handle,$Imagecuopmokho, 0, 0, -1, -1,100, 5);search mo kho
		 If not @error Then
			$cuopmoflag = True
			writelog("Tim Thay mo kho...chuan bi cuop " & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 1,$pkho[1][0], $pkho[1][1]) ; click to thuong
		 EndIf
	  EndIf
	  ;cuop mo thuong
	  Local $flagcuop_mo_thuong = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_thuong, False)
	  If $flagcuop_mo_thuong == True Then
		 Local $Imagecuopmothuong = @ScriptDir & "\image\cuopmothuong.bmp"
		 Local $pthuong = _HandleImgSearch($Handle,$Imagecuopmothuong, 0, 0, -1, -1,105, 5);search mo thuong
		 If not @error Then
			$cuopmoflag = True
			writelog("Tim Thay mo thuong...chuan bi cuop " & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 1,$pthuong[1][0], $pthuong[1][1]) ; click to thuong
		 EndIf
	  EndIf
	  ;code cuop mo de
	  Local $flagcuop_mo_de = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_de, False)
	  If $flagcuop_mo_de == True Then
		 Local $Imagecuopmode = @ScriptDir & "\image\cuopmode.bmp"
		 Local $pde = _HandleImgSearch($Handle,$Imagecuopmode, 0, 0, -1, -1,105, 5);search mo de
		 If not @error Then
			$cuopmoflag = True
			writelog("Tim Thay mo de...chuan bi cuop " & _NowTime() & @CRLF) ; write console
			_ControlClickExactly($Title, "", "","", 2,$pde[1][0], $pde[1][1]) ; click to dễ
		 EndIf
	  EndIf
	  If $cuopmoflag == True Then
		  Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 778 766");click to tranh cuop
		 Sleep(2000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 778 600");click to "yeu cau tranh cuop"
		 Sleep(2000)
			$Imageyeucau = @ScriptDir & "\image\yeucautranhcuop.bmp"
			$p = _HandleImgSearch($Handle,$Imageyeucau, 0, 0, -1, -1,80, 10);search yeu cau tranh cuop
			If not @error Then ; chua cuop dc => close cua so
			   writelog("Tam thoi chua cuop mo nay dc " & _NowTime() & @CRLF) ; write console
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Else ;cuop duoc
			   writelog("battle " & _NowTime() & @CRLF) ; write console
			   Sleep(10000)
			EndIf
			$ImagePath = @ScriptDir & "\image\menu.bmp"
			$Result = _HandleImgWaitExist($Handle, $ImagePath,60, 0, 0, -1, -1,90, 2);search nut menu de ket thuc
	  Else
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	  EndIf
Sleep(1000)
EndFunc   ;==>GotoPB

