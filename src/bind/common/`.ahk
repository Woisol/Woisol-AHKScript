#Requires AutoHotkey v2.0
#Include ../../util/send.ahk

`::`
` & 1:: handleLongPress("1", () => RestoreWindowPos(1), () => SaveWindowPos(1), LONG_PRESS_TIME_L_STR)
` & 2:: handleLongPress("2", () => RestoreWindowPos(2), () => SaveWindowPos(2), LONG_PRESS_TIME_L_STR)
` & 3:: handleLongPress("3", () => RestoreWindowPos(3), () => SaveWindowPos(3), LONG_PRESS_TIME_L_STR)
` & 4:: handleLongPress("4", () => RestoreWindowPos(4), () => SaveWindowPos(4), LONG_PRESS_TIME_L_STR)
` & 5:: handleLongPress("5", () => RestoreWindowPos(5), () => SaveWindowPos(5), LONG_PRESS_TIME_L_STR)