#include <AutoItConstants.au3> ; Required for _ArrayDisplay.

WinActivate("LDPlayer-2")
Opt("WinTitleMatchMode", 3)
ControlSend("LDPlayer-2","","","^{F1}")

;~ ControlClick("LDPlayer-2", "", "","", 1,721, 9) ; click mini