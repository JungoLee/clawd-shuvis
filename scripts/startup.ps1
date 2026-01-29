# 슈비스 통합 자동 시작 스크립트 (Shuvis Auto-Startup)

Write-Host "🚀 슈비스 시스템을 가동합니다..." -ForegroundColor Green

# 1. 게이트웨이 시작 (이미 켜져 있으면 스킵)
Write-Host "1️⃣ 게이트웨이 확인 중..." -ForegroundColor Cyan
if (-not (Get-Process "node" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*clawdbot*gateway*" })) {
    Write-Host "   게이트웨이를 시작합니다..." -ForegroundColor Gray
    Start-Process "clawdbot" -ArgumentList "gateway", "start" -WindowStyle Hidden
    Start-Sleep -Seconds 5
} else {
    Write-Host "   게이트웨이가 이미 실행 중입니다." -ForegroundColor Gray
}

# 2. 슈비스 웹 대시보드 열기
Write-Host "2️⃣ 웹 대시보드를 엽니다..." -ForegroundColor Cyan
Start-Process "http://127.0.0.1:18789"

# 3. 슈비스 와처 실행
Write-Host "3️⃣ 와처를 가동합니다..." -ForegroundColor Cyan
$watcherPath = Join-Path $PSScriptRoot "watcher.ps1"
Start-Process "powershell" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$watcherPath`"" -WindowStyle Minimized

# 4. 슈비스 모델 컨트롤러 실행 (진짜 자동 전환기)
Write-Host "4️⃣ 모델 컨트롤러를 가동합니다..." -ForegroundColor Cyan
$controllerPath = Join-Path $PSScriptRoot "controller.ps1"
Start-Process "powershell" -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$controllerPath`"" -WindowStyle Normal


Write-Host "✅ 모든 시스템이 정상적으로 가동되었습니다!" -ForegroundColor Green
Start-Sleep -Seconds 3
