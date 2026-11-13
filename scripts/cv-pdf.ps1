# İngilizce CV'yi HTML kaynağından PDF'e çevirir (Chrome/Edge headless).
#   Kaynak: content\cv\Yasin_Ustun_CV_EN.html
#   Çıktı : assets\cv\Yasin_Ustun_CV_EN.pdf
#
# Kullanım (proje klasöründe):
#   powershell -ExecutionPolicy Bypass -File scripts\cv-pdf.ps1

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$src = Join-Path $root 'content\cv\Yasin_Ustun_CV_EN.html'
$out = Join-Path $root 'assets\cv\Yasin_Ustun_CV_EN.pdf'

if (-not (Test-Path $src)) { throw "Kaynak bulunamadı: $src" }

$candidates = @(
  (Join-Path $env:ProgramFiles 'Google\Chrome\Application\chrome.exe'),
  (Join-Path ${env:ProgramFiles(x86)} 'Google\Chrome\Application\chrome.exe'),
  (Join-Path $env:LOCALAPPDATA 'Google\Chrome\Application\chrome.exe'),
  (Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application\msedge.exe'),
  (Join-Path $env:ProgramFiles 'Microsoft\Edge\Application\msedge.exe')
)
$browser = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $browser) { throw 'Chrome veya Edge bulunamadı.' }

$tmpProfile = Join-Path $env:TEMP 'cv-pdf-profile'
$srcUri = ([System.Uri]$src).AbsoluteUri
$before = if (Test-Path $out) { (Get-Item $out).LastWriteTime } else { [datetime]::MinValue }

$chromeArgs = @(
  '--headless=new', '--disable-gpu', '--no-first-run', '--no-pdf-header-footer',
  "--user-data-dir=`"$tmpProfile`"", "--print-to-pdf=`"$out`"", $srcUri
)
$proc = Start-Process -FilePath $browser -ArgumentList $chromeArgs -Wait -PassThru -WindowStyle Hidden

if (-not (Test-Path $out) -or (Get-Item $out).LastWriteTime -le $before) {
  throw "PDF üretilemedi (çıkış kodu: $($proc.ExitCode))."
}

$sizeKb = [math]::Round((Get-Item $out).Length / 1KB)
Write-Host "Hazır: $out ($sizeKb KB)" -ForegroundColor Green
