; **
; * 24-08-02 得以实现关闭窗口功能，继续完善了Normal模式下的其它按键功能，重构，使用了函数
; * 24-09-18 修改了括号包含选中的逻辑，修复了双击无法输出右括号的问题
; * 24-10-07 重置逻辑，现在默认输入模式，在输入模式中加入了
global mode := 0
global times := 0
global active := true

; #define doubleClickInterval 200
; #hotif active=true
; !并不能嵌套hotif
; !Capslock::{
;     if(getkeystate("Capslock")=1)
;     setcapslockstate(0)
;     else
;     setcapslockstate(1)
; }
; **----------------------------Actived Common-----------------------------------------------------
#hotif active = true
!+':: {
    global
    active := false
    tmpTooltip("Deactived")
}

; click:=false
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
; 这个无效了…………
; Capslock & a::send "#"
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

3 & u::7
3 & i::8
3 & o::9
3 & j::4
3 & k::5
3 & l::6
3 & n::1
3 & m::1
3 & ,::2
3 & .::3
3 & space::0

`;::;
`; & q:: {
    ; 08-10初步完成符号设计
    ; 08-15真正实现双击，饶了使用keywait的弯路
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

`; & space:: {
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
        ; clipSaved := ClipboardAll()
        ; A_clipboard := ""
        ; send "^c"
        ; clipwait 0.2

        ; selectText := A_clipboard
        ; ; selectText:=editgetselectedtext("A")

        send "^c"
        send "("
        send ")"
        send "{left}"
        ; send "^v"
        ; sendtext selectText

        ; A_clipboard := clipSaved
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
        send "{"
        send "}"
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
        send '{Right}{BackSpace}{BackSpace}'
        send '"'
        send '"'
        send "{left}"
    } else {
        send "^c"
        send "'"
        send "'"
        send "{left}"
    }
}
`; & g:: {
    if (isDoubleClick('; & g'))
        send '{BackSpace}{raw}!'
    ; sendtext 和 send '{raw}'的区别还是有的……{raw}依然是击键所以可以输出中文
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
    ; 08-17 From FT
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
; !V2没有#if…………
; ！啊啊啊绕远路了啊啊啊啊啊
{
    a:: SendLoop("{home}")
    +a:: SendLoop("+{home}")
    s:: SendLoop("{left}")
    +s:: SendLoop("+{left}")
    !s:: SendLoop("!{left}")
    d:: SendLoop("{down}")
    +d:: SendLoop("+{down}")
    !d:: SendLoop("!{down}")
    f:: SendLoop("{right}")
    +f:: SendLoop("+{right}")
    !f:: SendLoop("!{right}")
    e:: SendLoop("{up}")
    +e:: SendLoop("+{up}")
    !e:: SendLoop("!{up}")
    ; g::{
    ;     global
    ;     send "{end}"
    ;     loop times - 1
    ;         send "{end}"
    ;     times:=0
    ; }
    w:: SendLoop("^{left}")
    +w:: SendLoop("^+{left}")
    r:: SendLoop("^{right}")
    +r:: {
        SendLoop("^+{right}")
    }
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
            ; title:=
            ; !针对code特殊化处理
            ; if(instr(wingettitle("A"),"code")){
            if (inCode()) {
                send "^g"
                if (times = 0)
                    sendtext "1"
                else
                    sendtext times
                send "{enter}"
                ; return
            } else {
                send "^{home}"
                times := mod(times, 1000)
                loop times - 1
                    send "{down}"
            }
            times := 0
        } else {
            ; keywait "g"
            send "{end}"
            ; SendLoop("{end}")
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
    ; ^y::^y
    q:: {
        if (isDoubleClick("q")) {
            ; title:=""
            ; wingetactivetitle title
            ; winget "active", title
            ; winclose(title, id)
            winclose "A"
            ;  wingettitle("A")
        } else {
            send "^w"
        }
    }
    +q::^+t

    ; //**----------------------------Others-----------------------------------------------------
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
            ; if(isDoubleClick("n")){
            ;     send  "!+{down}"
            ; }
            ; else{
            send "^!{up}"
            ; }
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

    ; .::
    ; {
    ;     activeWindow := WinGetTitle("A")

    ;     WinGetPos &x, &y, &width, &height, activeWindow

    ;     MouseGetPos &mouseX, &mouseY

    ;     newX := mouseX - width / 2
    ;     newY := mouseY - height / 2

    ;     WinMove newX, newY, , , activeWindow
    ; }

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
        global ;这个声明必须放到最上面……
        ; if(isDoubleClick("esc")){
        tmpTooltip("Back to Insert Mode")
        mode := 0
        times := 0
        ; }
        ; else{
        ;     keywait "esc"
        ;     send "{esc}"
        ; }
    }

}
#hotif
; **----------------------------Insert Mode-----------------------------------------------------
#hotif mode = 0 && active = true
{

    .::.
    . & a::home
    . & s::left
    . & d::down
    . & f::right
    . & e::up
    . & g:: {
        global
        if (isDoubleClick(". & g")) {
            ; title:=
            ; !针对code特殊化处理
            ; if(instr(wingettitle("A"),"code")){
            if (inCode()) {
                send "^g"
                if (times = 0)
                    sendtext "1"
                else
                    sendtext times
                send "{enter}"
                ; return
            } else {
                send "^{home}"
                times := mod(times, 1000)
                loop times - 1
                    send "{down}"
            }
            times := 0
        } else {
            ; keywait "g"
            send "{end}"
            ; SendLoop("{end}")
        }

    }
    . & w::^left
    . & r::^right
    . & x::esc
    . & c::BackSpace
    ; . & + & c::^BackSpace
    . & v::^BackSpace
    . & /::^/
    ^+k:: {
        if (inCode()) {
            send "^+k"
            return
        }
        send "{home}{home}+{end}{BackSpace}{BackSpace}"
    }
    ^l:: {
        if (!inCode())
            send "{home}+{end}"
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
        if (times = 0)
            send "^{home}"
        else
            times *= 10
    }
    ; +0:: send "^{end}"

    . & Space:: {
        global ;这个声明必须放到最上面……
        ; if(isDoubleClick("esc")){
        tmpTooltip("Sticked to Normal Mode")
        mode := 1
        times := 0
        ; }
        ; else{
        ;     keywait "esc"
        ;     send "{esc}"
        ; }
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
    send key
    times := mod(times, 1000)
    loop times - 1
        send key
    times := 0
}
; #hotif
; #hotif active=false
;     !+;::active:=true
;     tmpTooltip("Actived")
; #hotif

;**----------------------------旧方案1-----------------------------------------------------

; a::
; {
;     global
;     if(mode=0)
;         send "{Home}"
;     else
;         send "{text}a" ; 使用{text}又会导致无法输入中文……
;     return
; }
; s::
; {
;     global
;     if(mode=0)
;         send "{left}"
;     else
;     send "{text}s" ;艹自己调用自己了……
;     return
; }
; d::
; {
;     global
;     if(mode=0)
;         send "{down}"
;     else
;         send "{text}d"
;     return
; }
; f::
; {
;     global
;     if(mode=0)
;         send "{right}"
;     else
;         send "{text}f"
;     return
; }
; e::
; {
;     global
;     if(mode=0)
;         send "{up}"
;     else
;         send "{text}e"
;     return
; }
; g::
; {
;     global
;     if(mode=0)
;         send "{End}"
;     else
;         send "{text}g"
;     return
; }
; w::
; {
;     global
;     if(mode=0)
;         send "^{left}"
;     else
;         send "{text}w"
;     return
; }
; r::
; {
;     global
;     if(mode=0)
;         send "^{right}"
;     else
;         send "{text}r"
;     return
; }

; iPress := false
; i::{
;     global
;     if(mode=0){
;         mode:=1
;     }
;     else{
;         send "{text}i"
;     }
; }
; escPress := false
; esc::{
;     global
;     if (escPress)
;         return ;啊啊不能同一行写不然报错需要space……这个ahk的报错信息怎么都看不懂啊喂
;     mode:=0
;     escPress := true
;     send "{esc}"
;     escPress := false
;     return
; }

; i::
; {
;     hotkey "a", "off"
; }

; getMode(){
;     return mode
; }

; #if mode=0
; {
;     ; log mode
; }
; #if

; 动态绑定必须要用hotkey
; hotkey "a",send "{home}"
; hotkey "s",send "{left}"
; hotkey "d",send "{down}"
; hotkey "f",send "{right}"
; hotkey "e",send "{up}"
; hotkey "g",send "{end}"
; hotkey "w",send "{^left}"
; hotkey "r",send "{^right}"

; i::
; {
;     ; global mode := !mode ;可以直接用!切换01，没有=，都是用:=
;     ; msgbox mode is %mode%
;     ; log mode
;     hotkey "a",off
;     hotkey "s",off
;     hotkey "d",off
;     hotkey "f",off
;     hotkey "e",off
;     hotkey "g",off
;     hotkey "w",off
;     hotkey "r",off
;     ; hotkey a,toggle
;     ; hotkey a,toggle

; }

; Capslock & a::send "#"
; Capslock & s::send "#1" ;注意必须要空格！注释也是……
; Capslock & d::send "#2"
; Capslock & f::send "#3"
; Capslock & g::send "#4"
; Capslock & h::send "#5"
