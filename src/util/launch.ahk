#Requires AutoHotkey v2.0

ActivateOrRun(path, win_exe := "", shortcut := "", admin := false, working_dir := "") {
  ; ;!逻辑优化
  ; "ahk_exe "
  if (working_dir != "")
    SetWorkingDir working_dir
  if (ProcessExist(win_exe) || win_exe = "") {
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
