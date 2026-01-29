# 슈비스 시스템 컨트롤러 (Shuvis System Controller)
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "🤖 슈비스 모델 컨트롤러"
$form.Size = New-Object System.Drawing.Size(300, 400)
$form.StartPosition = "CenterScreen"
$form.BackColor = "#1e293b"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.Text = "전환할 모델을 선택하세요"
$label.ForeColor = "White"
$label.Font = New-Object System.Drawing.Font("Malgun Gothic", 12, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(280, 40)
$label.TextAlign = "MiddleCenter"
$label.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($label)

function Change-Model($modelId, $modelName) {
    $label.Text = "⏳ 전환 중: $modelName"
    $label.ForeColor = "#38bdf8"
    
    # 시스템 명령 직접 실행 (진짜 자동!)
    $json = '{"agents":{"defaults":{"model":{"primary":"' + $modelId + '"}}}}'
    clawdbot gateway config.patch $json
    
    $label.Text = "✅ 전환 완료: $modelName"
    $label.ForeColor = "#4ade80"
}

# 버튼 생성 함수
function Create-Button($text, $color, $y, $modelId) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $text
    $btn.Size = New-Object System.Drawing.Size(240, 60)
    $btn.Location = New-Object System.Drawing.Point(30, $y)
    $btn.BackColor = $color
    $btn.ForeColor = "White"
    $btn.FlatStyle = "Flat"
    $btn.Font = New-Object System.Drawing.Font("Malgun Gothic", 10, [System.Drawing.FontStyle]::Bold)
    $btn.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btn.Add_Click({ Change-Model $modelId $text })
    $form.Controls.Add($btn)
}

# 모델 버튼들
Create-Button "⚡ Gemini 3 Flash" "#38bdf8" 80 "google-antigravity/gemini-3-flash"
Create-Button "🧠 Gemini 1.5 Pro" "#4ade80" 160 "google-antigravity/gemini-1.5-pro"
Create-Button "🎨 Claude 3.5 Sonnet" "#fb923c" 240 "anthropic/claude-sonnet-4-5"

$status = New-Object System.Windows.Forms.Label
$status.Text = "준비됨 (시스템 직결)"
$status.ForeColor = "#94a3b8"
$status.Size = New-Object System.Drawing.Size(280, 30)
$status.TextAlign = "MiddleCenter"
$status.Location = New-Object System.Drawing.Point(10, 320)
$form.Controls.Add($status)

[void]$form.ShowDialog()
