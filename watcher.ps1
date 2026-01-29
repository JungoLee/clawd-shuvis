# 슈비스 로그 와처 (Shuvis Log Watcher)
$logPath = "C:\tmp\clawdbot\clawdbot-$(Get-Date -Format 'yyyy-MM-dd').log"
$dashboardPath = "C:\Users\tough\clawd\canvas\index.html"
$patterns = "rate_limit_error", "429", "insufficient_quota", "usage limit"

Write-Host "🛡️ 슈비스 와처가 가동되었습니다. 로그 감시 중..." -ForegroundColor Cyan
Write-Host "감시 로그: $logPath" -ForegroundColor Gray

# 로그 파일이 없으면 생성될 때까지 대기
while (-not (Test-Path $logPath)) {
    Write-Host "로그 파일을 기다리는 중..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
}

# 로그 파일 끝에서부터 실시간 감시
Get-Content $logPath -Wait -Tail 0 | ForEach-Object {
    $line = $_
    foreach ($pattern in $patterns) {
        if ($line -like "*$pattern*") {
            Write-Host "⚠️ 사용량 초과 감지! 대시보드를 엽니다: $pattern" -ForegroundColor Red
            Start-Process $dashboardPath
            break
        }
    }
}
