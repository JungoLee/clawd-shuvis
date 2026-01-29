# Minimal Shuvis Controller
Add-Type -AssemblyName System.Windows.Forms
$f = New-Object System.Windows.Forms.Form
$f.Text = 'Shuvis Control'
$f.Size = New-Object System.Drawing.Size(300, 500)
$f.StartPosition = 'CenterScreen'
$f.TopMost = $true

$l = New-Object System.Windows.Forms.Label
$l.Text = 'Select Model'
$l.Size = New-Object System.Drawing.Size(260, 50)
$l.Location = New-Object System.Drawing.Point(10, 20)
$l.TextAlign = 'MiddleCenter'
$f.Controls.Add($l)

$btns = @(
    @('⚡ Gemini 3 Flash', 'google-antigravity/gemini-3-flash', '#38bdf8'),
    @('🧠 Gemini 3 Pro', 'google-antigravity/gemini-3-pro', '#4ade80'),
    @('🎨 Claude 4.5 Sonnet', 'anthropic/claude-sonnet-4-5', '#fb923c'),
    @('🔮 Claude 4.5 Opus', 'google-antigravity/claude-opus-4-5-thinking', '#a855f7')
)

$y = 80
foreach ($b in $btns) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $b[0]
    $btn.Location = New-Object System.Drawing.Point(30, $y)
    $btn.Size = New-Object System.Drawing.Size(240, 60)
    $btn.BackColor = $b[2]
    $btn.ForeColor = 'White'
    $btn.FlatStyle = 'Flat'
    $btn.Font = New-Object System.Drawing.Font('Malgun Gothic', 9, [System.Drawing.FontStyle]::Bold)
    $btn.Add_Click({
        param($s, $e)
        $m = $this.Tag
        $label = $f.Controls | Where-Object { $_ -is [System.Windows.Forms.Label] }
        $label.Text = 'Applying...'
        & clawdbot gateway config.patch ('{"agents":{"defaults":{"model":{"primary":"' + $m + '"}}}}')
        $label.Text = 'Applied!'
    })
    $btn.Tag = $b[1]
    $f.Controls.Add($btn)
    $y += 80
}

[void]$f.ShowDialog()
