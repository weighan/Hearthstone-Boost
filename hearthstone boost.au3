#cs
This program was designed with autoIT, its function is to automatically level up a user's account in the Blizzard game Hearthstone.
2 accounts are needed for this program, one is the "loser" who simply forfeits to the winner to give xp.
2 coordinates are needed for the loser, the location of the button to begin a game, and the button to concede the game.
to get these coordinates, the user simply mouses over where the buttons are, and pushes F3 and F4 to set the coordinates.

Loser mode involves selecting ready for the game to start, waiting for the game to load, pushing "ESC", and clicking the concede button,
followed by a few more clicks to clear after game messages. The concede button seems to drift around occasionally, so the program also clicks 10 and 20
pixels above the button's coordinates.  $longt is for the longer wait for the game to load.  $time is for the shorter wait between clicks at different locations.

Winner mode simply involves clicking the ready button. This also clears any after game messages
#ce

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Hearthstone Boost", 369, 323, 199, 174)
GUISetFont(9, 400, 0, "Arial")
$Timein = GUICtrlCreateInput("", 112, 112, 209, 20)
$Delay = GUICtrlCreateLabel("Time Delay 1", 16, 112, 84, 21)
GUICtrlSetTip(-1, "Time is in milliseconds")
$Delay2 = GUICtrlCreateLabel("Time Delay 2", 16, 160, 81, 33)
$Timein2 = GUICtrlCreateInput("", 112, 160, 209, 20)
GUICtrlSetFont(-1, 13, 400, 0, "Arial")
$start = GUICtrlCreateLabel("F1 to start", 10, 5, 100, 52)
GUICtrlSetFont(-1, 15, 400, 0, "Arial")
GUICtrlSetResizing(-1, $GUI_DOCKHCENTER+$GUI_DOCKVCENTER)
$stop = GUICtrlCreateLabel("F2 to stop", 270, 5, 100, 44)
GUICtrlSetFont(-1, 15, 400, 0, "Arial")
$label3 = GUICtrlCreateLabel("F3 to get play pos", 10, 40, 100, 20)
$label4 = GUICtrlCreateLabel("F4 to get concede pos", 270, 40, 100, 34)
$win = GUICtrlCreateRadio("Winner Mode", 16, 232, 100, 41)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$lose = GUICtrlCreateRadio("Loser Mode", 150, 232, 100, 41)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
$Graphic1 = GUICtrlCreateGraphic(165, 10, 41, 41)
GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x000000, 0x00FF00)
GUICtrlSetGraphic(-1, $GUI_GR_RECT, 0, 0, 40, 40)
GUICtrlSetState(-1, $GUI_HIDE)
$playpos = GUICtrlCreateGraphic(10, 60, 30, 30)
GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x000000, 0x00FF00)
GUICtrlSetGraphic(-1, $GUI_GR_RECT, 0, 0, 20, 20)
GUICtrlSetState(-1, $GUI_HIDE)
$conpos = GUICtrlCreateGraphic(345, 75, 30, 30)
GUICtrlSetGraphic(-1, $GUI_GR_COLOR, 0x000000, 0x00FF00)
GUICtrlSetGraphic(-1, $GUI_GR_RECT, 0, 0, 20, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###.

Global $var1 = True
HotKeySet ("{F1}", "Start")
HotKeySet ("{F2}", "Stop")
HotKeySet ("{F3}", "playpos")
HotKeySet ("{F4}", "conpos")
Global $time = 5
Global $func = ""
Global $lor = "left"
Global $longt = 0
Global $modt = False
Global $playx = 0
Global $playy = 0
Global $conx = 0
Global $cony = 0

While 1
	Global $msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then Exit
	If $msg = $win Then $func = "winner"
	If $msg = $lose Then $func = "loser"
WEnd

Func loser()
	$var1 = True
	While $var1
			MouseClick($lor, $playx, $playy)
			Delay($longt)
			If Not $var1 Then ExitLoop
			Send("{ESC}")
			Delay($time)
			MouseClick($lor, $conx, $cony)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $conx, $cony-10)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $conx, $cony-20)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $playx, $playy)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $playx, $playy)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $playx, $playy)
			Delay($time)
			If Not $var1 Then ExitLoop
			MouseClick($lor, $playx, $playy)
			Delay($time)
			If Not $var1 Then ExitLoop
			Delay($time)
	WEnd
EndFunc

Func winner()
	$var1 = True
	While $var1
		MouseClick($lor, $playx, $playy)
		Delay($time)
	WEnd
EndFunc

Func Start()
	GUICtrlSetState($Graphic1, $GUI_SHOW)
	$time = GUICtrlRead($Timein)
	$longt = GUICtrlRead ($Timein2)
	If $longt == "" Then $ext = 0
	If $time == "" Then $time = 0
	Call($func)
EndFunc

Func Stop()
    $var1 =False
	GUICtrlSetState($Graphic1, $GUI_HIDE)
EndFunc

Func playpos()
	$playx = MouseGetPos(0)
	$playy = MouseGetPos(1)
	GUICtrlSetState($playpos, $GUI_SHOW)
EndFunc

Func conpos()
	$conx = MouseGetPos(0)
	$cony = MouseGetPos(1)
	GUICtrlSetState($conpos, $GUI_SHOW)
EndFunc
Func Delay($iDelay)

    $iBegin = TimerInit() ; Until the time reaches the required number of msec since the timestamp
    While TimerDiff($iBegin) < $iDelay And $var1
        ; Poll the message queue
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
            ;Case $Button2
               ; Return True ; Tell the main loop the button was pressed and return immediately
        EndSwitch
    WEnd
    ; We are here because the loop has waited for the required time
    ; Tell the main loop the button was not pressed
    Return False

EndFunc
