# Window section
Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = "Monitor"
$main_form.Width = 300
$main_form.Height = 400
$main_form.AutoSize = $true

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Sysmon Events"
$Label.Location  = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(280,10)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "Refresh"
$main_form.Controls.Add($Button)

$Results = New-Object System.Windows.Forms.TextBox
$Results.Location = New-Object System.Drawing.Size(0,50)
$Results.Size = New-Object System.Drawing.Size(400,400)
$Results.Multiline = $true
$Results.Text = "Waiting to start..."
$main_form.Controls.Add($Results)

Function Get-SysmonEvents () {
    $events = Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 25 | Select-Object -Property id,processid,timecreated,message
    return $events
}

# Event section
$Button.Add_Click({$Results.Text = Get-SysmonEvents | Out-String})

$main_form.ShowDialog()
