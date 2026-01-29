# SHUVIS // CYBER_CITY_EDITION // v4.0
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$scriptPath = $PSScriptRoot
$bgImage = Join-Path (Get-Item $scriptPath).Parent.FullName "screenshot\image.png"

$f = New-Object System.Windows.Forms.Form
$f.Text = 'SHUVIS_OS // NEURAL_LINK_v4'
$f.Size = New-Object System.Drawing.Size(350, 550)
$f.StartPosition = 'CenterScreen'
$f.BackColor = '#0a0a1a'
$f.FormBorderStyle = 'FixedDialog'
$f.TopMost = $true

# Load City Background if exists
if (Test-Path $bgImage) {
    try {
        $img = [System.Drawing.Image]::FromFile($bgImage)
        $f.BackgroundImage = $img
        $f.BackgroundImageLayout = 'Stretch'
    } catch {}
}

# Dark Purple Overlay & Gradient
$f.add_Paint({
    param($s, $e)
    $rect = $f.ClientRectangle
    # Semi-transparent gradient overlay for 'Night City' vibe
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        $rect,
        [System.Drawing.Color]::FromArgb(180, 20, 10, 40), # Deep Purple (Transparent)
        [System.Drawing.Color]::FromArgb(220, 5, 5, 15),   # Near Black
        90.0
    )
    $e.Graphics.FillRectangle($brush, $rect)
    
    # Neon Border
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 139, 92, 246), 4) # Purple Neon
    $e.Graphics.DrawRectangle($pen, 2, 2, $f.ClientSize.Width - 4, $f.ClientSize.Height - 4)
    
    $brush.Dispose()
    $pen.Dispose()
})

# Header
$l = New-Object System.Windows.Forms.Label
$l.Text = 'SHUVIS_OS'
$l.ForeColor = '#fde047' # Cyber Yellow
$l.BackColor = 'Transparent'
$l.Font = New-Object System.Drawing.Font('Consolas', 20, [System.Drawing.FontStyle]::Bold)
$l.Size = New-Object System.Drawing.Size(330, 50)
$l.TextAlign = 'MiddleCenter'
$l.Location = New-Object System.Drawing.Point(0, 40)
$f.Controls.Add($l)

$sLabel = New-Object System.Windows.Forms.Label
$sLabel.Text = '>>> CONNECTION_STABLE'
$sLabel.ForeColor = '#06b6d4' # Cyan
$sLabel.BackColor = 'Transparent'
$sLabel.Font = New-Object System.Drawing.Font('Consolas', 9)
$sLabel.Size = New-Object System.Drawing.Size(330, 20)
$sLabel.TextAlign = 'MiddleCenter'
$sLabel.Location = New-Object System.Drawing.Point(0, 90)
$f.Controls.Add($sLabel)

# Robust Command Function
$change = {
    param($id, $name, $c1, $c2)
    $sLabel.Text = ">>> PATCHING_NEURAL: $name"
    $sLabel.ForeColor = '#fde047'
    $f.Refresh()
    
    $json = '{\"agents\":{\"defaults\":{\"model\":{\"primary\":\"' + $id + '\"}}}}'
    Start-Process -FilePath "clawdbot" -ArgumentList "gateway", "config.patch", "`"$json`"" -WindowStyle Hidden
    
    $sLabel.Text = ">>> $name : LINK_ESTABLISHED"
    $sLabel.ForeColor = $c1
}

# Advanced Gradient Button Helper
function Add-GradientBtn($text, $y, $c1, $c2, $modelId) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text = "$text"
    $b.Location = New-Object System.Drawing.Point(45, $y)
    $b.Size = New-Object System.Drawing.Size(260, 65)
    $b.FlatStyle = 'Flat'
    $b.ForeColor = 'White'
    $b.BackColor = [System.Drawing.Color]::FromArgb(100, 0, 0, 0)
    $b.FlatAppearance.BorderSize = 0
    $b.Font = New-Object System.Drawing.Font('Consolas', 11, [System.Drawing.FontStyle]::Bold)
    $b.Cursor = [System.Windows.Forms.Cursors]::Hand
    
    # Custom Paint for Button Gradient
    $b.add_Paint({
        param($s, $e)
        $btnRect = $b.ClientRectangle
        $btnBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            $btnRect,
            [System.Drawing.Color]::TranslateFromHtml($c1),
            [System.Drawing.Color]::TranslateFromHtml($c2),
            0.0
        )
        $e.Graphics.FillRectangle($btnBrush, $btnRect)
        
        # Draw Text manually for better look over gradient
        $sf = New-Object System.Drawing.StringFormat
        $sf.Alignment = 'Center'
        $sf.LineAlignment = 'Center'
        $e.Graphics.DrawString($b.Text, $b.Font, [System.Drawing.Brushes]::White, $btnRect, $sf)
        
        # Neon Glow Effect around button
        $glowPen = New-Object System.Drawing.Pen([System.Drawing.Color]::TranslateFromHtml($c1), 2)
        $e.Graphics.DrawRectangle($glowPen, 0, 0, $b.Width - 1, $b.Height - 1)
        
        $btnBrush.Dispose()
        $glowPen.Dispose()
    })

    $b.Add_Click({ &$change $modelId $text $c1 $c2 })
    $f.Controls.Add($b)
}

# Models with Vibrant Purple/Neon Gradients
Add-GradientBtn 'GEMINI_FLASH' 130 '#38bdf8' '#818cf8' 'google-antigravity/gemini-3-flash'
Add-GradientBtn 'GEMINI_PRO' 210 '#10b981' '#34d399' 'google-antigravity/gemini-3-pro'
Add-GradientBtn 'CLAUDE_SONNET' 290 '#ec4899' '#f472b6' 'anthropic/claude-sonnet-4-5'
Add-GradientBtn 'CLAUDE_OPUS' 370 '#8b5cf6' '#a78bfa' 'google-antigravity/claude-opus-4-5-thinking'

# Footer
$footer = New-Object System.Windows.Forms.Label
$footer.Text = "SYSTEM.TERMINAL // AUTH_KEY_ACCEPTED"
$footer.ForeColor = "#475569"
$footer.BackColor = 'Transparent'
$footer.Font = New-Object System.Drawing.Font('Consolas', 7)
$footer.Size = New-Object System.Drawing.Size(330, 20)
$footer.TextAlign = 'MiddleCenter'
$footer.Location = New-Object System.Drawing.Point(0, 470)
$f.Controls.Add($footer)

[void]$f.ShowDialog()
