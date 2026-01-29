# 슈비스 로그 와처 (Shuvis Log Watcher) - 초강력 버전
$logDir = "C:\tmp\clawdbot"
$controllerPath = Join-Path $PSScriptRoot "controller.bat"
$patterns = @("rate_limit_error", "429", "insufficient_quota", "usage limit")

Write-Host "🛡️ 슈비스 와처 가동 시작 (에러 시 컨트롤러 자동 팝업)" -ForegroundColor Cyan

# 최신 로그 파일 찾기
function Get-LatestLog {
    return Get-ChildItem -Path $logDir -Filter "clawdbot-*.log" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

$currentLog = Get-LatestLog
if ($null -eq $currentLog) {
    Write-Host "❌ 로그 파일을 찾을 수 없습니다. 대기 중..." -ForegroundColor Yellow
    while ($null -eq $currentLog) {
        Start-Sleep -Seconds 5
        $currentLog = Get-LatestLog
    }
}

Write-Host "🔍 감시 중인 로그: $($currentLog.FullName)" -ForegroundColor Gray

# 실시간 감시 루프
Get-Content $currentLog.FullName -Wait -Tail 1 | ForEach-Object {
    $line = $_
    foreach ($p in $patterns) {
        if ($line.Contains($p)) {
            Write-Host "⚠️ [$p] 감지! 컨트롤러를 실행합니다." -ForegroundColor Red
            Start-Process -FilePath $controllerPath -WindowStyle Normal
            break
        }
    }
}
