# 슈비스 시스템 컨트롤러 (Shuvis System Controller)
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Shuvis Model Controller"
$form.Size = New-Object System.Drawing.Size(300, 420)
$form.StartPosition = "CenterScreen"
$form.BackColor = "#1e293b"
$form.FormBorderStyle = "FixedDialog"
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.Text = "전환할 모델을 선택하세요"
$label.ForeColor = "White"
$label.Font = New-Object System.Drawing.Font("Malgun Gothic", 12, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(260, 50)
$label.TextAlign = "MiddleCenter"
$label.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($label)

function Run-Change($id, $name) {
    $label.Text = "⏳ $name 전환 중..."
    $label.ForeColor = "#38bdf8"
    $form.Refresh()
    
    # JSON 파싱 오류를 피하기 위해 단순화된 명령 호출
    $arg = '{"agents":{"defaults":{"model":{"primary":"' + $id + '"}}}}'
    Start-Process -FilePath "clawdbot" -ArgumentList "gateway", "config.patch", "'$arg'" -WindowStyle Hidden
    
    $label.Text = "✅ $name 완료!"
    $label.ForeColor = "#4ade80"
}

# 버튼 1
$btn1 = New-Object System.Windows.Forms.Button
$btn1.Text = "⚡ Gemini 3 Flash"
$btn1.Location = New-Object System.Drawing.Point(30, 80)
$btn1.Size = New-Object System.Drawing.Size(240, 60)
$btn1.BackColor = "#38bdf8"
$btn1.ForeColor = "White"
$btn1.FlatStyle = "Flat"
$btn1.Font = New-Object System.Drawing.Font("Malgun Gothic", 10, [System.Drawing.FontStyle]::Bold)
$btn1.Add_Click({ Run-Change "google-antigravity/gemini-3-flash" "Flash" })
$form.Controls.Add($btn1)

# 버튼 2
$btn2 = New-Object System.Windows.Forms.Button
$btn2.Text = "🧠 Gemini 1.5 Pro"
$btn2.Location = New-Object System.Drawing.Point(30, 160)
$btn2.Size = New-Object System.Drawing.Size(240, 60)
$btn2.BackColor = "#4ade80"
$btn2.ForeColor = "White"
$btn2.FlatStyle = "Flat"
$btn2.Font = New-Object System.Drawing.Font("Malgun Gothic", 10, [System.Drawing.FontStyle]::Bold)
$btn2.Add_Click({ Run-Change "google-antigravity/gemini-1.5-pro" "Pro" })
$form.Controls.Add($btn2)

# 버튼 3
$btn3 = New-Object System.Windows.Forms.Button
$btn3.Text = "🎨 Claude 3.5 Sonnet"
$btn3.Location = New-Object System.Drawing.Point(30, 240)
$btn3.Size = New-Object System.Drawing.Size(240, 60)
$btn3.BackColor = "#fb923c"
$btn3.ForeColor = "White"
$btn3.FlatStyle = "Flat"
$btn3.Font = New-Object System.Drawing.Font("Malgun Gothic", 10, [System.Drawing.FontStyle]::Bold)
$btn3.Add_Click({ Run-Change "anthropic/claude-sonnet-4-5" "Sonnet" })
$form.Controls.Add($btn3)

$form.ShowDialog()
