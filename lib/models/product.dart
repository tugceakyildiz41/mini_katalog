class Product {
  final int id;
  final String name;
  final String subtitle;
  final String description;
  final double price;
  final String category;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  // JSON'dan Product nesnesi üretir
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String,
    );
  }

  // Product nesnesini JSON'a çevirir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }
}