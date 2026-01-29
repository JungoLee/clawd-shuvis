# 슈비스 로그 와처 (Shuvis Log Watcher)
$logDate = Get-Date -Format "yyyy-MM-dd"
$logPath = "C:\tmp\clawdbot\clawdbot-$logDate.log"
$dashboardPath = "$PSScriptRoot\canvas\index.html"
$patterns = @("rate_limit_error", "429", "insufficient_quota", "usage limit")

Write-Host "🛡️ 슈비스 와처가 가동되었습니다. 로그 감시 중..." -ForegroundColor Cyan
Write-Host "감시 로그: $logPath" -ForegroundColor Gray

# 로그 파일 대기 루프
while (!(Test-Path $logPath)) {
    Write-Host "로그 파일을 기다리는 중... ($logPath)" -ForegroundColor Yellow
    Start-Sleep -Seconds 10
}

Write-Host "🚀 실시간 감시를 시작합니다." -ForegroundColor Green

# 로그 감시 루프
Get-Content $logPath -Wait -Tail 1 | ForEach-Object {
    $line = $_
    foreach ($p in $patterns) {
        if ($line.Contains($p)) {
            Write-Host "⚠️ 사용량 초과 감지 ($p)! 대시보드 팝업!" -ForegroundColor Red
            Start-Process $dashboardPath
            break
        }
    }
}
