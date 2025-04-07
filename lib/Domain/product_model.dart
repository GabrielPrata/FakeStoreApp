class ProductModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  double rate;
  int totalReviews;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rate,
      required this.totalReviews});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rate: (json['rating']['rate'] as num).toDouble(),
      totalReviews: json['rating']['count'],
    );
  }

  @override
  String toString() {
    return 'ProductModel('
        'id: $id, '
        'title: "$title", '
        'price: $price, '
        'description: "$description", '
        'category: "$category", '
        'image: "$image", '
        'rate: $rate, '
        'totalReviews: $totalReviews'
        ')';
  }
}
