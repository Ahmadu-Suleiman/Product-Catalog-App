class Product {
  String? id;
  String name;
  String description;
  int quantity;
  double price;
  String imageUrl;

  Product(
      {this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
        'description': description,
        'quantity': quantity,
        'price': price,
        'imageUrl': imageUrl
      };
}
