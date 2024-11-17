class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String type;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.type,
    required this.description,
  });

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      type: data['type'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
