# 슈비스 통합 설정 스크립트 (Shuvis Easy Setup)

Write-Host "🛠️ 슈비스(Shuvis) 자동 설정 및 검증을 시작합니다..." -ForegroundColor Cyan

# 1. 경로 설정
$currentDir = $PSScriptRoot
$startupScript = Join-Path $currentDir "startup.ps1"
$windowsStartupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")
$shortcutPath = Join-Path $windowsStartupFolder "Shuvis_AutoStart.lnk"

# 2. 필수 도구 확인
Write-Host "`n1️⃣ 필수 도구 확인 중..." -ForegroundColor White
$tools = @("git", "node", "npm", "clawdbot")
foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Host "  ✅ $tool : 설치됨" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $tool : 찾을 수 없음 (설치가 필요합니다)" -ForegroundColor Red
    }
}

# 3. 윈도우 시작프로그램 등록
Write-Host "`n2️⃣ 윈도우 시작 시 자동 실행 설정..." -ForegroundColor White
try {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = "powershell.exe"
    $Shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$startupScript`""
    $Shortcut.WorkingDirectory = $currentDir
    $Shortcut.Save()
    Write-Host "  ✅ 완료: 다음 부팅부터 슈비스가 자동으로 인사합니다!" -ForegroundColor Green
} catch {
    Write-Host "  ❌ 실패: 시작프로그램 등록 중 오류 발생" -ForegroundColor Red
}

# 4. 설정 파일 검증
Write-Host "`n3️⃣ 설정 파일 확인 중..." -ForegroundColor White
$files = @("IDENTITY.md", "MEMORY.md", "SOUL.md", "canvas\index.html", "watcher.ps1")
foreach ($f in $files) {
    $p = Join-Path $currentDir $f
    if (Test-Path $p) {
        Write-Host "  ✅ $f : 존재함" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $f : 유실됨!" -ForegroundColor Red
    }
}

Write-Host "`n✨ 모든 설정이 완료되었습니다! 이제 마음껏 슈비스를 사용하세요." -ForegroundColor Cyan
Write-Host "💡 팁: 이제 컴퓨터를 켤 때마다 슈비스가 자동으로 준비됩니다." -ForegroundColor Gray
Pause
