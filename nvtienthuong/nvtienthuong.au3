Func GotoNVTienThuong($Title,$emuport,$Handle,$pos)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(500)
		 Local $ImagePathHet = @ScriptDir & "\image\tienthuonghetluot.bmp"
		 Local $ImagePathCon = @ScriptDir & "\image\tienthuongconluot1.bmp"
		 Local $p = _searchNVAdvance($Handle,$ImagePathHet,$ImagePathCon,90,115);search nv tien thuong
		 If @error Then
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
	  writelog("NV tien thuong con luot " & _NowTime() & @CRLF) ; write console
	  ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+20) ; click toi
	  ;cho menu xuat hien
	  Local $Imagemenu = @ScriptDir & "\image\menutienthuong.bmp"
	  Local $Result = _HandleImgWaitExist($Handle, $Imagemenu,20, 0, 0, -1, -1,90, 2); search menu trong 20s
	  If @error Then ; ko tim thay thi stop nv nay
		 Return
	  EndIf
		 writelog("Check nv cu da hoan thanh hay chua " & _NowTime() & @CRLF) ; write console
		 Local $ImagePath = @ScriptDir & "\image\dahoanthanhnvtienthuong.bmp"
		 Local $Result = _HandleImgWaitExist($Handle, $ImagePath,3, 290, 200, 250, 50,120, 10); search icon finish or not
		 If @error Then
		 Else
			Local $Imagecheck = @ScriptDir & "\image\nvmoihaycu.bmp"
			Local $Result2 = _HandleImgSearch($Handle,$Imagecheck, 0, 0, -1, -1,50, 10);search nv cu hay moi
			If not @error Then ;neu tim thay la nv cu
			   writelog("Chua Finish..lam tiep nv cu " & _NowTime() & @CRLF) ; write console
			Else
			   writelog("Finished " & _NowTime() & @CRLF) ; write console
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1184 255");click Nhan/Toi Nhiem Vu
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			Return 0
			EndIf
		 EndIf
	     ;cho menu nv tien thuong xuat hien
		 Sleep(1000)
		 writelog("Cho menu nv tien thuong xuat hien " & _NowTime() & @CRLF) ; write console
		 Local $ImagePath = @ScriptDir & "\image\nhannvtienthuong.bmp"
		 Local $p = _HandleImgWaitExist($Handle, $ImagePath,30, 0, 0, -1, -1,100, 10); search nhan nv tien thuong
		 If @error Then
			Return
		 Else
			Local $second = 2
			Sleep(1500)
			writelog("NV TIEN THUONG BAT DAU " & _NowTime() & @CRLF) ; write console
			Local $Tor = 110
			$ImagePath = @ScriptDir & "\image\v1tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 290, 200, 250, 50,140, 2);search v1
			If not @error Then
			   $second  = 10
			EndIf
			$ImagePath = @ScriptDir & "\image\v2tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v2
			If not @error Then
			   $second  = 9
			EndIf
			$ImagePath = @ScriptDir & "\image\v3tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v3
			If not @error Then
			   $second  = 8
			EndIf
			$ImagePath = @ScriptDir & "\image\v4tienthuong.bmp"
			$Result = _HandleImgSearch($Handle,$ImagePath, 290, 200, 250, 50,140, 1000);search v4
			If not @error Then
			   $second  = 7
			EndIf
			$ImagePath = @ScriptDir & "\image\v5tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v5
			If not @error Then
			   $second  = 6
			EndIf
			$ImagePath = @ScriptDir & "\image\v6tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v6
			If not @error Then
			   $second  = 5
			EndIf
			$ImagePath = @ScriptDir & "\image\v7tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v7
			If not @error Then
			   $second  = 4
			EndIf
			$ImagePath = @ScriptDir & "\image\v8tienthuong.bmp"
			$p = _HandleImgSearch($Handle,$ImagePath, 0, 0, -1, -1,$Tor, 10);search v8
			If not @error Then
			   $second  = 3
			EndIf
			writelog("Cho "&$second &" phut"& @CRLF) ; write console
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1100 615");click Nhan/Toi Nhiem Vu
			Sleep($second*60000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 635 539");click to space to sure stop nv
			Sleep(1000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 260");click check nv done or not
			Local $ImagePath = @ScriptDir & "\image\dahoanthanhnvtienthuong.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 290, 200, 250, 50,130, 10); search nv tien thuong hoan thanhe
			If Not @error Then
			   writelog("Nhan Thuong NV Tien Thuong" & _NowTime() & @CRLF) ; write console
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 250");click Nhan/Toi Nhiem Vu
			   Sleep(1000)
			   _closeSimple($Handle);tat cua so
			EndIf
		 EndIf

EndFunc   ;==>Goto Tien Thuong




Func _GotoTrainQuai($Title,$emuport,$Handle,$pos)
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(1000)
		 $Imagetreomayconluot = @ScriptDir & "\image\treomay.bmp"
		 $Imagetreomayhetluot = @ScriptDir & "\image\treomayhetluot.bmp"
		 $p = _searchNVAdvance($Handle, $Imagetreomayhetluot,$Imagetreomayconluot,95,115) ; search NV treo may
		 If @error Then
			Return SetError(3)
		 EndIf
		 If $p == 2 Then ; ko tim thay hinh nao het
			Return
		 EndIf
		 _TreoMay($Handle,$p)
	   Sleep(2000)
	EndFunc   ;==>Goto Treo Quai

Func _TreoMay($Handle,$p)
	  writelog("Treo may " & _NowTime() & @CRLF) ; write console
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi
	  ;loop check NV finish or not
	  Sleep(30000)
	  $i = 1
	  While $i < 25
		 $i = $i + 1
		 Sleep(15000)
		 $Imagemenu = @ScriptDir & "\image\menu.bmp"
		 $Result = _HandleImgWaitExist($Handle, $Imagemenu,1, 660,30, 60, 50,94, 2);search nut menu
		 If not @error Then ; neu thay  menu thi click vao
			writelog("Check Lan " &$i & @CRLF) ; write console
			ControlClick($Title, "", "","", 1,$Result[1][0]+660, $Result[1][1]+30) ; click menu
			Local $Imagesoinoi = @ScriptDir & "\image\laysoinoi.bmp"
			Local $Rs = _HandleImgWaitExist($Handle, $Imagesoinoi,2, 0, 0, -1, -1,88, 2);search nut Laysoi noi trongh 2s
		    If not @error Then ; neu thay  SOI NOI thi click
			   writelog("Treo quai xong " & _NowTime() & @CRLF) ; write console
			   Return
			Else
			   Sleep(1000)
			   _closeSimple($Handle);tat cua so
			   ContinueLoop
			EndIf
		 Else
			Sleep(1000)
;~ 			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			_closeSimple($Handle);tat cua so
			ContinueLoop
		 EndIf

	  WEnd
	EndFunc   ;==>Goto Treo Quai

Func _GotoNVGuide($Title,$emuport,$Handle,$pos)
	  $lastone = False
	  If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	  EndIf
	  Sleep(1000)
	  $Imageconluotnvguide = @ScriptDir & "\image\conluotnvguide.bmp"
	  $Imagehetluotnvguide = @ScriptDir & "\image\hetnhiemvuguildicon.bmp"
	  $p = _searchNVAdvance($Handle, $Imagehetluotnvguide,$Imageconluotnvguide,95,115,7) ; search NV treo may
	  If @error Then ; thay icon het luot
		 Return SetError(3)
	  EndIf
	  If $p == 2 Then ; ko tim thay hinh nao het
		 Return
	  EndIf
	  writelog("NV guild con luot" & _NowTime() & @CRLF) ; write console
	  Sleep(500)
	  Opt("WinTitleMatchMode", 3)
	  ControlClick($Title, "", "","", 2,$p[1][0]+275, $p[1][1]+20) ; click toi
	  Sleep(500)
	  $Imagelinhthuongstart = @ScriptDir & "\image\linhthuong.bmp"
	  $linhthuong = _HandleImgSearch($Handle, $Imagelinhthuongstart, 0, 0, -1, -1,85, 2);search button linh thuong
	  If Not @error Then
		 writelog("Thay buttion linh thuong" & _NowTime() & @CRLF) ; write console
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$linhthuong[1][0], $linhthuong[1][1]) ; click linh thuong
		 Sleep(2000)
		 ;lay nv moi
		 $Imagelaynvguide = @ScriptDir & "\image\laynvguild.bmp"
		 $nhannv = _HandleImgWaitExist($Handle, $Imagelaynvguide,2, 0, 0, -1, -1,80, 2);search button lay nv guild
		 If not @error Then
		 Else
			Sleep(10000); cho 10s
			Return
		 EndIf
	  EndIf
	  ;lay nv moi
	  $Imagelaynvguide = @ScriptDir & "\image\laynvguild.bmp"
	  $nhannv = _HandleImgWaitExist($Handle, $Imagelaynvguide,1, 0, 0, -1, -1,80, 2);search button lay nv guild
	  If not @error Then ;bat dau nv
		 While 1 ;loop cho toi khi het nv guild
			writelog("Start NV guild" & _NowTime() & @CRLF) ; write console
			Local $ketqua = _reloadNV($Title,$Handle)
			If @error Then;neu thay nv rank S stop nv guild
			   Return SetError(3)
			EndIf
			If $ketqua == "Exit" then Return ; thoat NV guild
			;check co fai nv cuoi cung hay ko
			$Imagenvcuoi = @ScriptDir & "\image\nvguildcuoicung.bmp"
			$last = _HandleImgSearch($Handle, $Imagenvcuoi, 0, 0, -1, -1,100, 2);search nv cuoi cung
			If not @error Then;neu day la nv cuoi
			   writelog("NV cuoi" & _NowTime() & @CRLF) ; write console
			   $lastone = True
			EndIf
			Sleep(500)
			Opt("WinTitleMatchMode", 3)
			ControlClick($Title, "", "","", 1,$nhannv[1][0], $nhannv[1][1]) ; click lay nv
			Sleep(40000) ;cho lam xong nv khoang 20s
			$count = 0
			While 1 ;loop click
			   $count = $count + 1
			   If $count > 15 Then
				  Return
			   EndIf
			   Sleep(2000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 260");click check nv done or not
			   Local $ImagePath = @ScriptDir & "\image\dahoanthanhnvtienthuong.bmp"
			   Local $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 290, 200, 250, 50,130, 10); search nv tien thuong hoan thanhe
			   If Not @error Then
				  writelog("Thay NV Tien Thuong" & _NowTime() & @CRLF) ; write console
				  Sleep(1000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 250");click Nhan/Toi Nhiem Vu
				  Sleep(1000)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
				  ContinueLoop
			   EndIf
			   Local $Imagelinhthuong = @ScriptDir & "\image\linhthuong.bmp"
			   $p = _HandleImgSearch($Handle, $Imagelinhthuong, 0, 0, -1, -1,80, 2);search button linh thuong
			   If Not @error Then
				  writelog("Thay buttion linh thuong" & _NowTime() & @CRLF) ; write console
				  Opt("WinTitleMatchMode", 3)
				  ControlClick($Title, "", "","", 1,$p[1][0], $p[1][1]) ; click
				  If $lastone Then
					 Return SetError(3)
				  Else
					 ExitLoop
				  EndIf
			   EndIf
			   $Imagelaynvguide = @ScriptDir & "\image\laynvguild.bmp"
			   $p1 = _HandleImgSearch($Handle, $Imagelaynvguide, 0, 0, -1, -1,80, 2);search button lay nv guild
			   If Not @error Then
				  writelog("Thay buttion lay nv guild" & _NowTime() & @CRLF) ; write console
				  ExitLoop
			   EndIf
			   _close($Handle) ;close cua so
			WEnd
		 WEnd
		 Return
	  EndIf
	  ;Lam tiep NV cu~
	  $Imagetoingaynvguild = @ScriptDir & "\image\toingaynvguild.bmp"
	  $nhannv = _HandleImgWaitExist($Handle, $Imagetoingaynvguild,1, 0, 0, -1, -1,80, 2);search button toi ngay nv guild
	  If not @error Then ;lam not nv guild
		 writelog("Lam Tiep NV guild" & _NowTime() & @CRLF) ; write console
		 ;check nv S
		 Sleep(1500)
		 $ImagenvS = @ScriptDir & "\image\nvS.bmp"
		 $ps = _HandleImgWaitExist($Handle, $ImagenvS,2, 0, 0, -1, -1,90, 2);search nv rank S
		 If not @error Then ; tim thay nv rank S
			   Local $flag_nv_rankS = IniRead($pathconfig&$Title&".config", $config, $nvguildRankS, False)
			   If $flag_nv_rankS == True Then ; cho phep lam NV rank S
				  writelog("Nhan NV Rank S"& @CRLF) ; write console
				  Local $waitTime = IniRead($pathconfig&$Title&".config", $config, $timewaitNvS, 60)
				  if $waitTime < 5 Then
					 $waitTime = 30
				  EndIf
				  Sleep(1500)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1300 800");click toi ngay/lay nv
				  Sleep(4000)
				  Local $ImagevaopbrankS = @ScriptDir & "\image\vaopbrankS.bmp"
				  Local $rs_vaopbRankS = _HandleImgWaitExist($Handle, $ImagevaopbrankS,10, 0, 0, -1, -1,80, 2);search icon vao pho ban
				  If not @error Then ; thay icon vao pb ban
					 Opt("WinTitleMatchMode", 3)
					 ControlClick($Title, "", "","", 1,$rs_vaopbRankS[1][0]+30, $rs_vaopbRankS[1][1]+60) ; click cau cuu
				  Else
					 Return "Exit"
				  EndIf
				  writelog("Cho ho tro trong vong "&$waitTime &" giay"& @CRLF) ; write console
				  Local $Imagematuongtext = @ScriptDir & "\image\matuongthaophat.bmp"
		          Local $rs = _HandleImgWaitExist($Handle, $Imagematuongtext,$waitTime, 0, 0, -1, -1,70, 2);search text ma tuong
				  If not @error Then ; da du nguoi support -> vo nv
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600");click Xac Nhan vo PB
					 Local $ImagevaopbrankS = @ScriptDir & "\image\vaopbrankS.bmp"
					 Local $rs_vaopbRankS = _HandleImgWaitExist($Handle, $ImagevaopbrankS,4, 0, 0, -1, -1,70, 2);search icon vao pho ban
					 If not @error Then ; thay icon vao phu ban
						Sleep(1000)
						Opt("WinTitleMatchMode", 3)
						ControlClick($Title, "", "","", 1,$rs_vaopbRankS[1][0]+30, $rs_vaopbRankS[1][1]) ; click
						Sleep(4000)  ; cho 4s
						Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
						Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,4, 0, 0, -1, -1,80, 2);search icon thoat pho ban
						If not @error Then ; da vo pho ban
						   Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
						   Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,150, 660,30, 60, 50,85, 2);search nut menu trong 120 de ket thuc
						   _outParty()
						EndIf
						Return "Exit"
					 Else
						Return "Exit"
					 EndIf
				  Else ; het thoi gian cho bo qua NV khi khac lam
					 writelog("Khong co ai ho tro trong thoi gian nay"& @CRLF) ; write console
					 _outParty()
					 Return "Exit"
				  EndIf
			   Else
				  writelog("Thay NV rank S-- Stop" & _NowTime() & @CRLF) ; write console
				  Return SetError(3)
			   EndIf
			EndIf

		 Sleep(500)
		 Opt("WinTitleMatchMode", 3)
		 ControlClick($Title, "", "","", 1,$nhannv[1][0], $nhannv[1][1]) ; click toi nv guild
		 Sleep(40000) ;cho lam xong nv khoang 30s
		 $count = 0
		 While 1 ;loop click
			$count = $count + 1
			If $count > 15 Then
			   Return
			EndIf
			Sleep(2000)
			_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1400 260");click check nv done or not
			Local $ImagePath = @ScriptDir & "\image\dahoanthanhnvtienthuong.bmp"
			Local $Result = _HandleImgWaitExist($Handle, $ImagePath,2, 290, 200, 250, 50,130, 10); search nv tien thuong hoan thanhe
			If Not @error Then
			   writelog("Thay NV Tien Thuong" & _NowTime() & @CRLF) ; write console
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 250");click Nhan/Toi Nhiem Vu
			   Sleep(1000)
			   _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input keyevent 111"); an esc
			   ContinueLoop
			EndIf
			$Imagelinhthuong = @ScriptDir & "\image\linhthuong.bmp"
			$p = _HandleImgSearch($Handle, $Imagelinhthuong, 0, 0, -1, -1,80, 2);search button linh thuong
			If Not @error Then
			   writelog("Thay buttion linh thuong" & _NowTime() & @CRLF) ; write console
			   Opt("WinTitleMatchMode", 3)
			   ControlClick($Title, "", "","", 1,$p[1][0], $p[1][1]) ; click
			   Return
			EndIf
			$Imagelaynvguide = @ScriptDir & "\image\laynvguild.bmp"
			$p1 = _HandleImgSearch($Handle, $Imagelaynvguide, 0, 0, -1, -1,80, 2);search button lay nv guild
			If Not @error Then
			   Return ;con nv guild
			EndIf
			_close($Handle) ;close cua so
		 WEnd
	  EndIf
	  Sleep(2000)
	EndFunc   ;==>Goto NV GUIDE
