; TODO 添加“哨兵”模式专门用于闲置电脑时切歌等操作
global mode := 0
global times := 0
global active := true

; **----------------------------Actived Common-----------------------------------------------------
#hotif active = true
!+':: {
    global
    active := false
    tmpTooltip("Deactived")
}

Capslock:: return
!Capslock:: {
    capslock := getkeystate("Capslock", "T")
    if (capslock)
        setcapslockstate(0)
    else
        setcapslockstate(1)

    ; if(isDoubleClick("Capslock")){
    ;     capslock:=getkeystate("Capslock","T")
    ;     if(capslock)
    ;     setcapslockstate(0)
    ;     else
    ;     setcapslockstate(1)
    ; }
    ; else{
    ;     send "{esc}"
    ; }
}
Capslock & s::#1
Capslock & d::#2
Capslock & f::#3
Capslock & g::#4
Capslock & h::#5

Capslock & q::^!q
Capslock & w::^!w

3::3
3 & w::media_prev
3 & e::media_play_pause
3 & r::media_next

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
    loop 10
        send "{Up}"
}
3 & 4:: {
    loop 10
        send "{Down}"
}

`;::;
`; & q:: {
    if (isDoubleClick('; & q'))
        send '{BackSpace}{raw}^'
    else
        sendtext '*'
}
`; & w:: {
    if (isDoubleClick('; & w'))
        send '{BackSpace}~'
    else
        sendtext '#'
}
`; & e:: {
    if (isDoubleClick('; & e'))
        send '{BackSpace}"'
    else
        sendtext '>'
}
`; & a:: {
    if (isDoubleClick('; & a'))
        send '{BackSpace}='
    else
        sendtext '+'
}
`; & s:: {
    if (isDoubleClick('; & s'))
        send '{BackSpace}_'
    else
        sendtext '-'
}
`; & d:: {
    if (isDoubleClick('; & d'))
        send '{BackSpace}\'
    else
        sendtext '/'
}
`; & z:: {
    if (isDoubleClick('; & z'))
        send '{BackSpace}@'
    else
        sendtext '$'
}
`; & x::%
`; & c:: {
    if (isDoubleClick('; & c')) {
        send '{BackSpace}|'
    } else {
        sendtext '&'
    }
}

