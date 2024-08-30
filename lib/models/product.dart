class Product {
  String? id;
  String name = '';
  String description = '';
  int quantity = 0;
  double price = 0.0;
  String? imageUrl;

  Product(
      {this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  Product.empty();

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
        'description': description,
        'quantity': quantity,
        'price': price,
        'imageUrl': imageUrl
      };
}
