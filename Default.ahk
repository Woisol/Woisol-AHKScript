; @todo 添加“哨兵”模式专门用于闲置电脑时切歌等操作
global mode := 0
; global hasOpt := false
global times := 0
global active := true

; **----------------------------Actived Common-----------------------------------------------------

!+':: {
    global
    if (active) {
        active := false
        tmpTooltip("Deactived")
    }
    else {
        active := true
        tmpTooltip("Actived")
    }
    Send "!+;"
}
#hotif active = true

; @section-CapsLocko
CapsLock:: return
!CapsLock:: {
    CapsLock := GetKeyState("CapsLock", "T")
    if (CapsLock)
        SetCapsLockState(0)
    else
        SetCapsLockState(1)

    ; if(isDoubleClick("CapsLock")){
    ;     CapsLock:=getkeystate("CapsLock","T")
    ;     if(CapsLock)
    ;     setCapsLockstate(0)
    ;     else
    ;     setCapsLockstate(1)
    ; }
    ; else{
    ;     Send "{Esc}"
    ; }
}
CapsLock & 1::#1
CapsLock & 2::#2
CapsLock & 3::#3
; CapsLock & g::#4
; CapsLock & h::#5

; CapsLock & q::^!q
; CapsLock & w::^!w
CapsLock & q:: ActivateOrRun("QQ.exe", "D:/Social/QQ/QQ.exe", "^!q")
CapsLock & w:: ActivateOrRun("WeChat.exe", "D:/Social/WeChat/WeChat.exe", "^!w")
CapsLock & e:: ActivateOrRun("lx-music-desktop.exe", "D:/Amusment/lx-music-desktop/lx-music-desktop.exe", "!m")
CapsLock & s:: ActivateOrRun("AFFiNE-beta.exe",
    "C:/Users/Woisol-G/AppData/Local/AFFiNE-beta/app-0.20.4-beta1/AFFiNE-beta.exe")
CapsLock & d:: ActivateOrRun("msedge.exe", "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")
CapsLock & f:: ActivateOrRun("Trae CN.exe", "D:/Coding/Trae CN/Trae CN.exe")
CapsLock & g:: ActivateOrRun("Code.exe", "D:/Coding/VSCode/Code.exe")
CapsLock & t:: ActivateOrRun("WindowsTerminal.exe", "wt", , true)

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

; @section-;
`;::;
`; & q:: {
    if (isDoubleClick('; & q'))
        Send '{BackSpace}{Raw}^'
    else
        SendText '*'
}
`; & w:: {
    if (isDoubleClick('; & w'))
        Send '{BackSpace}~'
    else
        SendText '#'
}
`; & e:: {
    if (isDoubleClick('; & e'))
        Send '{BackSpace}"'
    else
        SendText '>'
}
`; & a:: {
    if (isDoubleClick('; & a'))
        Send '{BackSpace}='
    else
        SendText '+'
}
`; & s:: {
    if (isDoubleClick('; & s'))
        Send '{BackSpace}_'
    else
        SendText '-'
}
`; & d:: {
    if (isDoubleClick('; & d'))
        Send '{BackSpace}\'
    else
        SendText '/'
}
`; & z:: {
    if (isDoubleClick('; & z'))
        Send '{BackSpace}@'
    else
        SendText '$'
}
`; & x::%
`; & c:: {
    if (isDoubleClick('; & c')) {
        Send '{BackSpace}|'
    } else {
        SendText '&'
    }
}

