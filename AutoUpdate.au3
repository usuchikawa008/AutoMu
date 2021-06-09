#include <Math.au3>
#include <_Zip.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
$_DownloadPercent=0
$TitleAuto = "Auto Update"
Local $_Gui = GUICreate($TitleAuto, 235, 80)
$_ProgressBar = GUICtrlCreateProgress ( 5, 25, 200, 23 )
$_Label = GUICtrlCreateLabel ($_DownloadPercent & ' %', 210, 30, 40,20 )
GUISetState ( @SW_SHOW )
$_FinalUrl = 'https://github.com/usuchikawa008/AutoMuVTD/archive/refs/heads/master.zip'
Global $_DownLoadPath = @scriptDir & "\download"
DirCreate($_DownLoadPath)
Global $_TempPath = @scriptDir & "\download\AutoUpdate.zip"
$OldName = "AutoMuVTD-master"
$NewName = "AutoMuVTD"
$_FileSize = InetGetSize ( $_FinalUrl )
$_Download = InetGet ( $_FinalUrl, $_TempPath, 1, 1 )

;~ Global $ParentDir = StringLeft(@scriptDir,StringInStr(@scriptDir,"\",0,-1)-1)
;~ Msgbox(0,"", $ParentDir )
Local $_InfoData
Do
     Sleep ( 500 )
    $_InfoData = InetGetInfo ( $_Download )
    If Not @error Then
        $_InetGet = $_InfoData[0]
        $_DownloadPercent = Round ( ( 100 * $_InetGet ) / $_FileSize )
        $_DownloadPercent = _Min ( _Max ( 1, $_DownloadPercent ), 99 )
        GUICtrlSetData ( $_ProgressBar, $_DownloadPercent )
        GUICtrlSetData ( $_Label, $_DownloadPercent & ' %')
    EndIf

Until $_InfoData[2] = True
GUICtrlCreateLabel ( 'Download successfull !', 5, 52, 200, 20 )
_Zip_UnzipAll($_TempPath,$_DownLoadPath) ; giai nen
DirMove($_DownLoadPath & "\"& $OldName, $_DownLoadPath & "\"& $NewName) ; doi ten
;copy
DirCopy($_DownLoadPath & "\"& $NewName, @scriptDir, $FC_OVERWRITE)
DirRemove($_DownLoadPath,$DIR_REMOVE)
Sleep ( 3000 )
Exit 0