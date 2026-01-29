# 슈비스 로그 와처 (Shuvis Log Watcher) - 컨트롤러 연동형
$logDate = Get-Date -Format "yyyy-MM-dd"
$logPath = "C:\tmp\clawdbot\clawdbot-$logDate.log"
$controllerPath = Join-Path $PSScriptRoot "controller.bat"
$patterns = @("rate_limit_error", "429", "insufficient_quota", "usage limit")

Write-Host "🛡️ 슈비스 와처 가동 중... (에러 시 컨트롤러 팝업)" -ForegroundColor Cyan

# 로그 대기
while (!(Test-Path $logPath)) { Start-Sleep -Seconds 10 }

# 실시간 감시 및 컨트롤러 실행
Get-Content $logPath -Wait -Tail 1 | ForEach-Object {
    $line = $_
    foreach ($p in $patterns) {
        if ($line.Contains($p)) {
            Write-Host "⚠️ 사용량 초과 감지 ($p)! 컨트롤러를 실행합니다." -ForegroundColor Red
            Start-Process $controllerPath
            break
        }
    }
}
