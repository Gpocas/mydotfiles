# Requisitos:
# -------------------------------------------------------
#    PowerShellGet 2.2.5
#       Install-Module -Name PowerShellGet -Force
#       Exit
# -------------------------------------------------------
#    PSReadLine 2.2.6
#       Install-Module PSReadLine -AllowPrerelease -Force
# --------------------------------------------------------
#    posh-git
#    Terminal-Icons
# --------------------------------------------------------

# Importação de Modulos
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Configurando o PowerShell para UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Iniciando Terminal com o tema (oh-my-posh: takuya)
# $omp_config = Join-Path $PSScriptRoot "./takuya.omp.json"
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# iniciando o startship 
Invoke-Expression (&starship init powershell)

# Configurações do PSReadLine
Set-PSReadLineOption -BellStyle none
Set-PSReadlineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Incluido novos alias
new-alias ipy ipython
new-alias e explorer
new-alias gcd Get-Clipboard
new-alias scd Set-Clipboard
new-alias fsl Invoke-FuzzySetLocation 

# Removendo alias existentes
Remove-Item alias:\where -Force

# Funções 
function pshell() {
    poetry shell
}

function pnew ([string]$arg) {
    poetry new "$arg" | Out-Null
    Set-Location .\$arg
    Write-Host " ✅ Projeto criado com sucesso!" -ForegroundColor green 
}

function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}