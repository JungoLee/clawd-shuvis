Add-Type -AssemblyName 'System.Windows.Forms';
Add-Type -AssemblyName 'System.Drawing';

$f = New-Object System.Windows.Forms.Form;
$f.Text = 'Shuvis Model Controller';
$f.Size = New-Object System.Drawing.Size(300, 420);
$f.StartPosition = 'CenterScreen';
$f.BackColor = '#1e293b';
$f.TopMost = $true;

$l = New-Object System.Windows.Forms.Label;
$l.Text = 'Select Model';
$l.ForeColor = 'White';
$l.Size = New-Object System.Drawing.Size(260, 50);
$l.TextAlign = 'MiddleCenter';
$l.Location = New-Object System.Drawing.Point(10, 20);
$f.Controls.Add($l);

$u = {
    param($id, $n);
    $l.Text = "Switching to $n...";
    $l.ForeColor = '#38bdf8';
    $f.Refresh();
    $p = '{"agents":{"defaults":{"model":{"primary":"' + $id + '"}}}}';
    Invoke-Expression "clawdbot gateway config.patch '$p'";
    $l.Text = "Done: $n";
    $l.ForeColor = '#4ade80';
};

$a = {
    param($t, $c, $y, $id);
    $b = New-Object System.Windows.Forms.Button;
    $b.Text = $t;
    $b.Location = New-Object System.Drawing.Point(30, $y);
    $b.Size = New-Object System.Drawing.Size(240, 60);
    $b.BackColor = $c;
    $b.ForeColor = 'White';
    $b.FlatStyle = 'Flat';
    $b.Add_Click({ &$u $id $t });
    $f.Controls.Add($b);
};

&$a 'Gemini 3 Flash' '#38bdf8' 80 'google-antigravity/gemini-3-flash';
&$a 'Gemini 1.5 Pro' '#4ade80' 160 'google-antigravity/gemini-1.5-pro';
&$a 'Claude 3.5 Sonnet' '#fb923c' 240 'anthropic/claude-sonnet-4-5';

[void]$f.ShowDialog();
