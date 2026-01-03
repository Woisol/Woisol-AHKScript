#Requires AutoHotkey v2.0

isDoubleClick(key) {
  return A_PriorHotkey == key && A_TimeSincePriorHotkey < 200
}

handleLongPress(key, shortPressCallback, longPressCallback, longPressTime := LONG_PRESS_TIME_STR) {
  if (KeyWait(key, "T" . longPressTime)) {
    shortPressCallback()
  } else {
    longPressCallback()
  }
}

global times := 0
SendLoop(key) {
  global
  ; isShift := key.startswith("+")
  ; !艹还是用Blind好用哈哈
  ; if (SubStr(key, 1, 1) = "+") {
  ;     ; key := key[1:]
  ;     key := SubStr(key, 2)
  ;     Send "{Shift Down}"
  ; }
  ; if(SubStr(key, 1, 1) = "^") {
  ;     key := SubStr(key, 2)
  ;     Send "{Alt Down}"
  ; }
  Send key
  times := Mod(times, 1000) - 1
  loop times
    Send key
  ; Send "{" key " " times "}"
  ; !emm好像效果和用Loop差不多……
  times := 0
  ; hasOpt := true
  ; if(isShift){
  ; Send "{Shift Up}"
  ; Send "{Alt Up}"
  ; }
}
; SendLoopWithShift(key) {
;     global
;     if (GetKeyState("Shift", "T")) {
;         SendLoop("+" . key)
;     }
;     ; !az居然是用这个来拼接字符串的……
;     else
;         SendLoop(key)
; }

; 长按辅助函数 - 短按恢复位置，长按保存位置
; global pressStartTime := 0
; global currentSlotIndex := 0

; HandleKeyDown() {
;   global pressStartTime, currentSlotIndex
;   pressStartTime := A_TickCount
; }

; HandleKeyUp(shortPressCallback, longPressCallback) {
;   global pressStartTime
;   pressDuration := A_TickCount - pressStartTime

;   if (pressDuration >= LONG_PRESS_TIME_L) {
;     ; 长按 - 保存窗口位置
;     ; SaveWindowPos(currentSlotIndex)
;     longPressCallback()
;   } else {
;     ; 短按 - 恢复窗口位置
;     ; RestoreWindowPos(currentSlotIndex)
;     shortPressCallback()
;   }

;   pressStartTime := 0
; }
