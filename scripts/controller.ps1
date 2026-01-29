# SHUVIS // CYBER_CITY_EDITION // v4.3
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$scriptPath = $PSScriptRoot
$parentDir = (Get-Item $scriptPath).Parent.FullName
$screenshotDir = Join-Path $parentDir "screenshot"
$bgImage = Join-Path $screenshotDir "image.png"

$f = New-Object System.Windows.Forms.Form
$f.Text = 'SHUVIS_OS // NEURAL_LINK_v4.3'
$f.Size = New-Object System.Drawing.Size(350, 320)
$f.StartPosition = 'CenterScreen'
$f.BackColor = [System.Drawing.Color]::FromArgb(255, 10, 10, 26)
$f.FormBorderStyle = 'FixedDialog'
$f.TopMost = $true

# 배경 이미지 로드
if (Test-Path $bgImage) {
    try {
        $fileStream = New-Object System.IO.FileStream($bgImage, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
        $img = [System.Drawing.Image]::FromStream($fileStream)
        $fileStream.Close()
        $f.BackgroundImage = $img
        $f.BackgroundImageLayout = 'Stretch'
    } catch {}
}

# Dark Purple Overlay
$f.add_Paint({
    param($s, $e)
    try {
        $rect = $f.ClientRectangle
        if ($rect.Width -le 0 -or $rect.Height -le 0) { return }
        
        $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            $rect,
            [System.Drawing.Color]::FromArgb(180, 20, 10, 40),
            [System.Drawing.Color]::FromArgb(220, 5, 5, 15),
            90.0
        )
        $e.Graphics.FillRectangle($brush, $rect)
        
        $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 139, 92, 246), 4)
        $e.Graphics.DrawRectangle($pen, 2, 2, $f.ClientSize.Width - 4, $f.ClientSize.Height - 4)
        
        $brush.Dispose()
        $pen.Dispose()
    } catch {}
})

# Header
$l = New-Object System.Windows.Forms.Label
$l.Text = 'SHUVIS_OS'
$l.ForeColor = [System.Drawing.Color]::FromArgb(255, 253, 224, 71)
$l.BackColor = [System.Drawing.Color]::Transparent
$l.Font = New-Object System.Drawing.Font('Consolas', 20, [System.Drawing.FontStyle]::Bold)
$l.Size = New-Object System.Drawing.Size(330, 50)
$l.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$l.Location = New-Object System.Drawing.Point(0, 30)
$f.Controls.Add($l)

$sLabel = New-Object System.Windows.Forms.Label
$sLabel.Text = '>>> CONNECTION_STABLE'
$sLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 6, 182, 212)
$sLabel.BackColor = [System.Drawing.Color]::Transparent
$sLabel.Font = New-Object System.Drawing.Font('Consolas', 9)
$sLabel.Size = New-Object System.Drawing.Size(330, 20)
$sLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$sLabel.Location = New-Object System.Drawing.Point(0, 80)
$f.Controls.Add($sLabel)

# Model Change Function
$change = {
    param($id, $name, $c1, $c2)
    $sLabel.Text = ">>> PATCHING_NEURAL: $name"
    $sLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 253, 224, 71)
    $f.Refresh()
    
    try {
        $cmd = "clawdbot config set agents.defaults.model.primary '$id'"
        $process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $cmd" -WindowStyle Hidden -Wait -PassThru
        
        if ($process.ExitCode -eq 0) {
            $sLabel.Text = ">>> $name : PATCHED. RESTART REQUIRED."
            $sLabel.ForeColor = [System.Drawing.Color]::TranslateFromHtml($c1)
        } else {
            $sLabel.Text = ">>> ERR: EXIT_$($process.ExitCode)"
            $sLabel.ForeColor = [System.Drawing.Color]::Red
        }
    } catch {
        $sLabel.Text = ">>> EXCEPTION"
        $sLabel.ForeColor = [System.Drawing.Color]::Red
    }
}

# Restart Gateway Function
$restartGateway = {
    $sLabel.Text = ">>> REBOOTING_GATEWAY..."
    $sLabel.ForeColor = [System.Drawing.Color]::Orange
    $f.Refresh()
    try {
        Start-Process -FilePath "clawdbot" -ArgumentList "gateway", "restart" -WindowStyle Hidden
        $sLabel.Text = ">>> RESTART_SIGNAL_SENT"
        $sLabel.ForeColor = [System.Drawing.Color]::Lime
    } catch {
        $sLabel.Text = ">>> RESTART_FAILED"
        $sLabel.ForeColor = [System.Drawing.Color]::Red
    }
}

# Button Helper
function Add-GradientBtn($text, $y, $c1, $c2, $modelId, $isRestart = $false) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text = "$text"
    $b.Location = New-Object System.Drawing.Point(45, $y)
    $b.Size = New-Object System.Drawing.Size(260, 50)
    $b.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $b.ForeColor = [System.Drawing.Color]::White
    $b.BackColor = [System.Drawing.Color]::FromArgb(100, 0, 0, 0)
    $b.FlatAppearance.BorderSize = 0
    $b.Font = New-Object System.Drawing.Font('Consolas', 10, [System.Drawing.FontStyle]::Bold)
    $b.Cursor = [System.Windows.Forms.Cursors]::Hand
    
    $b.add_Paint({
        param($s, $e)
        try {
            $btnRect = $b.ClientRectangle
            if ($btnRect.Width -le 0 -or $btnRect.Height -le 0) { return }
            
            $btnBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
                $btnRect,
                [System.Drawing.Color]::TranslateFromHtml($c1),
                [System.Drawing.Color]::TranslateFromHtml($c2),
                0.0
            )
            $e.Graphics.FillRectangle($btnBrush, $btnRect)
            
            $sf = New-Object System.Drawing.StringFormat
            $sf.Alignment = [System.Drawing.StringAlignment]::Center
            $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
            $e.Graphics.DrawString($b.Text, $b.Font, [System.Drawing.Brushes]::White, $btnRect, $sf)
            
            $glowPen = New-Object System.Drawing.Pen([System.Drawing.Color]::TranslateFromHtml($c1), 2)
            $e.Graphics.DrawRectangle($glowPen, 0, 0, $b.Width - 1, $b.Height - 1)
            
            $btnBrush.Dispose()
            $glowPen.Dispose()
        } catch {}
    })

    if ($isRestart) {
        $b.Add_Click({ &$restartGateway })
    } else {
        $b.Add_Click({ &$change $modelId $text $c1 $c2 })
    }
    $f.Controls.Add($b)
}

# CLAUDE SONNET ONLY
Add-GradientBtn 'CLAUDE_SONNET' 120 '#ec4899' '#f472b6' 'anthropic/claude-sonnet-4-5'

# RESTART BUTTON
Add-GradientBtn '⚡ RESTART GATEWAY ⚡' 190 '#f59e0b' '#ef4444' '' $true

# Footer
$footer = New-Object System.Windows.Forms.Label
$footer.Text = "SYSTEM.TERMINAL // AUTH_KEY_ACCEPTED"
$footer.ForeColor = [System.Drawing.Color]::FromArgb(255, 71, 85, 105)
$footer.BackColor = [System.Drawing.Color]::Transparent
$footer.Font = New-Object System.Drawing.Font('Consolas', 7)
$footer.Size = New-Object System.Drawing.Size(330, 20)
$footer.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$footer.Location = New-Object System.Drawing.Point(0, 250)
$f.Controls.Add($footer)

[void]$f.ShowDialog()
