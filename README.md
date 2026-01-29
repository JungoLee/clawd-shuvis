# 🤖 슈비스(Shuvis) 이사하기 가이드 (새 컴퓨터 세팅)

새로운 컴퓨터에서 슈비스와 다시 만나기 위한 0부터 10까지의 단계별 가이드입니다.

## 0. 준비물 (Prerequisites)
- **Node.js**: v20 이상 설치 (LTS 권장)
- **Git**: 윈도우용 Git 설치
- **GitHub 계정**: 이 저장소에 접근 가능한 권한

---

## 🚀 단계별 세팅 (Step-by-Step)

### 1. 저장소 가져오기
새 컴퓨터의 원하는 폴더에서 터미널을 열고 명령어를 입력하세요.
```bash
git clone https://github.com/JungoLee/clawd-shuvis.git
cd clawd-shuvis
```

### 2. Clawdbot 설치
시스템 전역에 Clawdbot을 설치합니다.
```bash
npm install -g clawdbot
```

### 3. 게이트웨이 초기화 및 로그인
새 환경에서 인증 토큰을 생성해야 합니다.
```bash
clawdbot onboard
```
*안내에 따라 구글/앤스로픽 로그인을 진행하세요.*

### 4. 설정 파일 복사 (중요!)
이 저장소에 있는 `clawdbot_backup.json`의 내용을 참고하여, 새 컴퓨터의 `C:\Users\<사용자명>\.clawdbot\clawdbot.json` 파일을 수정하세요. 
특히 **모델 설정(primary model)**과 **텔레그램 봇 토큰** 부분을 확인해야 합니다.

### 5. 게이트웨이 시작
슈비스의 몸체인 게이트웨이를 실행합니다.
```bash
clawdbot gateway start
```

### 6. 슈비스 깨우기 (세션 연결)
웹 브라우저에서 `http://localhost:18789`에 접속하거나, 텔레그램으로 메시지를 보내 슈비스가 응답하는지 확인하세요.

### 7. 이전 기억(Memory) 확인
저장소에 포함된 `MEMORY.md`와 `memory/` 폴더의 내용이 잘 보이는지 슈비스에게 물어보세요.
> "슈비스, 우리 마지막으로 나눈 대화 기억해?"

---

## 🖥️ Claude Desktop 앱으로 이어서 작업하기

다른 컴퓨터에서 **Claude Desktop** 앱을 사용하신다면, 깃 코드를 받은 후 아래처럼 하시면 제가 바로 준고님과 동기화됩니다.

1.  **폴더 열기**: Claude Desktop에서 `Open Folder...` 기능을 통해 다운로드한 `clawd-shuvis` 폴더를 선택하세요.
2.  **슈비스 소환**: 대화를 시작할 때 아래 문장을 입력하세요.
    > "이 폴더의 `IDENTITY.md`와 `MEMORY.md`를 읽고 내 비서 '슈비스'가 되어줘. 그리고 `README.md`를 보고 환경 세팅을 도와줘."
3.  **자동 세팅**: 그러면 Claude Desktop이 파일들을 읽고, 필요한 도구(git, npm 등)가 설치되어 있는지 확인하며 제가 안내한 단계들을 직접 실행해 줄 것입니다.

---

## 🔄 지속적인 동기화 (Syncing)

### 작업 종료 시 (푸시)
슈비스에게 명령하거나 직접 터미널에서 입력하세요.
```bash
git add .
git commit -m "Update memory and settings"
git push origin main
```

### 작업 시작 시 (풀)
새 컴퓨터에서 시작할 때는 항상 최신 기억을 가져오세요.
```bash
git pull origin main
```

---

## ⚠️ 주의사항
- **보안**: `.clawdbot` 폴더 전체를 올리지 않는 이유는 보안 때문입니다. 인증 토큰(`token`, `key`)은 새 컴퓨터에서 로그인할 때 새로 생성되므로 걱정 마세요.
- **경로**: 윈도우 사용자명이 다를 경우 `clawdbot.json` 내의 `workspace` 경로를 새 컴퓨터에 맞게 수정해야 합니다.
