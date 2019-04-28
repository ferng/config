#InstallKeybdHook
SendMode Input
SetWorkingDir %A_ScriptDir%

VOLUME_MUTE::F1
F1::VOLUME_MUTE

VOLUME_DOWN::F2
F2::VOLUME_DOWN

VOLUME_UP::F3
F3::VOLUME_UP

MEDIA_PLAY_PAUSE::F4
F4::MEDIA_PLAY_PAUSE

BROWSER_SEARCH::F5
F5::BROWSER_SEARCH

LWin & F21:: 
	GetKeyState, state, Alt
	if state = D
		Send, {F6}
	else
		Send, {F8}
Return

F6::#!F21
F8::#F21

LControl & F21:: 
	GetKeyState, state, LWin
	if state = D
		Send, {F7}
Return 

F7::#^F21

LControl & Tab:: 
	GetKeyState, state, LWin
	if state = D
		Send, {F9}
Return 
F9::#^Tab

APPSKEY::F10
F10::APPSKEY
