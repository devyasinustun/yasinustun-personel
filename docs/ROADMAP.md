# Yol haritası — Claude Code ile adım adım

Her fazı ayrı bir mesajla başlat. Aşağıdaki prompt'ları Claude Code'a olduğu gibi yapıştırabilirsin. Bir faz bitmeden sonrakine geçme.

---

## Faz 1 — İskelet ve tasarım sistemi

```
CLAUDE.md'yi oku. Faz 1: index.html için semantik iskeleti (tüm bölümler boş başlıklarla), css/style.css içinde tasarım token'larını (renkler açık/koyu, tipografi, boşluklar) ve sticky header'ı (menü + TR/EN + tema düğmesi) oluştur. js/main.js'te tema değiştiriciyi yaz. Bitince python3 -m http.server ile açıp mobil ve masaüstünde kontrol et, bana ekran görüntüsü özetiyle durumu anlat.
```

## Faz 2 — Türkçe içerik

```
Faz 2: content/profile.tr.md içeriğini index.html'e yerleştir. Hero, Hakkımda, Deneyim (timeline), Yetenekler (chip), Projeler, Eğitim ve Sertifikalar, İletişim. İçerik dosyasında olmayan hiçbir bilgiyi ekleme. CV indirme butonu assets/cv/Yasin_Ustun_CV_TR.pdf'e gitsin.
```

## Faz 3 — İngilizce sayfa

```
Faz 3: content/profile.en.md ile en/index.html'i oluştur. Aynı tasarım, aynı CSS. hreflang etiketlerini iki sayfaya da ekle, TR/EN geçiş linklerinin doğru sayfaya gittiğini kontrol et.
```

## Faz 4 — SEO, performans, erişilebilirlik

```
Faz 4: Her iki sayfaya meta description, canonical, Open Graph, Twitter Card ve JSON-LD Person şeması ekle. favicon.svg (YÜ baş harfleri), robots.txt ve sitemap.xml oluştur. Erişilebilirliği kontrol et (kontrast, focus, alt metin, başlık sırası, prefers-reduced-motion). Görselleri optimize et. Sonuçları listele.
```

## Faz 5 — Yayına alma

```
Faz 5: Siteyi yayına hazırla. Önce bana hosting'in ne olduğunu sor. content/ ve docs/ klasörleri deploy'a dahil edilmesin. Seçilen hosting için adım adım yükleme talimatı ver (cPanel/FTP ise hangi klasöre, GitHub Pages/Cloudflare Pages ise repo ve DNS ayarları, yasinustun.ustunsoft.com için CNAME/A kaydı). HTTPS'in açık olduğunu kontrol ettir.
```

---

## Sonradan

- CV güncellendiğinde: yeni PDF'i aynı adla `assets/cv/` içine koy, yeniden yükle.
- İngilizce CV hazır olunca: `assets/cv/Yasin_Ustun_CV_EN.pdf` ekle, EN sayfadaki butonu ona yönlendirt.
