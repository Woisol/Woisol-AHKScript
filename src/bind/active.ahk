#Requires AutoHotkey v2.0
#Include ../util/notify.ahk

global active := true

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
  Send "!+;" ; WGesture
  Send "^{F12}"
}
