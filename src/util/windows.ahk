#Requires AutoHotkey v2.0
#Include notify.ahk
#Include ../constant/time.ahk

inCode() {
  win := WinGetProcessName("A")
  switch (WinGetProcessName("A")) {
    ; !不会像C那样连续……
    case "Code.exe": return 1
    case "Trae CN.exe": return 1
    case "idea64.exe": return 1
    case "devenv.exe": return 1
    case "微信开发者工具.exe": return 1
    default: return 0
  }
}

global lastWinSizeV := Map()  ; 存储竖向调整的原始大小
global lastWinSizeH := Map()  ; 存储横向调整的原始大小
global lastWinTimer := 0
FillWindows(vertical := 1, margin := 20, deleteDelay := 0) {
  global
  activeWin := WinGetID("A")
  WinGetPos(&x, &y, &w, &h, activeWin)
  monitorNum := _MonitorFromWindow(activeWin)
  MonitorGetWorkArea(monitorNum, &left, &top, &right, &bottom)

  sizeMap := vertical ? lastWinSizeV : lastWinSizeH

  if (sizeMap.Has(activeWin)) {
    origSize := sizeMap[activeWin]
    if (vertical = 1 && y = top + margin && h = bottom - top - margin) {
      WinMove(origSize.x, origSize.y, origSize.w, origSize.h, activeWin)
      sizeMap.Delete(activeWin)
      return
    } else if (vertical = 0 && x = left + margin && w = right - left - margin * 2) {
      WinMove(origSize.x, origSize.y, origSize.w, origSize.h, activeWin)
      sizeMap.Delete(activeWin)
      return
    }
  }

  ; 存储当前窗口原始尺寸
  sizeMap[activeWin] := { x: x, y: y, w: w, h: h }
  lastWinTimer := A_TickCount

  ; 调整窗口大小
  if (vertical = 1) {
    WinMove(x, top + margin, w, bottom - top - margin, activeWin)
  } else {
    WinMove(left + margin, y, right - left - margin * 2, h, activeWin)
  }

  ; 清除存储的尺寸
  if (deleteDelay != 0)
    SetTimer(() =>
      sizeMap.Has(activeWin) ?
        sizeMap.Delete(activeWin) : ""
    , -deleteDelay)
  ; if (vertical = 1) {
  ;     WinMove(x, top + margin, w, bottom - top - margin * 2, activeWin)
  ; } else {
  ;     WinMove(left + margin, y, right - left - margin * 2, h, activeWin)
  ; }
}

; -4,-4,2568,1400
global processPosList := Map(
  "Code.exe", Map(
    1, [20, 20, 900, 1390],
    2, [20, 20, 1600, 1390],
    3, [940, 20, 1600, 1390],
    4, [-1580, -332, 1560, 1246]
  ),
  "msedge.exe", Map(
    1, [20, 20, 1300, 1390],
    2, [-1580, -332, 1560, 1246]
  ),
  "AFFiNE-beta.exe", Map(
    1, [20, 20, 1300, 1390],
    2, [1248, 20, 1300, 1390],
    3, [-1577, 914, 1560, 1246]
  ),
  "Notion.exe", Map(
    1, [20, 20, 1300, 1390],
    2, [1248, 20, 1300, 1390],
    3, [-1577, 914, 1560, 1246]
  ),
  "Figma.exe", Map(
    1, [20, 20, 1300, 1390],
    2, [1248, 20, 1300, 1390],
    3, [-1577, 914, 1560, 1246]
  ),
  "navicat.exe", Map(
    1, [1243, 595, 1300, 800],
    2, [-1577, 1363, 1300, 800],
    3, [-1580, -332, 1560, 1246]
  ),
  "lx-music-desktop.exe", Map(
    1, [-828, 1633, 828, 540],
    2, [-1577, 914, 1560, 1246]
  ),
  "cloudmusic.exe", Map(
    1, [-828, 1633, 828, 540],
    2, [-1577, 914, 1560, 1246]
  ),
  "Clash Verge.exe", Map(
    1, [-1600, 1519, 780, 640]
  ),
  "Weixin.exe", Map(
    1, [-750, -332, 730, 650],
    2, [1250, 200, 1270, 1080]
  ),
  "QQ.exe", Map(
    1, [-1577, -332, 730, 650],
    2, [60, 200, 1270, 1080]
  ),
  "WXWork.exe", Map(
    1, [-1577, 318, 986, 650],
    2, [400, 200, 1270, 1080]
  ),
  "Feishu.exe", Map(
    1, [-920, 318, 900, 768],
    2, [400, 200, 1800, 1080]
  ),
  "explorer.exe", Map(
    1, [-933, 990, 936, 633],
    2, [60, 200, 1270, 1080]
  )
)

; 保存当前窗口位置和尺寸到指定槽位
SaveWindowPos(index) {
  global processPosList
  activeWin := WinGetID("A")
  processName := WinGetProcessName(activeWin)

  ; 获取窗口位置和尺寸
  WinGetPos(&x, &y, &w, &h, activeWin)

  ; 初始化进程映射（如果不存在）
  if (!processPosList.Has(processName)) {
    processPosList[processName] := Map()
  }

  ; 保存到指定槽位 [x, y, width, height]
  processPosList[processName][index] := [x, y, w, h]

  tmpTooltip("已将 " . processName . " 保存到槽位 " . index)
  OutputDebug(processName . ": " . x . "," . y . "," . w . "," . h)
}

; 从指定槽位恢复窗口位置和尺寸
RestoreWindowPos(index) {
  global processPosList
  activeWin := WinGetID("A")
  processName := WinGetProcessName(activeWin)

  ; 检查进程和槽位是否存在
  if (!processPosList.Has(processName)) {
    tmpTooltip("进程 " . processName . " 没有保存的位置信息")
    return false
  }

  if (!processPosList[processName].Has(index)) {
    tmpTooltip("槽位 " . index . " 没有保存的位置信息")
    return false
  }

  ; 获取保存的位置信息
  pos := processPosList[processName][index]
  x := pos[1]
  y := pos[2]
  w := pos[3]
  h := pos[4]

  ; 恢复窗口位置和尺寸
  WinMove(x, y, w, h, activeWin)

  tmpTooltip("已从槽位 " . index . " 恢复 " . processName . " 位置")
  return true
}

_MonitorFromWindow(winHandle) {
  ; static monitorCoords := Map()

  ; 只在第一次运行或显示器配置改变时获取显示器信息
  ;! 由于操作不频繁，还是每次检测防止稳定出现无法检测显示器的问题
  ; if (monitorCoords.Count = 0) {
  WinGetPos(&winX, &winY, &winW, &winH, winHandle)
  centerX := winX + winW / 2
  centerY := winY + winH / 2
  loop MonitorGetCount() {
    MonitorGet(A_Index, &l, &t, &r, &b)
    if (centerX >= l && centerX <= r
      && centerY >= t && centerY <= b) {
      return A_Index
    }
  }
  ; }

  ; 查找匹配的显示器
  return 1
}
