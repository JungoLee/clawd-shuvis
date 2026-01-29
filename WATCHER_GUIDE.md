# 슈비스 와처 (Shuvis Watcher) 🛡️

이 스크립트는 슈비스(AI 모델)의 사용량이 초과되어 응답이 불가능한 상황을 실시간으로 감시합니다. 
에러가 감지되면 자동으로 **모델 대시보드**를 브라우저에 띄워 준고님이 즉시 다른 모델로 환승할 수 있게 돕습니다.

## 🛠️ 사용 방법

1.  **PowerShell**을 엽니다.
2.  작업 폴더(`C:\Users\tough\clawd`)로 이동합니다.
3.  아래 명령어를 입력하여 와처를 실행합니다.
    ```powershell
    .\watcher.ps1
    ```

## 🔍 감시 항목
- `rate_limit_error`: API 호출 횟수 초과
- `429`: 너무 많은 요청 (Rate Limit)
- `insufficient_quota`: 잔액 부족 등

## 💡 작동 원리
스크립트가 배경에서 `clawdbot` 로그 파일을 계속 읽다가, 위와 같은 에러 문구가 나타나면 즉시 `canvas/index.html` 파일을 기본 브라우저로 실행합니다.
