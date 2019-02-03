#include <Display_library_functions.au3>

HotKeySet("#q", "TopLeft")
HotKeySet("#w", "TopRight")
HotKeySet("#a", "BotLeft")
HotKeySet("#s", "BotRight")

$array = _DisplayKeySettings(_NumberAndNameMonitors())

Local $Monitors[1][14]
$Monitors[0][0] = 0

For $i = 1 To $array[0][0]
	If BitAND(Dec($array[$i][0]),1) > 0 Then
		$Monitors[0][0] += 1
		ReDim $Monitors[UBound($Monitors, 1)+1][14]
		$Monitors[UBound($Monitors, 1)-1][0] = $array[$i][2] ;xpos
		$Monitors[UBound($Monitors, 1)-1][1] = $array[$i][3] ;ypos
		$Monitors[UBound($Monitors, 1)-1][2] = $array[$i][4] ;width
		$Monitors[UBound($Monitors, 1)-1][3] = $array[$i][5] ;height
		$Monitors[UBound($Monitors, 1)-1][4] = $array[$i][4] / 2 ;1/4 size xqq
		$Monitors[UBound($Monitors, 1)-1][5] = $array[$i][5] / 2 ;1/4 size y
		$Monitors[UBound($Monitors, 1)-1][6] = $array[$i][2] ;xpos top left
		$Monitors[UBound($Monitors, 1)-1][7] = $array[$i][3] ;ypos top left
		$Monitors[UBound($Monitors, 1)-1][8] = $array[$i][2] + $array[$i][4] / 2 ;xpos top right
		$Monitors[UBound($Monitors, 1)-1][9] = $array[$i][3] ;ypos top right
		$Monitors[UBound($Monitors, 1)-1][10] = $array[$i][2] ;xpos bottom left
		$Monitors[UBound($Monitors, 1)-1][11] = $array[$i][3] + $array[$i][5] / 2 ;ypos bottom left
		$Monitors[UBound($Monitors, 1)-1][12] = $array[$i][2] + $array[$i][4] / 2 ;xpos bottom right
		$Monitors[UBound($Monitors, 1)-1][13] = $array[$i][3] + $array[$i][5] / 2 ;ypos bottom right
	EndIf
Next

While 1
	Sleep(1000)
WEnd

Func MoveWindow($Var1, $Var2)
	Local $Hwd = WinGetHandle("")
	Local $Pos = WinGetPos($Hwd)
	$Pos[0] += $Pos[2]/2
	$Pos[1] += $Pos[3]/2
	For $i = 1 To $Monitors[0][0]
		If $Pos[0] >= $Monitors[$i][0] And $Pos[0] <= ($Monitors[$i][0] + $Monitors[$i][2]) And $Pos[1] >= $Monitors[$i][1] And $Pos[1] <= ($Monitors[$i][1] + $Monitors[$i][3]) Then
			WinMove($Hwd, "", $Monitors[$i][$Var1],$Monitors[$i][$Var2],$Monitors[$i][4],$Monitors[$i][5],1)
		EndIf
	Next
EndFunc

Func TopLeft()
	MoveWindow(6,7)
EndFunc

Func TopRight()
	MoveWindow(8,9)
EndFunc

Func BotLeft()
	MoveWindow(10,11)
EndFunc

Func BotRight()
	MoveWindow(12,13)
EndFunc