# CLAUDE.md — yasinustun.ustunsoft.com

Bu dosya Claude Code için proje talimatıdır. Her oturumda önce bunu oku.

## Proje özeti

Yasin Üstün'ün (Senior .NET Developer) kişisel tanıtım ve CV sitesi.
Adres: **https://yasinustun.ustunsoft.com**

Amaç:
1. İşe alımcıların ve İK'nın 30 saniyede "kim, ne yapıyor, ne kadar deneyimli" sorularının cevabını alması
2. Güncel CV'nin tek tıkla indirilmesi (PDF)
3. LinkedIn ve e-posta ile iletişime yönlendirme

Hedef kitle: Türkiye'deki teknoloji İK'ları ve işe alım uzmanları (öncelikli), yurt dışındaki işe alımcılar (İngilizce sürüm).

## Teknik kurallar

- **Saf HTML + CSS + az miktarda vanilla JavaScript.** Framework yok, build adımı yok, npm bağımlılığı yok.
- Siteyi herhangi bir statik hostinge (cPanel/FTP, GitHub Pages, Netlify, Cloudflare Pages) dosyaları kopyalayarak yüklemek mümkün olmalı.
- Harici CDN kullanma. Font gerekiyorsa sistem font yığını kullan ya da fontu `assets/fonts/` altına self-host et.
- JavaScript kapalıyken de tüm içerik okunabilir olmalı. JS sadece küçük iyileştirmeler için (tema değiştirici, menü, yıl).
- Tek CSS dosyası: `css/style.css`. CSS değişkenleri (custom properties) ile renk, boşluk, tipografi token'ları.
- Erişilebilirlik: semantik HTML (`header`, `main`, `section`, `nav`, `footer`), başlık hiyerarşisi, alt metinler, klavye ile gezinme, görünür focus, WCAG AA kontrast.
- Hedef: Lighthouse Performance, Accessibility, Best Practices, SEO puanlarının hepsi 95+.

## Dil yapısı

- Türkçe ana sürüm: `/index.html` (`<html lang="tr">`)
- İngilizce sürüm: `/en/index.html` (`<html lang="en">`)
- İki sayfa birbirine `hreflang` ile bağlansın; header'da TR / EN geçiş linki olsun.
- İçerik JS ile çevrilmesin, iki ayrı statik HTML olsun (SEO için).
- İçerik kaynağı: `content/profile.tr.md` ve `content/profile.en.md`. Metinleri buradan al, kendin bilgi uydurma. Bu dosyalarda olmayan bir bilgi (rakam, şirket, tarih, teknoloji) siteye eklenmez.

## Sayfa bölümleri (tek sayfa, sırayla)

1. **Hero:** Ad, unvan ("Senior .NET Developer"), 1–2 cümlelik tanıtım, butonlar: "CV'yi indir" (birincil), "LinkedIn", "E-posta"
2. **Hakkımda:** Kısa paragraf + "uzmanlık alanları" 3 madde
3. **Deneyim:** Dikey zaman çizelgesi (timeline). Her kayıtta unvan, şirket, tarih aralığı, 2–4 madde. En yeni en üstte.
4. **Yetenekler:** Kategorilere ayrılmış etiketler (chip). Yüzde çubukları veya yıldız puanları KULLANMA.
5. **Projeler:** Kişisel projeler (Flutter, Unity)
6. **Eğitim ve Sertifikalar**
7. **İletişim:** E-posta (mailto), LinkedIn, CV indirme butonu tekrar
8. **Footer:** © yıl, ad

Sabit (sticky) üst menü: bölümlere çapa linkleri + TR/EN geçişi + tema düğmesi.

## CV indirme

- Dosyalar: `assets/cv/Yasin_Ustun_CV_TR.pdf` ve (varsa) `assets/cv/Yasin_Ustun_CV_EN.pdf`
- Buton `<a href="assets/cv/Yasin_Ustun_CV_TR.pdf" download>` şeklinde olsun. İngilizce sayfada EN PDF varsa onu, yoksa TR PDF'i göster.
- PDF dosyası yoksa linki kırık bırakma: dosyanın varlığını kontrol et, yoksa kullanıcıya hatırlat.
- CV güncellendiğinde sadece PDF'i değiştirmek yetmeli; dosya adı sabit kalır.

## Tasarım yönü

- Profesyonel, sade, güven veren. Finans/fintech sektörüne başvuran kıdemli bir geliştirici izlenimi.
- Açık ve koyu tema (varsayılan: sistem tercihi `prefers-color-scheme`, seçim `localStorage`'da saklanır; `localStorage` erişimini try/catch içine al).
- Tek vurgu rengi (ör. koyu lacivert/petrol mavisi tonları). Gökkuşağı gradyanlar, aşırı animasyon, parçacık efektleri yok.
- Animasyonlar küçük ve `prefers-reduced-motion` ile kapatılabilir.
- Mobil öncelikli, 360px genişlikte kusursuz.
- Okunabilir satır uzunluğu (~70 karakter), rahat satır aralığı.
- Profil fotoğrafı: `assets/img/profile.jpg` varsa hero'da yuvarlak göster; yoksa baş harfler (YÜ) ile sade bir avatar.

## SEO ve paylaşım

- Her sayfada: `<title>`, `meta description`, canonical, `hreflang` (tr, en, x-default)
- Open Graph ve Twitter Card etiketleri (`og:title`, `og:description`, `og:image` → `assets/img/og-image.png`, 1200x630)
- JSON-LD `Person` şeması: ad, unvan, e-posta, sameAs (LinkedIn), url
- `robots.txt` ve `sitemap.xml`
- `favicon.svg` (baş harfler) ve `apple-touch-icon.png`

## Gizlilik

- **Telefon numarasını sitede gösterme.** Sadece e-posta ve LinkedIn.
- Analitik/izleme kodu ekleme (kullanıcı isterse sonra eklenir).
- E-posta adresini düz metin yerine `mailto:` linki olarak koy.

## Klasör yapısı

```
/
├── index.html            # Türkçe
├── en/index.html         # İngilizce
├── css/style.css
├── js/main.js
├── assets/
│   ├── cv/               # CV PDF'leri
│   ├── img/              # profile.jpg, og-image.png, ikonlar
│   └── fonts/            # (opsiyonel) self-host fontlar
├── favicon.svg
├── robots.txt
├── sitemap.xml
├── content/              # İçerik kaynağı (yayınlanmaz, deploy'a dahil etme)
└── docs/                 # Yol haritası (yayınlanmaz)
```

## Çalışma şekli

- `docs/ROADMAP.md` içindeki fazları sırayla uygula. Bir fazı bitirince kullanıcıya özet ver ve onay bekle.
- Değişiklikten sonra sayfayı yerelde aç (`python3 -m http.server 8000`) ve kontrol et: mobil ve masaüstü genişlik, açık/koyu tema, TR/EN geçişi, CV linki.
- İçerikte yazım hatası veya tutarsızlık görürsen düzeltme önerisini kullanıcıya sor, kendin içerik değiştirme.

## Kullanıcıya sorulacak açık konular

- Hosting nerede? (ustunsoft.com'un mevcut hostingi / cPanel mi, GitHub Pages mi, Cloudflare Pages mi?) Deploy fazından önce sor.
- `yasinustun.ustunsoft.com` için DNS (alt alan adı) kaydı yapıldı mı?
- Profil fotoğrafı kullanılacak mı?
- İngilizce CV PDF'i hazır mı?
