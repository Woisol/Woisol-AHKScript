#Requires AutoHotkey v2.0

tmpTooltip(msg) {
  ToolTip msg
  SetTimer () => ToolTip(), -5000
  ; MsgBox msg
}
