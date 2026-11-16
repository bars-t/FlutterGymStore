# gymStore - Mini Spor Ekipmanı Katalog Uygulaması

Bu proje, Flutter temel eğitimi kapsamında geliştirilmiş bir **"Mini Katalog Uygulaması"** projesidir. Uygulama içerisinde spor ve fitness ekipmanları listelenmekte, filtrelenmekte, ürün detayları incelenebilmekte ve sepete ekleme/çıkarma işlemleri simüle edilmektedir.

---

## Özellikler
- **Katalog Ekranı:** GridView ile 2 sütunlu ürün listesi ve arama alanı.
- **Arama ve Filtreleme:** Ürün adına göre anlık arama ve kategorilere göre yatay filtreleme butonları.
- **Ürün Detay Ekranı:** Ürünün görseli, fiyatı, detaylı açıklaması ve sepete ekleme butonu.
- **Sepet Sistemi:**
  - Ürünleri sepete ekleme.
  - Sepetteki ürün adetlerini artırma / azaltma.
  - Ürün silme ve sepeti boşaltma.
  - Toplam tutar hesaplama ve sipariş onaylama modalı.
- **Tasarım:** Harici hiçbir paket kullanılmadan, saf `material.dart` bileşenleri ile sade mobil UI.

---

## Kullanılan Teknolojiler
- **Flutter Sürümü:** 3.47.8
- **Dart Sürümü:** 3.13.7
- **Geliştirme Ortamı:** Visual Studio Code / Android Studio

---

## Projeyi Çalıştırma Adımları

1. Projeyi klonlayın veya indirin:
   ```bash
   git clone <repo-url>
   cd gym_store
   ```

2. Paket bağımlılıklarını yükleyin:
   ```bash
   flutter pub get
   ```

3. Uygulamayı emülatörde veya bağlı fiziksel cihazda başlatın:
   ```bash
   flutter run
   ```

---

## Proje Dosya Yapısı
```text
lib/
├── modeller/
│   ├── urun.dart             # Ürün sınıfı
│   └── sepet_elemani.dart    # Sepet elemanı sınıfı
├── veriler/
│   └── urunler_verisi.dart   # 8 adet örnek spor ekipmanı verisi
├── bilesenler/
│   └── urun_karti.dart       # Tekil ürün kartı bileşeni
├── sayfalar/
│   ├── ana_ekran.dart        # Ana katalog ve arama ekranı
│   ├── urun_detay_ekrani.dart # Ürün detay sayfası
│   └── sepet_ekrani.dart     # Sepet sayfası
└── main.dart                 # Uygulama başlangıcı
```
