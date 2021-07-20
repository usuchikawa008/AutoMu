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
	 Sleep(200)
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
	  If $daomoflag == True Then ; CODE DAO MO
		 $Image2landao = @ScriptDir & "\image\con2landao.bmp"
		 $p = _HandleImgWaitExist($Handle,$Image2landao, 1,0, 0, -1, -1,100, 2);search 2 lan dao
		 If not @error Then ; con 2 lan dao
			writelog("Con 2 luot " & _NowTime() & @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1212 780");click bat dau
			Sleep(1000)
			$Imagetieuhao = @ScriptDir & "\image\tieuhao.bmp"
			_HandleImgWaitExist($Handle,$Imagetieuhao,2,445, 450, -1, -1,90, 2);search image tieu hao
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
			For $i = 0 to 7 Step + 1
			   Sleep(1000)
			   $Imagetieuhao = @ScriptDir & "\image\tieuhao.bmp"
		       _HandleImgWaitExist($Handle,$Imagetieuhao, 1,445, 450, -1, -1,90, 2);search image tieu hao
			   If not @error Then ;neu het luot tang cap quoc
				  writelog("Het luot nang cap quoc " & _NowTime() & @CRLF) ; write console
				  ExitLoop
			   Else
				  Sleep(1000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 719 746");click to tang cap quoc
			   EndIf
			Next
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
    Global $cuopmoflag = False
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
	  Local $Imagehetmocuop = @ScriptDir & "\image\hetmocuop.bmp"
	  Local $rs_hetmo = _HandleImgSearch($Handle,$Imagehetmocuop, 0, 0, -1, -1,80, 5);search het mo
	  If not @error Then
		 writelog("Hết mỏ để cướp" & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
		 Return
	  EndIf

	  _checkMoCuop($Handle)
	  If $cuopmoflag == True Then
		  Sleep(1000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 778 766");click to tranh cuop
		 Sleep(2000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 778 600");click to "yeu cau tranh cuop"
		 Sleep(2000)
			Local $Imageyeucau = @ScriptDir & "\image\yeucautranhcuop.bmp"
			Local $p = _HandleImgSearch($Handle,$Imageyeucau, 0, 0, -1, -1,85, 10);search yeu cau tranh cuop
			If not @error Then ; chua cuop dc => close cua so
			   writelog("Tam thoi chua cuop mo nay dc " & _NowTime() & @CRLF) ; write console
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Else ;cuop duoc
			   writelog("battle " & _NowTime() & @CRLF) ; write console
			   Sleep(10000)
			EndIf
			Local $ImagePath = @ScriptDir & "\image\menu.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,60, 660,30, 60, 50,$x_toler_menu, 2);search nut menu de ket thuc
	  Else
		 writelog("Không tìm thấy mỏ thích hợp" & _NowTime() & @CRLF) ; write console
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
	  EndIf
Sleep(1000)
EndFunc   ;==>GotoPB

Func _checkMoCuop($Handle)
   #Region check mo
   ;load config
   Local $flagcuop_mo_kho = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_kho, False)
   Local $flagcuop_mo_thuong = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_thuong, True)
   Local $flagcuop_mo_de = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_de, False)
   Local $flagcuop_mo_trang = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_trang, True)
   Local $flagcuop_mo_xanh = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_xanh, True)
   Local $flagcuop_mo_tim = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_tim, True)
   Local $flagcuop_mo_do = IniRead($pathconfig&$Title&".config", $config, $cuop_mo_do, True)
   ;cuop mo kho
   If $flagcuop_mo_kho == True Then
	  Local $Imagecuopmokho = @ScriptDir & "\image\cuopmokho.bmp"
	  Local $pkho = _HandleImgSearch($Handle,$Imagecuopmokho, 0, 0, -1, -1,100, 5);search mo kho
	  If not @error Then
		 _ControlClickExactly($Title, "", "","", 1,$pkho[1][0], $pkho[1][1]) ; click to kho
		 Sleep(200)
		 Local $Imagecuoctim = @ScriptDir & "\image\cuoctim.bmp"
		 Local $rs_cuoctim = _HandleImgSearch($Handle,$Imagecuoctim, $pkho[1][0]-150, $pkho[1][1]-3, 60, 30,100, 5);search image quoc tim
		 If not @error And $flagcuop_mo_tim == True Then ; neu thay image quoc tim va flag tim dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ khó - cuốc tím, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuocxanh = @ScriptDir & "\image\cuocxanh.bmp"
		 Local $rs_cuocxanh = _HandleImgSearch($Handle,$Imagecuocxanh, $pkho[1][0]-160, $pkho[1][1]-3, 60, 30,80, 5);search image quoc xanh
		 If not @error And $flagcuop_mo_xanh == True Then ; neu thay image quoc xanh va flag xanh dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ khó - cuốc xanh, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuoctrang = @ScriptDir & "\image\cuoctrang.bmp"
		 Local $rs_cuoctrang = _HandleImgSearch($Handle,$Imagecuoctrang, $pkho[1][0]-160, $pkho[1][1]-3, 60, 30,80, 5);search image quoc trang
		 If not @error And $flagcuop_mo_trang == True Then ; neu thay image quoc trang va flag trang dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ khó - cuốc trắng, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
	  EndIf
   EndIf
   ;cuop mo thuong
   If $flagcuop_mo_thuong == True Then
	  Local $x_toler_cuopmothuong = 93
	  If $isLDPlayer == True Then
		 $x_toler_cuopmothuong = 112
	  EndIf
	  Local $Imagecuopmothuong = @ScriptDir & "\image\cuopmothuong.bmp"
	  Local $pthuong = _HandleImgSearch($Handle,$Imagecuopmothuong, 0, 0, -1, -1,$x_toler_cuopmothuong, 5);search mo thuong
	  If not @error Then
		 _ControlClickExactly($Title, "", "","", 1,$pthuong[1][0], $pthuong[1][1]) ; click to thuong
		 Sleep(200)
		 Local $Imagecuoctim = @ScriptDir & "\image\cuoctim.bmp"
		 Local $rs_cuoctim = _HandleImgSearch($Handle,$Imagecuoctim, $pthuong[1][0]-155, $pthuong[1][1]-4, 65, 30,100, 5);search image quoc tim
		 If not @error And $flagcuop_mo_tim == True Then ; neu thay image quoc tim va flag tim dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ thường - cuốc tím, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuocxanh = @ScriptDir & "\image\cuocxanh.bmp"
		 Local $rs_cuocxanh = _HandleImgSearch($Handle,$Imagecuocxanh, $pthuong[1][0]-165, $pthuong[1][1]-4, 65, 30,80, 5);search image quoc xanh
		 If not @error And $flagcuop_mo_xanh == True Then ; neu thay image quoc xanh va flag xanh dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ thường - cuốc xanh, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuoctrang = @ScriptDir & "\image\cuoctrang.bmp"
		 Local $rs_cuoctrang = _HandleImgSearch($Handle,$Imagecuoctrang, $pthuong[1][0]-165, $pthuong[1][1]-4, 65, 30,80, 5);search image quoc trang
		 If not @error And $flagcuop_mo_trang == True Then ; neu thay image quoc trang va flag trang dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ thường - cuốc trắng, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
	  EndIf
   EndIf
   ;code cuop mo de
   If $flagcuop_mo_de == True Then
	  Local $x_cuopmode = 102
	  If $isLDPlayer == True Then
		 $x_cuopmode = 106
	  EndIf
	  Local $Imagecuopmode = @ScriptDir & "\image\cuopmode.bmp"
	  Local $pde = _HandleImgSearch($Handle,$Imagecuopmode, 0, 0, -1, -1,$x_cuopmode, 5);search mo de
	  If not @error Then
		 _ControlClickExactly($Title, "", "","", 1,$pde[1][0], $pde[1][1]) ; click to de
		 Sleep(200)
		 Local $Imagecuoctim = @ScriptDir & "\image\cuoctim.bmp"
		 Local $rs_cuoctim = _HandleImgSearch($Handle,$Imagecuoctim, $pde[1][0]-155, $pde[1][1]-4, 65, 30,100, 5);search image quoc tim
		 If not @error And $flagcuop_mo_tim == True Then ; neu thay image quoc tim va flag tim dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ dễ - cuốc tím, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuocxanh = @ScriptDir & "\image\cuocxanh.bmp"
		 Local $rs_cuocxanh = _HandleImgSearch($Handle,$Imagecuocxanh, $pde[1][0]-165, $pde[1][1]-4, 60, 30,80, 5);search image quoc xanh
		 If not @error And $flagcuop_mo_xanh == True Then ; neu thay image quoc xanh va flag xanh dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ dễ - cuốc xanh, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
		 Local $Imagecuoctrang = @ScriptDir & "\image\cuoctrang.bmp"
		 Local $rs_cuoctrang = _HandleImgSearch($Handle,$Imagecuoctrang, $pde[1][0]-165, $pde[1][1]-4, 60, 30,80, 5);search image quoc trang
		 If not @error And $flagcuop_mo_trang == True Then ; neu thay image quoc trang va flag trang dc bat
			$cuopmoflag = True
			writelog("Tìm thấy mỏ dễ - cuốc trắng, chuẩn bị cướp " & _NowTime() & @CRLF) ; write console
			Return
		 EndIf
	  EndIf
   EndIf
   #EndRegion chat mo end
EndFunc   ;==>doi tang