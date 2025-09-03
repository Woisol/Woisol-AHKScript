#Requires AutoHotkey v2.0
#Include ../../util/send.ahk

`::`
` & 1:: {
  HandleKeyDown(1)
  KeyWait "1"
  HandleKeyUp()
}
` & 2:: {
  HandleKeyDown(2)
  KeyWait "2"
  HandleKeyUp()
}
` & 3:: {
  HandleKeyDown(3)
  KeyWait "3"
  HandleKeyUp()
}
` & 4:: {
  HandleKeyDown(4)
  KeyWait "4"
  HandleKeyUp()
}
` & 5:: {
  HandleKeyDown(5)
  KeyWait "5"
  HandleKeyUp()
}
