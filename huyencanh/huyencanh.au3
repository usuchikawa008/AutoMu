Func GotoPBHuyenCanh($Title,$emuport,$Handle)
    Local $confirmPass = false
	$Imagecovu = @ScriptDir & "\image\covuzenhuyencanh.bmp"
	$Imagefinish = @ScriptDir & "\image\roiphubanhuyencanh.bmp"
	If BitAND(WinGetState($Title), 16) Then
		MsgBox(0,"Message",WinGetState($Title))
		Local $myLastWin = WinGetTitle(WinActive("[ACTIVE]"))
		WinActivate($Title)
		WinActivate($myLastWin)
	 EndIf
	 Sleep(300)
	 ;check het luot hay chua
	 $Imagehetluot = @ScriptDir & "\image\huyencanhhetluot.bmp"
	$p = _HandleImgSearch($Handle, $Imagehetluot, 0, 0, -1, -1,115, 10);search icon het luot huyen canh
	If not @error Then ;neu tim thay nghia la het luot
		Return SetError(3)
    EndIf
    $ImagePath = @ScriptDir & "\image\huyencanhconluot.bmp"
	$p = _HandleImgSearch($Handle, $ImagePath, 0, 0, -1, -1,105, 10);search pb huyen canh con hay ko
	If @error Then
		Return
     EndIf
     writelog("Con luot pb huyen canh...."& @CRLF) ; write console
	 ControlClick($Title, "", "","", 1,$p[1][0]+275, $p[1][1]+25) ; click toi pb
	 Sleep(2000)
	 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1200 800");click Khieu chien
	 Sleep(1000)
	 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 600 600");click kien tri vao neu co
	 Sleep(8000)
		 _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1160 50");click Co vu
		 $confirmPass = True
	     For $i = 0 to 5 Step + 1
		 Sleep(1000)
	     _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 549 535");click Co vu ZEN 5 lan
	     Next
	  _ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1127 224");click close co vu

	 if $confirmPass Then ; xac nhan da vo pho ban
		writelog("cho 180s roi click giam toc...." & _NowTime() & @CRLF) ; write console
		Sleep(180000);cho 180s roi click giam toc
		_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 1080 50"); click giam toc menu
		Sleep(1000)
		_ADB_Command("nox_adb.exe -s 127.0.0.1:"&$emuport&" shell input tap 900 550"); click giam toc
		writelog("cho pb huyen canh ket thuc" & _NowTime() & @CRLF) ; write console
	    $ImagePath = @ScriptDir & "\image\menu.bmp"
	    $Result = _HandleImgWaitExist($Handle, $ImagePath,260, 660,30, 60, 50,85, 2);search nut menu
	  EndIf
EndFunc   ;==>GotoPB