`; & j:: {
    send "^v"
}
`; & r:: {
    if (inCode()) {
        sendtext "("
        return
    }
    if (isDoubleClick('; & r')) {
        send "{Right}{BackSpace}{BackSpace}{raw})"
        return
    } else {
        send "^c"
        send "("
        send ")"
        send "{left}"
    }
}
`; & f:: {
    if (inCode()) {
        sendtext "["
        return
    }
    if (isDoubleClick('; & f')) {
        sendtext "{BackSpace}"
        return
    } else {
        send "^c"
        send "["
        send "]"
        send "{left}"
    }
}
`; & v:: {
    if (inCode()) {
        sendtext "{"
        return
    }
    if (isDoubleClick('; & v')) {
        sendtext "}"
        return
    } else {
        send "^c"
        SendText "{"
        SendText "}"
        send "{left}"
    }
}
`; & t:: {
    doubleClick := isDoubleClick('; & t')
    if (inCode()) {
        if (doubleClick) {
            send '{BackSpace}{Raw}"'
            return
        }
        sendtext "'"
        return
    }
    if (doubleClick) {
        send '{BackSpace}{raw}"'
        ; send '"'
        ; send '"'
        ; send "{left}"
    } else {
        send "^c"
        send "'"
        ; send "'"
        ; send "{left}"
    }
}
`; & g:: {
    if (isDoubleClick('; & g'))
        send '{BackSpace}{raw}!'
    else
        send '?'
}
`; & b:: {
    if (inCode()) {
        sendtext "<"
        return
    }
    if (isDoubleClick('; & b')) {
        send "{BackSpace}"
        return
    } else {
        send "^c"
        sendtext "<"
        sendtext ">"
        send "{left}"
    }
}

+9:: {
    if (inCode())
        send "("
    else
        send "(){left}"
}
[:: {
    if (inCode())
        send "["
    else
        send "[]{left}"
}
+[:: {
    if (inCode())
        sendtext "{"
    else
        send "{{}{}}{left}"
}

#hotif
#hotif active = false
!+':: {
    global
    active := true
    tmpTooltip("Actived")
}
#hotif
; **----------------------------Normal Mode-----------------------------------------------------
#hotif mode = 1 && active = true
{
    a:: SendLoop("{home}")
    +a:: SendLoop("+{home}")
    s:: SendLoop("{left}")
    +s:: SendLoop("+{left}")
    d:: SendLoop("{down}")
    +d:: SendLoop("+{down}")
    f:: SendLoop("{right}")
    +f:: SendLoop("+{right}")
    e:: SendLoop("{up}")
    +e:: SendLoop("+{up}")
    w:: SendLoop("^{left}")
    +w:: SendLoop("^+{left}")
    r:: SendLoop("^{right}")
    +r:: SendLoop("^+{right}")
    i:: {
        global
        tmpTooltip("Insert Mode")
        mode := 0
    }
    o:: {
        global
        send "{end}{enter}"
        tmpTooltip("Insert Mode")
        mode := 0
    }
    +o:: {
        global
        send "{home}{enter}{up}"
        tmpTooltip("Insert Mode")
        mode := 0
    }
    ; !这个总是不记得用……
    ^o:: {
        global
        send "{end}{enter}^/"
        tmpTooltip("Insert Mode")
        mode := 0
    }
    ^+o:: {
        global
        send "{home}{enter}{up}^/"
        tmpTooltip("Insert Mode")
        mode := 0
    }
    g:: {
        global
        if (isDoubleClick("g")) {
            if (inCode()) {
                send "^g"
                if (times = 0)
                    sendtext "1"
                else
                    sendtext times
                send "{enter}"
            } else {
                send "^{home}"
                times := mod(times, 1000)
                loop times - 1
                    send "{down}"
            }
            times := 0
        } else {
            send "{end}"
        }
    }
    +g:: SendLoop("+{end}")
    c:: SendLoop("{BackSpace}")
    +c:: SendLoop("^{BackSpace}")
    ^c::^c
    x:: {
        if (isDoubleClick("x")) {
            send "{esc}"
        } else {
            send "^c"
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
            send "^w"
        }
    }
    +q::^+t

    ; **----------------------------Others-----------------------------------------------------
    t:: {
    }
    y:: {
    }
    u:: {
    }
    p:: {
        if (inCode()) {
            send "^+{F5}{F5}"
        }
    }
    +p:: {
        if (inCode()) {
            send "+{F5}"
        }
    }
    h:: {
    }
    j:: {
    }
    k:: {
        if (inCode()) {
            send "^+k"
            return
        }
        send "{home}{home}+{end}{BackSpace}{BackSpace}"
    }
    l:: {
        send "{home}+{end}"
    }
    b:: {
    }
    n:: {
        if (inCode()) {
            send "^!{up}"
        }
    }
    !n:: {
        if (inCode()) {
            send "!+{down}"
        }
    }
    m:: {
        if (inCode()) {
            send "^!{down}"
        }
    }

    #SingleInstance Force
    /:: {
        if (inCode()) {
            send "^/"
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
            send "^{home}"
        else
            times *= 10
    }
    +0:: send "^{end}"
    esc:: {
        global
        tmpTooltip("Back to Insert Mode")
        mode := 0
        times := 0
    }

}
#hotif
; **----------------------------Insert Mode-----------------------------------------------------
#hotif mode = 0 && active = true
{

    .::.
    . & a:: SendLoop("{Blind}{home}")
    . & s:: SendLoop("{Blind}{left}")
    . & d:: SendLoop("{Blind}{down}")
    . & f:: SendLoop("{Blind}{right}")
    . & e:: SendLoop("{Blind}{up}")
    . & w:: SendLoop("{Blind}^{left}")
    . & r:: SendLoop("{Blind}^{right}")
    . & g:: {
        global
        if (isDoubleClick(". & g")) {
            if (inCode()) {
                send "^g"
                if (times = 0)
                    sendtext "1"
                else
                    sendtext times
                send "{enter}"
            } else {
                send "^{home}"
                times := mod(times, 1000)
                loop times - 1
                    send "{down}"
            }
            times := 0
        } else {
            send "{Blind}{end}"
        }
    }
    . & x::esc
    . & c:: SendLoop("{BackSpace}")
    . & v:: SendLoop("^{BackSpace}")
    . & /::^/
    ^+k:: {
        if (inCode()) {
            send "^+k"
            return
        }
        SendLoop("{home}{home}+{end}{BackSpace}{BackSpace}")
    }
    ^l:: {
        if (!inCode())
            send "{home}+{end}"
    }

    . & n:: {
        MouseClick("Left")
    }

    . & 1:: {
        global
        times := times * 10 + 1
    }
    . & 2:: {
        global
        times := times * 10 + 2
    }
    . & 3:: {
        global
        times := times * 10 + 3
    }
    . & 4:: {
        global
        times := times * 10 + 4
    }
    . & 5:: {
        global
        times := times * 10 + 5
    }
    . & 6:: {
        global
        times := times * 10 + 6
    }
    . & 7:: {
        global
        times := times * 10 + 7
    }
    . & 8:: {
        global
        times := times * 10 + 8
    }
    . & 9:: {
        global
        times := times * 10 + 9
    }
    . & 0:: {
        global
        if (isDoubleClick(". & 0")) {
            send "^{end}"
        }
        else if (times = 0)
            send "^{home}"
        else
            times *= 10
    }

    . & ,:: {
        global
        tmpTooltip("Sticked to Normal Mode")
        mode := 1
        times := 0
    }
}
#hotif

; **----------------------------Functions-----------------------------------------------------
tmpTooltip(msg) {
    tooltip msg
    SetTimer () => ToolTip(), -5000
}
inCode() {
    return wingetprocessname("A") == "Code.exe"
}
isDoubleClick(key) {
    return A_priorHotkey == key && A_timeSincePriorHotkey < 200
}
SendLoop(key) {
    global
    ; isShift := key.startswith("+")
    ; !艹还是用Blind好用哈哈
    ; if (SubStr(key, 1, 1) = "+") {
    ;     ; key := key[1:]
    ;     key := SubStr(key, 2)
    ;     Send "{Shift down}"
    ; }
    ; if(SubStr(key, 1, 1) = "^") {
    ;     key := SubStr(key, 2)
    ;     Send "{Alt down}"
    ; }
    send key
    times := mod(times, 1000) - 1
    loop times
        send key
    ; send "{" key " " times "}"
    ; !emm好像效果和用Loop差不多……
    times := 0
    ; if(isShift){
    Send "{Shift up}"
    ; Send "{Alt up}"
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
