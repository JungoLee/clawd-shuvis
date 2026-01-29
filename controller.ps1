# Shuvis System Controller - Ultra Robust Version
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = '슈비스 모델 컨트롤러'
$form.Size = New-Object System.Drawing.Size(300, 420)
$form.StartPosition = 'CenterScreen'
$form.BackColor = '#1e293b'
$form.FormBorderStyle = 'FixedDialog'
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.Text = '전환할 모델을 선택하세요'
$label.ForeColor = 'White'
$label.Font = New-Object System.Drawing.Font('Malgun Gothic', 12, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(280, 50)
$label.TextAlign = 'MiddleCenter'
$label.Location = New-Object System.Drawing.Point(10, 20)
$form.Controls.Add($label)

# Logic using simple strings
$scriptBlock = {
    param($mId, $mName, $lbl)
    $lbl.Text = "⏳ 전환 중: $mName"
    $lbl.ForeColor = '#38bdf8'
    
    $payload = '{"agents":{"defaults":{"model":{"primary":"' + $mId + '"}}}}'
    Invoke-Expression "clawdbot gateway config.patch '$payload'"
    
    $lbl.Text = "✅ 완료: $mName"
    $lbl.ForeColor = '#4ade80'
}

# Button Creation
$btn1 = New-Object System.Windows.Forms.Button
$btn1.Text = '⚡ Gemini 3 Flash'
$btn1.Location = New-Object System.Drawing.Point(30, 80)
$btn1.Size = New-Object System.Drawing.Size(240, 60)
$btn1.BackColor = '#38bdf8'
$btn1.ForeColor = 'White'
$btn1.FlatStyle = 'Flat'
$btn1.Add_Click({ &$scriptBlock 'google-antigravity/gemini-3-flash' 'Gemini 3 Flash' $label })
$form.Controls.Add($btn1)

$btn2 = New-Object System.Windows.Forms.Button
$btn2.Text = '🧠 Gemini 1.5 Pro'
$btn2.Location = New-Object System.Drawing.Point(30, 160)
$btn2.Size = New-Object System.Drawing.Size(240, 60)
$btn2.BackColor = '#4ade80'
$btn2.ForeColor = 'White'
$btn2.FlatStyle = 'Flat'
$btn2.Add_Click({ &$scriptBlock 'google-antigravity/gemini-1.5-pro' 'Gemini 1.5 Pro' $label })
$form.Controls.Add($btn2)

$btn3 = New-Object System.Windows.Forms.Button
$btn3.Text = '🎨 Claude 3.5 Sonnet'
$btn3.Location = New-Object System.Drawing.Point(30, 240)
$btn3.Size = New-Object System.Drawing.Size(240, 60)
$btn3.BackColor = '#fb923c'
$btn3.ForeColor = 'White'
$btn3.FlatStyle = 'Flat'
$btn3.Add_Click({ &$scriptBlock 'anthropic/claude-sonnet-4-5' 'Claude 3.5 Sonnet' $label })
$form.Controls.Add($btn3)

$form.ShowDialog()
