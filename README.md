# yasinustun.ustunsoft.com — Kişisel site başlangıç paketi

Bu klasör, kişisel CV sitemi Claude Code ile oluşturmak için hazırlandı.

## Nasıl kullanılır

1. Zip'i aç, klasörde terminal aç ve `claude` komutunu çalıştır.
2. Güncel CV `assets/cv/Yasin_Ustun_CV_TR.pdf` olarak hazır. CV değişirse aynı adla değiştir.
3. (İsteğe bağlı) Profil fotoğrafını `assets/img/profile.jpg` olarak koy.
4. `docs/ROADMAP.md` içindeki Faz 1 prompt'unu Claude Code'a yapıştır, fazları sırayla ilerlet.

## Klasörler

- `CLAUDE.md` — Claude Code'un her oturumda okuduğu proje kuralları
- `content/` — sitenin tek içerik kaynağı (TR ve EN). Bilgi değişirse önce burayı güncelle.
- `docs/ROADMAP.md` — fazlar ve hazır prompt'lar
- `assets/cv/` — indirilebilir CV PDF'leri
- `assets/img/` — profil fotoğrafı ve paylaşım görseli
- `scripts/paketle.ps1` — yayınlanacak dosyaları `_yayin/` klasörüne toplar

## Yayına alma (FileZilla / FTP)

1. Proje klasöründe: `powershell -ExecutionPolicy Bypass -File scripts\paketle.ps1`
2. FileZilla ile sunucuya bağlan, `yasinustun.ustunsoft.com` alt alan adının kök klasörüne gir
   (cPanel'de genellikle `public_html/yasinustun` veya `yasinustun.ustunsoft.com`).
3. Sunucudaki eski site dosyalarını yedekle (bilgisayarına indir), sonra sil.
   Özellikle eski `index.php` kalırsa sunucu yeni `index.html` yerine onu açabilir.
4. `_yayin/` klasörünün **içindekileri** (klasörün kendisini değil) sunucudaki köke sürükle.
5. Tarayıcıda `https://yasinustun.ustunsoft.com` ve `/en/` sayfasını aç, CV butonunu dene.
   Değişiklik görünmüyorsa Ctrl+F5 ile önbelleği atlayarak yenile.

CV güncellendiğinde: yeni PDF'i aynı adla `assets/cv/` içine koy, sadece o dosyayı
sunucuda `assets/cv/` klasörüne yeniden yükle.
