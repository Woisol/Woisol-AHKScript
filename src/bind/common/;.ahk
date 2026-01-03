#Requires AutoHotkey v2.0
#Include ../../util/send.ahk
#Include ../../util/windows.ahk

; @section-;
`;::;
'::'
`; & q:: handleLongPress("q", () => SendText('*'), () => Send('{Raw}^'))
`; & w:: handleLongPress("w", () => SendText('#'), () => Send('~'))
`; & e:: handleLongPress("e", () => SendText('>'), () => Send('"'))
`; & a:: handleLongPress("a", () => SendText('+'), () => Send('='))
`; & s:: handleLongPress("s", () => SendText('-'), () => Send('_'))
`; & d:: handleLongPress("d", () => SendText('/'), () => Send('\'))
`; & z:: handleLongPress("z", () => SendText('$'), () => Send('@'))
`; & x::%
`; & c:: handleLongPress("c", () => SendText('&'), () => Send('|'))

; `; & q:: SendText('*')
; ' & q:: Send('{Raw}^')
; `; & w:: SendText('#')
; ' & w:: Send('~')
; `; & e:: SendText('>')
; ' & e:: Send('"')
; `; & a:: SendText('+')
; ' & a:: Send('=')
; `; & s:: SendText('-')
; ' & s:: Send('_')
; `; & d:: SendText('/')
; ' & d:: Send('\')
; `; & z:: SendText('$')
; ' & z:: Send('@')
; `; & x::%
; `; & c:: SendText('&')
; ' & c:: Send('|')

`; & j:: Send "^v"

`; & r:: {
  if (inCode()) {
    SendText "("
    return
  }
  ; handleShortLongPress("r", () => Send("^c(){Left}"), () => Send("{Raw})"))
  Send("^c(){Left}")
}
' & r:: Send("{Raw})")
`; & f:: {
  if (inCode()) {
    SendText "["
    return
  }
  ; handleShortLongPress("f", () => (Send("^c"), SendText("[]"), Send("{Left}")), () => SendText("]"))
  (Send("^c"), SendText("[]"), Send("{Left}")
  )
}
' & f:: SendText("]")
`; & v:: {
  if (inCode()) {
    SendText "{"
    return
  }
  ; handleShortLongPress("v", () => (Send("^c"), SendText("{}"), Send("{Left}")), () => SendText("}"))
  (Send("^c"), SendText("{}"), Send("{Left}")
  )
}
' & v:: SendText("}")
`; & t:: handleLongPress("t", () => ((inCode() && Send("^c")), Send("'")), () => Send('{Raw}"'))
`; & g:: handleLongPress("g", () => Send("?"), () => Send('{Raw}!'))
`; & b:: {
  if (inCode()) {
    SendText "<"
    return
  }
  ; handleShortLongPress("b", () => (Send("^c"), SendText("<>"), Send("{Left}")), () => Send(">"))
  (Send("^c"), SendText("<>"), Send("{Left}")
  )
}
' & b:: SendText(">")
+9:: {
  if (inCode())
    Send "("
  else
    Send "(){Left}"
}
[:: handleLongPress("[", () => (inCode() ? SendText("[") : (SendText("[]"), Send("{Left}"))), () => Send("["))
+[:: {
  if (inCode())
    SendText "{"
  else
    Send "{{}{}}{Left}"
}
