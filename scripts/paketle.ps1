# Yayınlanacak dosyaları _yayin\ klasörüne kopyalar.
# content/, docs/, scripts/ ve README dosyaları yayına dahil edilmez.
#
# Kullanım (proje klasöründe):
#   powershell -ExecutionPolicy Bypass -File scripts\paketle.ps1
# Sonra FileZilla'da _yayin\ klasörünün İÇİNDEKİLERİ sunucudaki site köküne sürükle.

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$out = Join-Path $root '_yayin'

$items = @(
  'index.html', 'en', 'css', 'js', 'assets',
  'favicon.svg', 'apple-touch-icon.png', 'robots.txt', 'sitemap.xml'
)

foreach ($item in $items) {
  if (-not (Test-Path (Join-Path $root $item))) { throw "Eksik dosya/klasör: $item" }
}

if (Test-Path $out) { Remove-Item $out -Recurse -Force }
New-Item -ItemType Directory -Path $out | Out-Null

foreach ($item in $items) {
  Copy-Item -Path (Join-Path $root $item) -Destination $out -Recurse
}

# Not dosyalarını çıkar
Get-ChildItem -Path $out -Recurse -File -Filter *.md | Remove-Item -Force

# CV kontrolü
$cvTr = Join-Path $out 'assets\cv\Yasin_Ustun_CV_TR.pdf'
if (-not (Test-Path $cvTr)) {
  Write-Warning 'assets\cv\Yasin_Ustun_CV_TR.pdf bulunamadı: CV indirme butonu kırık olur!'
}
if (Test-Path (Join-Path $out 'assets\cv\Yasin_Ustun_CV_EN.pdf')) {
  $enHtml = Get-Content (Join-Path $out 'en\index.html') -Raw
  if ($enHtml -notmatch 'Yasin_Ustun_CV_EN\.pdf') {
    Write-Warning 'İngilizce CV var ama en\index.html hâlâ TR PDF''e bağlı. Linkleri güncelle.'
  }
}

Write-Host ''
Write-Host "Hazır: $out" -ForegroundColor Green
Get-ChildItem -Path $out -Recurse -File | ForEach-Object { '  ' + $_.FullName.Substring($out.Length + 1) }
