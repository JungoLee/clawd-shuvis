# 🤖 슈비스(Shuvis) 이사하기 가이드 (새 컴퓨터 세팅)

새로운 컴퓨터에서 슈비스와 다시 만나기 위한 가이드입니다.

## 🚀 퀵 스타트 (한 번에 세팅하기)

새 컴퓨터에서 폴더를 내려받은 후, 터미널(PowerShell)에서 아래 명령어만 입력하면 **필수 도구 확인 + 자동 시작 등록 + 설정 검증**을 한 번에 진행합니다.

```powershell
# 1. 저장소 가져오기
git clone https://github.com/JungoLee/clawd-shuvis.git
cd clawd-shuvis

# 2. 자동 설정 스크립트 실행
powershell -ExecutionPolicy Bypass -File .\scripts\setup.ps1
```

---

## 🛠️ 폴더 구조 (Refactored)
- `scripts/`: 슈비스 가동에 필요한 핵심 스크립트 (setup, startup, watcher, controller)
- `docs/`: 사용자 가이드 및 문서
- `canvas/`: 모델 대시보드 웹 파일
- `memory/`: 일일 대화 로그
- `* .md`: 슈비스의 정체성 및 장기 기억 파일들

---

## 🖥️ Claude Desktop 앱 사용 시
폴더를 여는 즉시 **`CLAUDE.md`** 가이드에 따라 Claude가 자동으로 슈비스로 변신합니다. 그냥 "안녕 슈비스?"라고 말을 걸어보세요.

---

## 🔄 지속적인 동기화 (Syncing)
- **작업 시작 전**: `git pull origin main` (기억 가져오기)
- **작업 종료 후**: `git add . && git commit -m "update" && git push` (기억 저장하기)

---

## ⚠️ 주의사항
- **보안**: 텔레그램 토큰 등 민감 정보는 GitHub에 올리지 않습니다. (`.gitignore` 적용됨)
- **경로**: 컴퓨터마다 사용자명이 다를 경우 `clawdbot.json`의 `workspace` 경로를 수정해야 합니다.
