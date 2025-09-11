#Requires AutoHotkey v2.0
#Include ../../util/send.ahk

`::`
` & 1:: {
  handleShortLongPress("1", () => RestoreWindowPos(1), () => SaveWindowPos(1))
}
` & 2:: {
  handleShortLongPress("2", () => RestoreWindowPos(2), () => SaveWindowPos(2))
}
` & 3:: {
  handleShortLongPress("3", () => RestoreWindowPos(3), () => SaveWindowPos(3))
}
` & 4:: {
  handleShortLongPress("4", () => RestoreWindowPos(4), () => SaveWindowPos(4))
}
` & 5:: {
  handleShortLongPress("5", () => RestoreWindowPos(5), () => SaveWindowPos(5))
}
