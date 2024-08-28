class Product {
  int? id;
  String name;
  int quantity;
  double price;
  String imageUrl;

  Product(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'imageUrl': imageUrl
      };
}
