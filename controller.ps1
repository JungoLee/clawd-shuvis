# Simple Shuvis Controller
Add-Type -AssemblyName System.Windows.Forms
$f = New-Object System.Windows.Forms.Form
$f.Text = 'Shuvis Model Controller'
$f.Size = New-Object System.Drawing.Size(300, 420)
$f.StartPosition = 'CenterScreen'
$f.BackColor = '#1e293b'
$f.TopMost = $true

$l = New-Object System.Windows.Forms.Label
$l.Text = 'Select Model'
$l.ForeColor = 'White'
$l.TextAlign = 'MiddleCenter'
$l.Size = New-Object System.Drawing.Size(260, 50)
$l.Location = New-Object System.Drawing.Point(10, 20)
$f.Controls.Add($l)

$b1 = New-Object System.Windows.Forms.Button
$b1.Text = '⚡ Gemini 3 Flash'
$b1.Location = New-Object System.Drawing.Point(30, 80)
$b1.Size = New-Object System.Drawing.Size(240, 60)
$b1.BackColor = '#38bdf8'
$b1.ForeColor = 'White'
$b1.Add_Click({ 
    clawdbot gateway config.patch '{"agents":{"defaults":{"model":{"primary":"google-antigravity/gemini-3-flash"}}}}'
    $l.Text = 'Done: Flash'
})
$f.Controls.Add($b1)

$b2 = New-Object System.Windows.Forms.Button
$b2.Text = '🧠 Gemini 1.5 Pro'
$b2.Location = New-Object System.Drawing.Point(30, 160)
$b2.Size = New-Object System.Drawing.Size(240, 60)
$b2.BackColor = '#4ade80'
$b2.ForeColor = 'White'
$b2.Add_Click({ 
    clawdbot gateway config.patch '{"agents":{"defaults":{"model":{"primary":"google-antigravity/gemini-1.5-pro"}}}}'
    $l.Text = 'Done: Pro'
})
$f.Controls.Add($b2)

$b3 = New-Object System.Windows.Forms.Button
$b3.Text = '🎨 Claude 3.5 Sonnet'
$b3.Location = New-Object System.Drawing.Point(30, 240)
$b3.Size = New-Object System.Drawing.Size(240, 60)
$b3.BackColor = '#fb923c'
$b3.ForeColor = 'White'
$b3.Add_Click({ 
    clawdbot gateway config.patch '{"agents":{"defaults":{"model":{"primary":"anthropic/claude-sonnet-4-5"}}}}'
    $l.Text = 'Done: Sonnet'
})
$f.Controls.Add($b3)

[void]$f.ShowDialog()