`; & j:: {
    Send "^v"
}
`; & r:: {
    if (inCode()) {
        SendText "("
        return
    }
    if (isDoubleClick('; & r')) {
        Send "{Right}{BackSpace}{BackSpace}{Raw})"
        return
    } else {
        Send "^c"
        Send "("
        Send ")"
        Send "{Left}"
    }
}
`; & f:: {
    if (inCode()) {
        SendText "["
        return
    }
    if (isDoubleClick('; & f')) {
        Send "{BackSpace}"
        return
    } else {
        Send "^c"
        SendText "["
        SendText "]"
        Send "{Left}"
    }
}
`; & v:: {
    if (inCode()) {
        SendText "{"
        return
    }
    if (isDoubleClick('; & v')) {
        Send "{BackSpace}"
        return
    } else {
        Send "^c"
        SendText "{"
        SendText "}"
        Send "{Left}"
    }
}
`; & t:: {
    doubleClick := isDoubleClick('; & t')
    if (inCode()) {
        if (doubleClick) {
            Send '{BackSpace}{Raw}"'
            return
        }
        SendText "'"
        return
    }
    if (doubleClick) {
        Send '{BackSpace}{Raw}"'
        ; Send '"'
        ; Send '"'
        ; Send "{Left}"
    } else {
        Send "^c"
        Send "'"
        ; Send "'"
        ; Send "{Left}"
    }
}
`; & g:: {
    if (isDoubleClick('; & g'))
        Send '{BackSpace}{Raw}!'
    else
        Send '?'
}
`; & b:: {
    if (inCode()) {
        SendText "<"
        return
    }
    if (isDoubleClick('; & b')) {
        Send "{BackSpace}"
        return
    } else {
        Send "^c"
        SendText "<"
        SendText ">"
        Send "{Left}"
    }
}

+9:: {
    if (inCode())
        Send "("
    else
        Send "(){Left}"
}
[:: {
    if (isDoubleClick("[")) {
        Send "{Right}{Backspace}{Backspace}["
    }
    else if (inCode())
        SendText "["
    else {
        SendText "[]"
        Send "{Left}"
    }
}
+[:: {
    if (inCode())
        SendText "{"
    else
        Send "{{}{}}{Left}"
}

#hotif
; #hotif active = false
; #hotif
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
    g:: {
        global
        if (isDoubleClick("g")) {
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
        } else {
            Send "{End}"
        }
    }
    +g:: SendLoop("+{End}")
    c:: SendLoop("{BackSpace}")
    +c:: SendLoop("^{BackSpace}")
    ^c::^c
    x:: {
        if (isDoubleClick("x")) {
            Send "{Esc}"
        } else {
            Send "^c"
        }
    }
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
    . & g:: {
        global
        if (isDoubleClick(". & g")) {
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
        } else {
            Send "{Blind}{End}"
        }
    }
    . & h:: {
        global
        if (isDoubleClick(". & h")) {
            Send "^{End}"
        }
        else if (times = 0)
            Send "^{Home}"
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

; **----------------------------@section-Functions-----------------------------------------------------
tmpTooltip(msg) {
    ToolTip msg
    SetTimer () => ToolTip(), -5000
}
inCode() {
    win := WinGetProcessName("A")
    switch (WinGetProcessName("A")) {
        ; !不会像C那样连续……
        case "Code.exe": return 1
        case "Trae CN.exe": return 1
        case "idea64.exe": return 1
        case "devenv.exe": return 1
        case "微信开发者工具.exe": return 1
        default: return 0
    }
}
isDoubleClick(key) {
    return A_PriorHotkey == key && A_TimeSincePriorHotkey < 200
}
SendLoop(key) {
    global
    ; isShift := key.startswith("+")
    ; !艹还是用Blind好用哈哈
    ; if (SubStr(key, 1, 1) = "+") {
    ;     ; key := key[1:]
    ;     key := SubStr(key, 2)
    ;     Send "{Shift Down}"
    ; }
    ; if(SubStr(key, 1, 1) = "^") {
    ;     key := SubStr(key, 2)
    ;     Send "{Alt Down}"
    ; }
    Send key
    times := Mod(times, 1000) - 1
    loop times
        Send key
    ; Send "{" key " " times "}"
    ; !emm好像效果和用Loop差不多……
    times := 0
    ; hasOpt := true
    ; if(isShift){
    ; Send "{Shift Up}"
    ; Send "{Alt Up}"
    ; }
}
; SendLoopWithShift(key) {
;     global
;     if (GetKeyState("Shift", "T")) {
;         SendLoop("+" . key)
;     }
;     ; !az居然是用这个来拼接字符串的……
;     else
;         SendLoop(key)
; }
ActivateOrRun(win_exe, path, shortcut := "", admin := false) {
    ; ;!逻辑优化
    ; "ahk_exe "
    if ProcessExist(win_exe) {
        if shortcut
            Send shortcut
        else if WinActive("ahk_exe " win_exe)
        ; !哇趣，注意函数和命令的调用方法不同！
        ; WinHide
            WinMinimize "ahk_exe " win_exe
        else {
            ; ~~无效，放弃
            ; WinShow "ahk_exe " win_exe
            ; WinRestore "ahk_exe " win_exe
            if WinExist("ahk_exe " win_exe)
                WinActivate "ahk_exe " win_exe
            else
            ; !优化逻辑
                if admin
                    Run "*RunAs " path
                else
                    Run path
        }
    } else {
        if admin
            Run "*RunAs " path
        else
            Run path
    }
    Send "{CapsLock up}"

}
