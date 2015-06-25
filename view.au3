#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "model.au3"

$ff3hogieUI = GUICreate("ff3hogie", 359, 71, 418, 233)
$stateDescriptionLabel = GUICtrlCreateLabel("State:", 0, 16, 32, 17)
$stateLabel = GUICtrlCreateLabel("Unknown", 96, 16, 178, 17)
$pauseButton = GUICtrlCreateButton("Pause", 280, 8, 75, 25)
GUISetState(@SW_SHOW)

While 1
    Update()
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $pauseButton
            TogglePause()
    EndSwitch
    If $paused Then
        GUICtrlSetData($pauseButton, "Continue")
    Else
        GUICtrlSetData($pauseButton, "Pause")
    EndIf
    $clientSize = WinGetPos($hWnd)
    $botSize = WinGetPos($ff3hogieUI)
    GUICtrlSetData($stateLabel, $state)
    WinMove($ff3hogieUI, "", $clientSize[0], $clientSize[1] - $botSize[3])
WEnd
