# E-Task2 – Ürün Detay, Sepet ve Favori Yönetimi

Bu proje, UIKit tabanlı bir e-ticaret uygulamasının ürün detay ekranı için geliştirilmiştir. Aşağıdaki özellikleri içerir:

## Özellikler

- `ProductDetailViewModel` ile MVVM mimarisi
- `FavoritesManager` ile favori ürünlerin Core Data üzerinden yönetimi
- `CartManager` ile sepet işlemleri ve toplam fiyat hesabı
- `CoreDataManager` ile generic CRUD işlemleri
- `Unit Test` desteği (XCTest + in-memory Core Data)

## Testler

- ViewModel iş mantığı (favori, sepete ekleme) test edilmiştir
- Core Data testleri için in-memory store kullanılmıştır


## Notlar

- Projede `NSManagedObject` sınıfları manuel olarak yazılmıştır
- `.xcdatamodeld` test target’ına dahildir
![screen](https://github.com/user-attachments/assets/53418c29-0383-4641-a394-a38f35bb32df)
