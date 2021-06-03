;~ ********************************************************************
;~  Author: Skysnake
;~
;~  Title:  Demo various Child Gui options
;~  Updated: 2019.01.03
;~
;~  Function:   A demo script, demonstrates various style & Extended
;~              style options for Child GUIs
;~  Comments, ideas and suggestions very welcome :)
;~
;~ ********************************************************************
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <MsgBoxConstants.au3>

ShowChildGuis()

Func ShowChildGuis()

    Local $guiParent = GUICreate("The Parent GUI", 1200, 700, 0, 0) ;WHLT

    $idFilemenu = GUICtrlCreateMenu(" &Menu")

    $ButtonCancel = GUICtrlCreateButton("&Close", 0, 0, 80, 25)
    GUICtrlSetTip($ButtonCancel, "Click to close all")

    $ButtonShowChildGui = GUICtrlCreateButton("&Show", 0, 25, 80, 25)
    GUICtrlSetTip($ButtonShowChildGui, "Click to show a child GUI")

;~  #comments-start --- Toggle this and same code below to show context menu for parent or child
    Local $idContextmenu = GUICtrlCreateContextMenu()

    Local $idNewsubmenu = GUICtrlCreateMenu("This is a Context Menu", $idContextmenu)
    Local $idNewsubmenuText = GUICtrlCreateMenuItem("text", $idNewsubmenu)

    Local $idContextButton = GUICtrlCreateButton("Context", 0, 50, 80, 25)
    GUICtrlSetTip($idContextButton, "Right Click to see Context Menu")
    Local $idButtoncontext = GUICtrlCreateContextMenu($idContextButton)
    Local $idMenuAbout = GUICtrlCreateMenuItem("This is a Context Menu", $idButtoncontext)

    Local $idMenuOpen = GUICtrlCreateMenuItem("Open", $idContextmenu)
    Local $idMenuSave = GUICtrlCreateMenuItem("Save", $idContextmenu)
    GUICtrlCreateMenuItem("", $idContextmenu) ; separator

    Local $idMenuInfo = GUICtrlCreateMenuItem("Info", $idContextmenu)
;~  #comments-end   --- Toggle this and same code below to show context menu for parent or child



    Local $DefaultChildGui = GUICreate("Default child gui", 300, 100, 300, 300, Default, Default, $guiParent) ;;;WHLT
    GUICtrlCreateLabel("Default attributes" & @CRLF & "Cannot move; cannot resize", 0, 0, 500, 200)
    GUICtrlSetBkColor(-1, $COLOR_aqua)

    $iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($DefaultChildGui), $GWL_STYLE)
    $iExStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($DefaultChildGui), $GWL_EXSTYLE)
    GUISetStyle(BitOR($iStyle, $WS_VISIBLE), $iExStyle, $DefaultChildGui)



    Local $gChildGuiwithMenu = GUICreate("A child gui with menu", 300, 100, 50, 100, $WS_VISIBLE, BitOR($WS_EX_WINDOWEDGE, $WS_EX_MDICHILD, $WS_THICKFRAME), $guiParent) ;;;WHLT
    GUICtrlCreateLabel("Menu" & @CRLF & "Can move; cannot resize", 0, 0, 500, 200)
    GUICtrlSetBkColor(-1, $COLOR_skyblue)

    $idFilemenu = GUICtrlCreateMenu(" &File ")
    Local $idFileMenuItem = GUICtrlCreateMenuItem("An item for the File menu ", $idFilemenu)
    GUICtrlCreateMenuItem("", $idFilemenu) ; create a separator line

    ; use same dimensions for GUI and its Label
    Local $iSizeWide = 300, $iSizeHi = 100
    GUICreate("A child gui", $iSizeWide, $iSizeHi, 100, 200, $WS_VISIBLE, BitOR($WS_EX_WINDOWEDGE, $WS_EX_TOPMOST, $WS_EX_MDICHILD, $WS_THICKFRAME), $guiParent) ;;;WHLT
    GUICtrlCreateLabel("Can move; cannot resize" & @CRLF & "Always on top", 0, 0, $iSizeWide, $iSizeHi)
    GUICtrlSetBkColor(-1, $COLOR_red)


    GUICreate("Child Gui Resizable", 300, 100, 200, 50, BitOR($WS_POPUP, $WS_SIZEBOX, $WS_CLIPCHILDREN, $WS_VISIBLE), $WS_EX_MDICHILD, $guiParent) ;;;WHLT
    GUICtrlCreateLabel("Popup Cannot move; can resize" & @CRLF & "Background", 0, 0, 500, 200) ; $WS_CHILD,
    GUICtrlSetBkColor(-1, $COLOR_blue)
    ; toggle the line below :)
    ;$idBackgroundmenu = GUICtrlCreateMenu(" &Menu ") ; give it a menu

    GUICreate("Child GUI, caption, resize", 300, 100, 300, 100, BitOR($WS_VISIBLE, $WS_POPUP, $WS_CAPTION), BitOR($WS_EX_TOOLWINDOW, $WS_EX_MDICHILD, $WS_EX_ACCEPTFILES), $guiParent)
    GUICtrlCreateLabel("Popup With Caption: Can move; cannot resize", 0, 0, 500, 200)
    GUICtrlSetBkColor(-1, $COLOR_yellow)

    GUICreate("Child GUI, abc", 300, 100, 400, 150, BitOR($WS_POPUP, $WS_VISIBLE, 0), $WS_EX_MDICHILD, $guiParent)
    GUICtrlCreateLabel("Popup Cannot move; cannot resize", 0, 0, 500, 200)
    GUICtrlSetBkColor(-1, $COLOR_green)


    ; Child GUI below has a control ............................. .............................................
    Local $gChildWithControls = GUICreate("Child GUI with Buttons", 400, 400, 500, 200, BitOR($WS_CAPTION, $WS_CHILD), -1, $guiParent)
    GUISetFont(14, $gChildWithControls)
    Local $cLabel = GUICtrlCreateLabel("Can move; cannot resize", 0, 0, 400, 50)
    GUICtrlSetBkColor($cLabel, $COLOR_white)

    Local $idChild_ButtonOkay = GUICtrlCreateButton("Okay", 0, 50, 80, 30)
    Local $idChild_ButtonHide = GUICtrlCreateButton("Hide", 0, 80, 80, 30)
    GUICtrlSetTip($idChild_ButtonHide, "Click to hide this child GUI")

