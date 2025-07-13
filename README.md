# 🛒 E-Task – Ürün Detay, Sepet ve Favori Yönetimi

UIKit tabanlı bu e-ticaret uygulaması, ürün detay ekranı etrafında şekillenen favori ve sepet yönetimi özelliklerini kapsamaktadır. MVVM mimarisi ile yapılandırılmıştır ve Core Data desteklidir.

## 🚀 Özellikler

- ✅ MVVM Mimarisi: `ProductDetailViewModel` ile ayrıştırılmış iş mantığı  
- ❤️ Favori Yönetimi: `FavoritesManager` aracılığıyla Core Data üzerinde favori ürün takibi  
- 🛒 Sepet İşlemleri: `CartManager` ile ürün ekleme ve toplam fiyat hesaplama  
- 💾 Core Data İşlemleri: `CoreDataManager` ile generic CRUD işlemleri  
- 🧪 Unit Test Desteği: `XCTest` ile `ViewModel`'lerin işlevselliği test edilmiştir  

## 🧪 Testler

`ProductDetailViewModelTests` sınıfı üzerinden aşağıdaki senaryolar test edilmiştir:

- ⭐️ Favori ürün durumu kontrolü  
- 🔁 Favori toggle işlemi (ekleme/çıkarma)  
- 🛍 Sepete ürün ekleme doğrulaması  



## 📦 Core Data

- Kullanılan model dosyası: `CoreDataModel.xcdatamodeld`
- Entity'ler:
  - `FavoriteEntity`
  - `CartItemEntity`
  -  Mapping katmanı mevcuttur.

> **Not:** `CoreDataModel.xcdatamodeld` test hedefi (Test Target) altında da işaretlenmiştir. Testler çalışırken in-memory store kullanılır.



## 📁 Proje Yapısı

```
E-Task/
├── Managers/                # CoreDataManager, CartManager, FavoritesManager
├── Models/                 # Product, CartItem
├── Persistence/            # Core Data sınıfları ve mapping
├── ViewModels/             # MVVM ViewModel dosyaları
├── Views/                  # UIKit ViewController ve UI bileşenleri
├── Resources/              # Constants, Assets, Notification.Name
├── E-TaskTests/            # Mock sınıflar ve unit test dosyaları
```

## 🔮 Geliştirme Planı

- [ ] Favori ürün listesi ekranı  
- [ ] Sepet ekranı ve silme işlemi  
- [ ] Ödeme ekranı (yalancı)  
- [ ] Snapshot test desteği  


## 🖼 Ekran Gif
![screen](https://github.com/user-attachments/assets/0e5f94f1-5182-40df-a72f-73f0fb9ca829)

