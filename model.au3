#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         narfman0

 Script Function:
   Pokemon desmume grind bot. Black 2 targeted, but should work with any gen5.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <ImageSearch.au3>

HotKeySet("{PAUSE}", "TogglePause")

global $paused
global $moveLeft
global $cgearColor = 0x189494
global $inputWait = 1000
global $hWnd = WinGetHandle("Final Fantasy III")
global $moveIdx = 0
global $state = 'Not Started'

Func Update()
    If $paused Then
        $state = 'Paused'
        Return
    EndIf
    WinActivate($hWnd)
    $clientSize = GetWindowSize($hWnd)

    ;If ColorInWindow($hWnd, $cgearColor) Then
	$xTarget = 0
    $yTarget = 0
    $target = _ImageSearchArea("inBattle.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xTarget, $yTarget, 50)
	$xPostFight = 0
    $yPostFight = 0
    $postFight = _ImageSearchArea("postFight.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xPostFight, $yPostFight, 50)

	If $postFight Then
	    ;MouseMove($xPostFight, $yPostFight, 0)
        Send("{ENTER down}")
        Sleep(50)
        Send("{ENTER up}")
        $state = 'Victory'
    ElseIf $target Then
	    ;MouseMove($xTarget, $yTarget, 0)
        Send("{ENTER down}")
        Sleep(50)
        Send("{ENTER up}")
        $state = 'Fighting'
	 Else
		If $state <> 'Fighting' Then
	    	SearchMobs()
            $state = 'Searching'
		EndIf
    EndIf
EndFunc

Func GetWindowSize($hWnd)
    $clientSize = WinGetPos($hWnd)
    Local $arr[4] = [$clientSize[0], $clientSize[1], $clientSize[0] + $clientSize[2], $clientSize[1] + $clientSize[3]]
    return $arr
EndFunc

Func HandleMouseClick($x, $y)
    MouseMove($x, $y, 0)
    Sleep(10)
    MouseClick("left")
    Sleep(100)
    MouseMove(0, 0, 0)
    Sleep(10)
EndFunc

Func SearchMobs()
    If $moveLeft Then
        Send("{left down}")
        Sleep($inputWait)
        Send("{left up}")
    Else
        Send("{right down}")
        Sleep($inputWait)
        Send("{right up}")
    EndIf
    $moveLeft = Not $moveLeft
EndFunc

Func ColorInWindow($hWnd, $color)
    local $hWndPos = WinGetPos($hWnd)
    $coord = PixelSearch($hWndPos[0], $hWndPos[1], $hWndPos[0] + $hWndPos[2], $hWndPos[1] + $hWndPos[3], $color, 4, 4, $hWnd)
    return not @error
EndFunc

Func TogglePause()
    $paused = NOT $paused
EndFunc