;~  #comments-start --- Toggle this and same code below to show context menu for parent or child
;~  Local $idContextmenu = GUICtrlCreateContextMenu()

;~  Local $idNewsubmenu = GUICtrlCreateMenu("This is a Context Menu", $idContextmenu)
;~  Local $idNewsubmenuText = GUICtrlCreateMenuItem("text", $idNewsubmenu)

;~  Local $idContextButton = GUICtrlCreateButton("Context", 0, 110, 80, 30)
;~  GUICtrlSetTip($idContextButton, "Right Click to see Context Menu")
;~  Local $idButtoncontext = GUICtrlCreateContextMenu($idContextButton)
;~  Local $idMenuAbout = GUICtrlCreateMenuItem("This is a Context Menu", $idButtoncontext)

;~  Local $idMenuOpen = GUICtrlCreateMenuItem("Open", $idContextmenu)
;~  Local $idMenuSave = GUICtrlCreateMenuItem("Save", $idContextmenu)
;~  GUICtrlCreateMenuItem("", $idContextmenu) ; separator

;~  Local $idMenuInfo = GUICtrlCreateMenuItem("Info", $idContextmenu)

;~  #comments-end   --- Toggle this and same code below to show context menu for parent or child

    GUISetState(@SW_HIDE, $gChildWithControls)
    ;..........................................................................................................



    Local $gToolbar = GUICreate("A floating Tool Window", 300, 50, 100, 25, $WS_VISIBLE, $WS_EX_TOOLWINDOW, $guiParent)
    GUICtrlCreateLabel("A floating toolbar", 0, 0, 500, 200) ; this does not show :)
    GUICtrlSetBkColor(-1, $COLOR_lime)

;~  $iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($gToolbar), $GWL_STYLE)
;~  $iExStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($gToolbar), $GWL_EXSTYLE) ; BitOR($WS_EX_TOOLWINDOW, $WS_EX_MDICHILD)
;~  GUISetStyle(BitOR($iStyle, $WS_VISIBLE), $iExStyle, $gToolbar)

    $idToolmenu = GUICtrlCreateMenu(" &Tool ")
    Local $idToolMenuItem = GUICtrlCreateMenuItem("An item for the Tool menu ", $idToolmenu)
    Local $idToolMenuItemsecond = GUICtrlCreateMenuItem("A second item for the Tool menu ", $idToolmenu)
    GUICtrlCreateMenuItem("", $idToolmenu) ; create a separator line

    $idPrintmenu = GUICtrlCreateMenu(" &Print ")
    Local $idToolMenuItemPrint = GUICtrlCreateMenuItem("A Print item for the Toolbar print menu ", $idPrintmenu)
    GUICtrlCreateMenuItem("", $idPrintmenu) ; create a separator line


    #Region --- After GUI BEFORE loop starts
    GUISetState(@SW_SHOW, $guiParent)
    #EndRegion --- After GUI BEFORE loop starts


    While 1
        ;Local $nMsg = GUIGetMsg()
        Switch GUIGetMsg() ; $nMsg
            Case $GUI_EVENT_CLOSE, $ButtonCancel
                GUIDelete($guiParent)
                ExitLoop
            Case $idContextButton
                MsgBox($MB_SYSTEMMODAL, "Button Clicked", 'Right Click to see the Contect Menu')
            Case $ButtonShowChildGui
                GUISetState(@SW_ENABLE, $gChildWithControls)
                GUISetState(@SW_SHOW, $gChildWithControls)
            Case $idChild_ButtonHide ; <<<<<<<<<<<<<<< Child Gui Control Actioned in  main loop
                ConsoleWrite("Yup, you clicked it" & @CRLF)
                GUISetState(@SW_HIDE, $gChildWithControls)
            Case $idChild_ButtonOkay ; <<<<<<<<<<<<<<< Child Gui Control Actioned in  main loop
                ConsoleWrite("Yup, you clicked it" & @CRLF)
                MsgBox($MB_SYSTEMMODAL, "Button Clicked", 'Okay')
        EndSwitch
    WEnd
    GUIDelete()

EndFunc   ;==>ShowChildGuis