# Shows a Windows toast for Claude Code Notification hook events. Reads hook JSON on stdin.
$ErrorActionPreference = 'SilentlyContinue'

$data = $null
try { $data = [Console]::In.ReadToEnd() | ConvertFrom-Json } catch {}

$cwd = if ($data -and $data.cwd) { [string]$data.cwd } else { (Get-Location).Path }
$projectName = Split-Path -Leaf $cwd.TrimEnd('\', '/')
$sid = if ($data -and $data.session_id) { [string]$data.session_id } else { '' }
if ($sid.Length -gt 8) { $sid = $sid.Substring(0, 8) }

# Session name (set via /rename or --name) lives in the transcript as the last custom-title entry.
$sessionName = ''
if ($data -and $data.session_name) { $sessionName = [string]$data.session_name }
elseif ($data -and $data.transcript_path -and (Test-Path -LiteralPath $data.transcript_path)) {
    $m = Select-String -LiteralPath $data.transcript_path -Pattern '"type":"custom-title"' -SimpleMatch | Select-Object -Last 1
    if ($m) { try { $sessionName = [string]($m.Line | ConvertFrom-Json).customTitle } catch {} }
}

$label = if ($sessionName) { $sessionName } else { $sid }
$title = "Claude Code" + if ($label) { " [$label]" } else { '' }
$body = "Claude At $projectName ($cwd)"

Function Esc([string]$s) { [System.Security.SecurityElement]::Escape($s) }

$toastXml = '<toast><visual><binding template="ToastGeneric">' +
    "<text>$(Esc $title)</text><text>$(Esc $body)</text>" +
    '</binding></visual><audio src="ms-winsoundevent:Notification.Default"/></toast>'

[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType=WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom, ContentType=WindowsRuntime] | Out-Null
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastXml)
$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$appId = 'powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)