Func _reloadNV($Title,$Handle);case nhan nv moi
		 While 1
			;check nv S
			Sleep(2500)
			Local $ImagenvS = @ScriptDir & "\image\nvS.bmp"
		    Local $ps = _HandleImgWaitExist($Handle, $ImagenvS,2, 0, 0, -1, -1,90, 2);search nv rank S
			If not @error Then ; tim thay nv rank S
			   Local $flag_nv_rankS = IniRead($pathconfig&$Title&".config", $config, $nvguildRankS, False)
			   If $flag_nv_rankS == True Then ; cho phep lam NV rank S
				  writelog("Nhan NV Rank S"& @CRLF) ; write console
				  Local $waitTime = IniRead($pathconfig&$Title&".config", $config, $timewaitNvS, 60)
				  if $waitTime < 5 Then
					 $waitTime = 30
				  EndIf
				  Sleep(1500)
				  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1300 800");click toi ngay/lay nv
				  Sleep(4000)
				  Local $ImagevaopbrankS = @ScriptDir & "\image\vaopbrankS.bmp"
				  Local $rs_vaopbRankS = _HandleImgWaitExist($Handle, $ImagevaopbrankS,10, 0, 0, -1, -1,80, 2);search icon vao pho ban
				  If not @error Then ; thay icon vao pb ban
					 Opt("WinTitleMatchMode", 3)
					 ControlClick($Title, "", "","", 1,$rs_vaopbRankS[1][0]+30, $rs_vaopbRankS[1][1]+60) ; click cau cuu
				  Else
					 Return "Exit"
				  EndIf
				  writelog("Cho ho tro trong vong "&$waitTime &" giay"& @CRLF) ; write console
				  Local $Imagematuongtext = @ScriptDir & "\image\matuongthaophat.bmp"
		          Local $rs = _HandleImgWaitExist($Handle, $Imagematuongtext,$waitTime, 0, 0, -1, -1,70, 2);search text ma tuong
				  If not @error Then ; da du nguoi support -> vo nv
					 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1000 600");click Xac Nhan vo PB
					 Local $ImagevaopbrankS = @ScriptDir & "\image\vaopbrankS.bmp"
					 Local $rs_vaopbRankS = _HandleImgWaitExist($Handle, $ImagevaopbrankS,4, 0, 0, -1, -1,70, 2);search icon vao pho ban
					 If not @error Then ; thay icon vao phu ban
						Sleep(1000)
						Opt("WinTitleMatchMode", 3)
						ControlClick($Title, "", "","", 1,$rs_vaopbRankS[1][0]+30, $rs_vaopbRankS[1][1]) ; click
						Sleep(4000)  ; cho 4s
						Local $Imagethoatpb = @ScriptDir & "\image\thoatpb.bmp"
						Local $rsthoatpb = _HandleImgWaitExist($Handle, $Imagethoatpb,4, 0, 0, -1, -1,80, 2);search icon thoat pho ban
						If not @error Then ; da vo pho ban
						   Local $ImageMenu = @ScriptDir & "\image\menu.bmp"
						   Local $Result = _HandleImgWaitExist($Handle, $ImageMenu,150, 660,30, 60, 50,85, 2);search nut menu trong 120 de ket thuc
						   _outParty()
						EndIf
						Return "Exit"
					 Else
						Return "Exit"
					 EndIf
				  Else ; het thoi gian cho bo qua NV khi khac lam
					 writelog("Khong co ai ho tro trong thoi gian nay"& @CRLF) ; write console
					 Return "Exit"
				  EndIf
			   Else
				  writelog("Thay NV rank S-- Stop" & _NowTime() & @CRLF) ; write console
				  Return SetError(3)
			   EndIf
		 EndIf

			;NV rank A
		    Local $ImagenvA = @ScriptDir & "\image\nvA.bmp"
		    Local $p = _HandleImgWaitExist($Handle, $ImagenvA,1, 0, 0, -1, -1,80, 2);search nv rank A
			If not @error Then ; tim thay nv rank A
			   writelog("Thay NV rank A-- Start now" & _NowTime() & @CRLF) ; write console
			   ExitLoop
			Else; ko tim thay bam' load
			     writelog("Ko thay NV rank A-- can reload" & _NowTime() & @CRLF) ; write console
			     $Imagelammoifree = @ScriptDir & "\image\lammoifree.bmp"
			     $p = _HandleImgWaitExist($Handle, $Imagelammoifree,1, 0, 0, -1, -1,100, 2);search lam moi trong 2s
				 If not @error Then ; tim thay nut lam moi free
					Sleep(500)
					Opt("WinTitleMatchMode", 3)
					ControlClick($Title, "", "","", 1,$p[1][0]+5, $p[1][1]+5) ; click lam moi
				 Else
					writelog("Het luot reload" & _NowTime() & @CRLF) ; write console
					ExitLoop
				 EndIf
			EndIf
		 WEnd
EndFunc   ;==>Goto NV GUIDE





