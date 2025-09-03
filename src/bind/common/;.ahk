#Requires AutoHotkey v2.0
#Include ../../util/send.ahk
#Include ../../util/windows.ahk

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
