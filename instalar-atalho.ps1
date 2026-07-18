# Cria um atalho na Area de Trabalho que abre o CRM Interali como se fosse um programa
# (janela sem barra de endereco do navegador), com icone proprio.

$AppUrl  = "https://interalibpofinanceiro-dotcom.github.io/crm-interali/"
$IconUrl = "https://interalibpofinanceiro-dotcom.github.io/crm-interali/INTERALICRMLEAD.ico"
$AppDir  = Join-Path $env:LOCALAPPDATA "InteraliCRM"
$IconPath = Join-Path $AppDir "INTERALICRMLEAD.ico"

if (-not (Test-Path $AppDir)) {
    New-Item -ItemType Directory -Path $AppDir -Force | Out-Null
}

try {
    Invoke-WebRequest -Uri $IconUrl -OutFile $IconPath -UseBasicParsing
} catch {
    Write-Host "Aviso: nao foi possivel baixar o icone, o atalho vai usar o icone padrao do navegador."
}

$EdgePath   = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

$Browser = $null
if (Test-Path $EdgePath) { $Browser = $EdgePath }
elseif (Test-Path $ChromePath) { $Browser = $ChromePath }

if ($null -eq $Browser) {
    Write-Host "Nao encontrei o Microsoft Edge nem o Google Chrome instalados."
    Write-Host "Instale um dos dois e rode este script de novo."
    Read-Host "Pressione ENTER para sair"
    exit 1
}

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "CRM Interali.lnk"

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $Browser
$Shortcut.Arguments = "--app=$AppUrl --window-size=1400,900"
if (Test-Path $IconPath) {
    $Shortcut.IconLocation = $IconPath
}
$Shortcut.Description = "CRM Interali - Pipeline de Leads"
$Shortcut.WorkingDirectory = $AppDir
$Shortcut.Save()

Write-Host ""
Write-Host "Pronto! Foi criado um atalho 'CRM Interali' na sua Area de Trabalho."
Write-Host "Basta dar 2 cliques nele para abrir o CRM como um programa."
Read-Host "Pressione ENTER para fechar"
