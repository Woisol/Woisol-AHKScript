#Requires AutoHotkey v2.0
#Include ../../util/windows.ahk

; @section-3
3::3
3 & w::Media_Prev
3 & e::Media_Play_Pause
3 & r::Media_Next

3 & u::Numpad7
3 & i::Numpad8
3 & o::Numpad9
3 & j::Numpad4
3 & k::Numpad5
3 & l::Numpad6
3 & n::Numpad1
3 & m::Numpad1
3 & ,::Numpad2
3 & .::Numpad3
3 & space::Numpad0

3 & 2:: {
  loop 5
    Send "{WheelUp}"
}
3 & 4:: {
  loop 5
    Send "{WheelDown}"
}

3 & 1:: Send "^{Home}"
3 & 5:: Send "^{End}"

3 & d:: FillWindows()
3 & f:: FillWindows(0)