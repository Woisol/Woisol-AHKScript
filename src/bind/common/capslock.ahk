#Requires AutoHotkey v2.0
#Include ../../util/launch.ahk

; @section-CapsLock
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
CapsLock & q:: ActivateOrRun("D:/Social/QQ/QQ.exe", "QQ.exe", "^!q")
CapsLock & w:: ActivateOrRun("D:/Social/Weixin/Weixin.exe", "WeChat.exe", "^!w")
; CapsLock & e:: ActivateOrRun("explorer.exe", "explorer") ;基本无用
CapsLock & r:: ActivateOrRun("D:/Amusment/lx-music-desktop/lx-music-desktop.exe", "lx-music-desktop.exe", "!m")
CapsLock & t:: ActivateOrRun("wt", , , true, "D:/")
; 在 wt 中 ahk 会无法回收 CapsLock 的状态，暂时禁用窗口检测直接打开()
; CapsLock & t:: ActivateOrRun("WindowsTerminal.exe", "wt", , true)
CapsLock & s:: ActivateOrRun("C:/Users/Woisol-G/AppData/Local/AFFiNE-beta/AFFiNE-beta.exe", "AFFiNE-beta.exe")
CapsLock & d:: ActivateOrRun("C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe", "msedge.exe")
CapsLock & f:: ActivateOrRun("D:/Coding/VSCode/Code.exe", "Code.exe")
; CapsLock & g:: ActivateOrRun("D:/Coding/Trae CN/Trae CN.exe", "Trae CN.exe")
CapsLock & v:: ActivateOrRun("D:/Coding/Figma/Figma.exe", "Figma.exe")