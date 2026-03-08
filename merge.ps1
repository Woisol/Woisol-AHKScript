# merge.ps1 - 将多个 AHK 文件合并为一个单 AHK 文件
# 用法: .\merge.ps1 [-Entry src\app.ahk] [-Output dist\app.ahk] [-KeepComments] [-ShowMarkers]
#
# 默认行为：去除源文件注释，不显示 #Include 边界标记
# -KeepComments  保留源文件中的 ; 注释
# -ShowMarkers   在每个文件前后插入 ; === FILE: ... === 标记

param(
    [string]$Entry        = "src\app.ahk",
    [string]$Output       = "dist\app.merged.ahk",
    [switch]$KeepComments,   # 保留源文件注释（默认去除）
    [switch]$ShowMarkers     # 显示文件边界标记（默认不显示）
)

$rootDir    = $PSScriptRoot
$entryFile  = Join-Path $rootDir $Entry
$outputFile = Join-Path $rootDir $Output

# ── 阶段一：深度优先遍历，收集文件顺序（每个文件只出现一次）──────────────────
$fileOrder = [System.Collections.Generic.List[string]]::new()
$fileSet   = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

function Collect-Order {
    param([string]$filePath)
    $absPath = [System.IO.Path]::GetFullPath($filePath)
    if (-not $fileSet.Add($absPath)) { return }
    $fileOrder.Add($absPath) | Out-Null

    $dir   = [System.IO.Path]::GetDirectoryName($absPath)
    $lines = Get-Content -LiteralPath $absPath -Encoding UTF8
    foreach ($line in $lines) {
        $trimmed = $line.TrimStart()
        if ($trimmed -match '^#Include\s+(?:\*i\s+)?(.+)$') {
            $p = $Matches[1].Trim()
            if ($p -match '^%') { continue }
            $resolved = [System.IO.Path]::GetFullPath((Join-Path $dir $p))
            if (Test-Path -LiteralPath $resolved -PathType Leaf) {
                Collect-Order -filePath $resolved
            }
        }
    }
}

# ── 字符串感知的行内注释剥离 ──────────────────────────────────────────────────
# 跳过 "..." 内的内容，遇到前置空格的 ; 时截断
function Strip-InlineComment {
    param([string]$line)
    $inString = $false
    $i = 0
    while ($i -lt $line.Length) {
        $c = $line[$i]
        if ($inString) {
            if ($c -eq '"') {
                if ($i + 1 -lt $line.Length -and $line[$i + 1] -eq '"') {
                    $i += 2; continue
                }
                $inString = $false
            }
        } else {
            if ($c -eq '"') {
                $inString = $true
            } elseif ($c -eq ';' -and $i -gt 0 -and $line[$i - 1] -eq ' ') {
                return $line.Substring(0, $i).TrimEnd()
            }
        }
        $i++
    }
    return $line
}

# ── 阶段二：按收集顺序平坦输出每个文件 ────────────────────────────────────────
function Merge-All {
    $requiresSeen = $false
    $out = [System.Collections.Generic.List[string]]::new()

    foreach ($file in $script:fileOrder) {
        $relPath = $file.Replace($script:rootDir + '\', '').Replace($script:rootDir + '/', '')

        if ($ShowMarkers) { $out.Add("; ======== $relPath ========") }

        $lines = Get-Content -LiteralPath $file -Encoding UTF8
        foreach ($line in $lines) {
            $trimmed = $line.TrimStart()

            # 去除全行注释
            if (-not $KeepComments -and $trimmed -match '^;') { continue }

            # #Requires 全局只保留一条
            if ($trimmed -match '^#Requires\b') {
                if (-not $requiresSeen) {
                    $requiresSeen = $true
                    $out.Add($line)
                }
                continue
            }

            # #Include 已被展开，跳过
            if ($trimmed -match '^#Include\b') { continue }

            # 去除行内注释
            if (-not $KeepComments) {
                $line = Strip-InlineComment $line
                if ($line -eq '') { continue }
            }

            $out.Add($line)
        }

        if ($ShowMarkers) { $out.Add("; ======== end $relPath ========") }
    }

    return $out
}

# ── 执行 ──────────────────────────────────────────────────────────────────────
$outputDir = [System.IO.Path]::GetDirectoryName($outputFile)
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

Write-Host "Collecting includes: $entryFile"
Collect-Order -filePath $entryFile

Write-Host "Files to merge: $($fileOrder.Count)"
$fileOrder | ForEach-Object { Write-Host "  $_" }

$merged = Merge-All
$merged | Set-Content -LiteralPath $outputFile -Encoding UTF8

Write-Host "Output:      $outputFile"
Write-Host "Total lines: $($merged.Count)"
