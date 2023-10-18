import 'rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final RatingModel ranking;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ranking,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] as int? ?? 0,
      title:  json["title"] as String? ?? "",
      price: json["price"] as num? ?? 0,
      description: json["description"] as String? ?? "",
      category: json["category"] as String? ?? '',
      image: json["image"] as String? ?? "",
      ranking: RatingModel.fromJson(json["rating"]),
    );
  }
  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };
}


// {
// "id": 1,
// "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
// "price": 109.95,
// "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
// "category": "men's clothing",
// "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
// "rating": {
// "rate": 3.9,
// "count": 120
// }
// },