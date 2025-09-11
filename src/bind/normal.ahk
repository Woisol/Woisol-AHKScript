#Requires AutoHotkey v2.0

#Include active.ahk
#Include ../util/send.ahk
#Include ../util/windows.ahk
#Include insert.ahk

; **----------------------------@section-Normal Mode-----------------------------------------------------
#hotif mode = 1 && active = true
{
  a:: SendLoop("{Home}")
  +a:: SendLoop("+{Home}")
  s:: SendLoop("{Left}")
  +s:: SendLoop("+{Left}")
  d:: SendLoop("{Down}")
  +d:: SendLoop("+{Down}")
  f:: SendLoop("{Right}")
  +f:: SendLoop("+{Right}")
  e:: SendLoop("{Up}")
  +e:: SendLoop("+{Up}")
  w:: SendLoop("^{Left}")
  +w:: SendLoop("^+{Left}")
  r:: SendLoop("^{Right}")
  +r:: SendLoop("^+{Right}")
  i:: {
    global
    tmpTooltip("Insert Mode")
    mode := 0
  }
  o:: {
    global
    Send "{End}{Enter}"
    tmpTooltip("Insert Mode")
    mode := 0
  }
  +o:: {
    global
    Send "{Home}{Enter}{Up}"
    tmpTooltip("Insert Mode")
    mode := 0
  }
  ; !这个总是不记得用……
  ^o:: {
    global
    Send "{End}{Enter}^/"
    tmpTooltip("Insert Mode")
    mode := 0
  }
  ^+o:: {
    global
    Send "{Home}{Enter}{Up}^/"
    tmpTooltip("Insert Mode")
    mode := 0
  }
  g:: handleShortLongPress("g", () => Send("{Blind}{End}"), _handleGLongPress)
  +g:: SendLoop("+{End}")
  c:: SendLoop("{BackSpace}")
  +c:: SendLoop("^{BackSpace}")
  ^c::^c
  x::Esc
  v::^v
  #v::#v
  z:: SendLoop("^z")
  +z:: SendLoop("^y")
  q:: {
    if (isDoubleClick("q")) {
      winclose "A"
    } else {
      Send "^w"
    }
  }
  +q::^+t

  ; **----------------------------@section-Normal Mode-Others-----------------------------------------------------
  t:: {
  }
  y:: {
  }
  u:: {
  }
  p:: {
    if (inCode()) {
      Send "^+{F5}{F5}"
    }
  }
  +p:: {
    if (inCode()) {
      Send "+{F5}"
    }
  }
  h:: {
  }
  j:: {
  }
  k:: {
    if (inCode()) {
      Send "^+k"
      return
    }
    Send "{Home}{Home}+{End}{BackSpace}{BackSpace}"
  }
  l:: {
    ; Send "{Home}+{End}"
    Send "!l"
  }
  b:: {
  }
  n:: {
    if (inCode()) {
      Send "^!{Up}"
    }
  }
  !n:: {
    if (inCode()) {
      Send "!+{Down}"
    }
  }
  m:: {
    if (inCode()) {
      Send "^!{Down}"
    }
  }
  Delete:: SendLoop("{Del}")
  F1::
  F10:: {
    Send "{Media_Prev}"
  }
  F2::
  F11:: {
    Send "{Media_Play_Pause}"
  }
  F3::
  F12:: {
    Send "{Media_Next}"
  }

  #SingleInstance Force
  /:: {
    if (inCode()) {
      Send "^/"
    }
  }
  ,:: return
  .:: return
  1:: {
    global
    times := times * 10 + 1
  }
  2:: {
    global
    times := times * 10 + 2
  }
  3:: {
    global
    times := times * 10 + 3
  }
  4:: {
    global
    times := times * 10 + 4
  }
  5:: {
    global
    times := times * 10 + 5
  }
  6:: {
    global
    times := times * 10 + 6
  }
  7:: {
    global
    times := times * 10 + 7
  }
  8:: {
    global
    times := times * 10 + 8
  }
  9:: {
    global
    times := times * 10 + 9
  }
  0:: {
    global
    if (times = 0)
      Send "^{Home}"
    else
      times *= 10
  }
  +0:: Send "^{End}"
  Esc:: {
    global
    tmpTooltip("Back to Insert Mode")
    mode := 0
    times := 0
  }

}
#hotif