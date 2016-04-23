; Note: This implementation assumes an en-US QWERTY layout.


SendMode Input
#NoEnv
#SingleInstance force


options := {delay: 150, timeout: 300, doublePress: -1, swap_backtick_escape: false, mode: "minila"}
loop %0% {
	arg := %A_Index%
	argSplit := StrSplit(arg, "=")
	option := argSplit[1]
	value := argSplit[2]
	options[option] := value
}


#Include C:\Users\fernandog\Documents\admin\Lib\dual\dual.ahk
dual := new Dual


#Include C:\Users\fernandog\Documents\admin\Lib\dual\defaults.ahk


#If options.swap_backtick_escape
*`::dual.comboKey({F22: "Escape"})
#If

#If options.mode == "minila"
*`::dual.comboKey({F22: "Escape"})

*e::dual.comboKey({F22: "Up"})
*s::dual.comboKey({F22: "Left"})
*d::dual.comboKey({F22: "Down"})
*f::dual.comboKey({F22: "Right"})

*i::dual.comboKey({F22: "PrintScreen"})
*o::dual.comboKey({F22: "ScrollLock"})
*p::dual.comboKey({F22: "Pause"})

*j::dual.comboKey({F22: "Insert"})
*k::dual.comboKey({F22: "Home"})
*l::dual.comboKey({F22: "PgUp"})
*;::dual.comboKey({F22: "BS"})

*m::dual.comboKey({F22: "Del"})
*,::dual.comboKey({F22: "End"})
*.::dual.comboKey({F22: "PgDn"})
#If


#If options.mode == "ijkl"
*i::dual.comboKey({F22: "Up"})
*j::dual.comboKey({F22: "Left"})
*k::dual.comboKey({F22: "Down"})
*l::dual.comboKey({F22: "Right"})

*u::dual.comboKey({F22: "Home"})
*o::dual.comboKey({F22: "End"})
*h::dual.comboKey({F22: "PgUp"})
*n::dual.comboKey({F22: "PgDn"})

*m::dual.comboKey({F22: "``"})
*,::dual.comboKey({F22: "~"})
#If


#If options.mode == "ijkl2"
*i::dual.comboKey({F22: "Up"})
*j::dual.comboKey({F22: "Left"})
*k::dual.comboKey({F22: "Down"})
*l::dual.comboKey({F22: "Right"})
*,::dual.comboKey({F22: "Down"})

*u::dual.comboKey({F22: "Home"})
*m::dual.comboKey({F22: "End"})
*o::dual.comboKey({F22: "PgUp"})
*.::dual.comboKey({F22: "PgDn"})
#If


#If options.mode == "hjkl"
*h::dual.comboKey({F22: "Left"})
*j::dual.comboKey({F22: "Down"})
*k::dual.comboKey({F22: "Up"})
*l::dual.comboKey({F22: "Right"})

*y::dual.comboKey({F22: "Home"})
*u::dual.comboKey({F22: "PgUp"})
*i::dual.comboKey({F22: "PgDn"})
*o::dual.comboKey({F22: "End"})

*n::dual.comboKey({F22: "Home"})
*m::dual.comboKey({F22: "PgUp"})
*,::dual.comboKey({F22: "PgDn"})
*.::dual.comboKey({F22: "End"})
#If


#If options.mode == "wasd"
*w::dual.comboKey({F22: "Up"})
*a::dual.comboKey({F22: "Left"})
*s::dual.comboKey({F22: "Down"})
*d::dual.comboKey({F22: "Right"})

*q::dual.comboKey({F22: "Home"})
*e::dual.comboKey({F22: "End"})
*f::dual.comboKey({F22: "PgUp"})
*c::dual.comboKey({F22: "PgDn"})
#If


#If true ; Override defaults.ahk. There will be "duplicate hotkey" errors otherwise.
*Space::
*Space UP::dual.combine("F22", A_ThisHotkey, {delay: options.delay, timeout: options.timeout, doublePress: options.doublePress})

*1::dual.comboKey({F22: "F1"})
*2::dual.comboKey({F22: "F2"})
*3::dual.comboKey({F22: "F3"})
*4::dual.comboKey({F22: "F4"})
*5::dual.comboKey({F22: "F5"})
*6::dual.comboKey({F22: "F6"})
*7::dual.comboKey({F22: "F7"})
*8::dual.comboKey({F22: "F8"})
*9::dual.comboKey({F22: "F9"})
*0::dual.comboKey({F22: "F10"})
*-::dual.comboKey({F22: "F11"})
*=::dual.comboKey({F22: "F12"})
#If