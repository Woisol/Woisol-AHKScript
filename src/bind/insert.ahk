#Requires AutoHotkey v2.0

#Include active.ahk
#Include ../util/notify.ahk
#Include ../util/send.ahk
#Include ../util/windows.ahk
global mode := 0

; **----------------------------@section-Insert Mode-----------------------------------------------------
#hotif mode = 0 && active = true
{

  ; .::.
  . & a:: SendLoop("{Blind}{Home}")
  . & s:: SendLoop("{Blind}{Left}")
  . & d:: SendLoop("{Blind}{Down}")
  . & f:: SendLoop("{Blind}{Right}")
  . & e:: SendLoop("{Blind}{Up}")
  . & w:: SendLoop("{Blind}^{Left}")
  . & r:: SendLoop("{Blind}^{Right}")
  . & g:: handleShortLongPress("g", () => Send("{Blind}{End}"), _handleGLongPress)
  _handleGLongPress() {
    global
    if (inCode()) {
      Send "^g"
      if (times = 0)
        SendText "1"
      else
        SendText times
      Send "{Enter}"
    } else {
      Send "^{Home}"
      times := Mod(times, 1000)
      loop times - 1
        Send "{Down}"
    }
    times := 0
  }
  . & h:: {
    global
    handleShortLongPress("h", () => Send("^{Home}"), () => Send("^{End}"))
  }
  . & x::Esc
  . & c:: {
    ; !"T"❌，这个是代表模式，用T则软件内部判断状态，会导致Shift的组合键也导致判定为按下，用R才是实时判断
    if (GetKeyState("Shift", "P"))
      SendLoop("{Del}")
    else
      SendLoop("{BackSpace}")
  }
  . & v:: {
    if (GetKeyState("Shift", "P"))
      SendLoop("^{Del}")
    else
      SendLoop("^{BackSpace}")
  }
  . & q:: SendLoop("{Browser_Back}")
  . & z:: SendLoop("{Browser_Forward}")

  . & /::^/
  ^+k:: {
    if (inCode()) {
      Send "^+k"
      return
    }
    SendLoop("{Home}{Home}+{End}{BackSpace}{BackSpace}")
  }
  ^l:: {
    if (!inCode())
      Send "{Home}+{End}"
  }

  . & n:: {
    MouseClick("Left")
  }
  . & m:: {
    ; if (isDoubleClick(". & m"))
    ;     MouseMove(-100, -100, 0, "R")
    ; else
    ;     MouseMove(50, 50, 0, "R")
    MouseMove(A_ScreenWidth, A_ScreenHeight)
  }
  . & Delete:: SendLoop("{Blind}{Del}")

  . & 1:: {
    global
    ; hasOpt := true
    times := times * 10 + 1
  }
  . & 2:: {
    global
    ; hasOpt := true
    times := times * 10 + 2
  }
  . & 3:: {
    global
    ; hasOpt := true
    times := times * 10 + 3
  }
  . & 4:: {
    global
    ; hasOpt := true
    times := times * 10 + 4
  }
  . & 5:: {
    global
    ; hasOpt := true
    times := times * 10 + 5
  }
  . & 6:: {
    global
    ; hasOpt := true
    times := times * 10 + 6
  }
  . & 7:: {
    global
    ; hasOpt := true
    times := times * 10 + 7
  }
  . & 8:: {
    global
    ; hasOpt := true
    times := times * 10 + 8
  }
  . & 9:: {
    global
    ; hasOpt := true
    times := times * 10 + 9
  }
  . & 0:: {
    global
    ; hasOpt := true
    times *= 10
  }
  ; ~~单键不支持……咳是上面也定义了.::.了……
  ; ~. Up:: {
  ;     global
  ;         Send "."
  ;         times := 0
  ; }
  ; !暂时解决方案……
  ; +.::+.
  +. Up::
  ^. Up::
  !. Up::
  #. Up::
  ~. Up:: {
    global
    ; ！wok！NB了完美解决！
    ; !使用 ~ 防止处理了其它快捷键就不处理 .
    ; !使用 A_PriorKey 内部判断是单按还是按了其它按键后按
    if (A_PriorKey = ".") {
      Send "{Blind}."
      ; hasOpt := false
    }
    else
      times := 0
  }
  ; .::.

  . & ,:: {
    global
    tmpTooltip("Sticked to Normal Mode")
    mode := 1
    times := 0
  }
}
#hotif