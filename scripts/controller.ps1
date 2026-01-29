# Shuvis Cyberpunk Controller
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$f = New-Object System.Windows.Forms.Form
$f.Text = 'SHUVIS_OS // MODEL_CONTROL'
$f.Size = New-Object System.Drawing.Size(320, 520)
$f.StartPosition = 'CenterScreen'
$f.BackColor = '#050505' # Deep Black
$f.FormBorderStyle = 'FixedDialog'
$f.TopMost = $true

# Header Decoration
$pTop = New-Object System.Windows.Forms.Panel
$pTop.Size = New-Object System.Drawing.Size(320, 5)
$pTop.BackColor = '#fde047' # Cyberpunk Yellow
$pTop.Location = New-Object System.Drawing.Point(0, 0)
$f.Controls.Add($pTop)

$l = New-Object System.Windows.Forms.Label
$l.Text = 'SYSTEM_OVERRIDE'
$l.ForeColor = '#fde047'
$l.Font = New-Object System.Drawing.Font('Consolas', 14, [System.Drawing.FontStyle]::Bold)
$l.Size = New-Object System.Drawing.Size(300, 40)
$l.TextAlign = 'MiddleCenter'
$l.Location = New-Object System.Drawing.Point(0, 30)
$f.Controls.Add($l)

$sLabel = New-Object System.Windows.Forms.Label
$sLabel.Text = '>>> SELECT_TARGET_MODEL'
$sLabel.ForeColor = '#06b6d4' # Neon Cyan
$sLabel.Font = New-Object System.Drawing.Font('Consolas', 9)
$sLabel.Size = New-Object System.Drawing.Size(300, 20)
$sLabel.TextAlign = 'MiddleCenter'
$sLabel.Location = New-Object System.Drawing.Point(0, 70)
$f.Controls.Add($sLabel)

# Function to update model
$change = {
    param($id, $name, $color)
    $sLabel.Text = ">>> INITIALIZING: $name"
    $sLabel.ForeColor = '#fde047'
    $f.Refresh()
    
    $payload = '{"agents":{"defaults":{"model":{"primary":"' + $id + '"}}}}'
    & clawdbot gateway config.patch $payload
    
    $sLabel.Text = ">>> ACCESS_GRANTED: $name"
    $sLabel.ForeColor = $color
}

# Cyberpunk Button Helper
function Add-CyberBtn($text, $y, $color, $modelId) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text = "[ $text ]"
    $b.Location = New-Object System.Drawing.Point(30, $y)
    $b.Size = New-Object System.Drawing.Size(250, 60)
    $b.FlatStyle = 'Flat'
    $b.ForeColor = $color
    $b.BackColor = '#050505'
    $b.FlatAppearance.BorderColor = $color
    $b.FlatAppearance.BorderSize = 2
    $b.Font = New-Object System.Drawing.Font('Consolas', 10, [System.Drawing.FontStyle]::Bold)
    $b.Cursor = [System.Windows.Forms.Cursors]::Hand
    $b.Add_Click({ &$change $modelId $text $color })
    $f.Controls.Add($b)
}

Add-CyberBtn 'FLASH.v3' 110 '#06b6d4' 'google-antigravity/gemini-3-flash'
Add-CyberBtn 'PRO.v3' 190 '#10b981' 'google-antigravity/gemini-3-pro'
Add-CyberBtn 'SONNET.4.5' 270 '#ec4899' 'anthropic/claude-sonnet-4-5'
Add-CyberBtn 'OPUS.4.5' 350 '#8b5cf6' 'google-antigravity/claude-opus-4-5-thinking'

# Footer
$footer = New-Object System.Windows.Forms.Label
$footer.Text = "SHUVIS_OS_v2.0 // AUTH: JUNGO"
$footer.ForeColor = "#334155"
$footer.Font = New-Object System.Drawing.Font('Consolas', 7)
$footer.Size = New-Object System.Drawing.Size(300, 20)
$footer.TextAlign = 'MiddleCenter'
$footer.Location = New-Object System.Drawing.Point(0, 440)
$f.Controls.Add($footer)

[void]$f.ShowDialog()
