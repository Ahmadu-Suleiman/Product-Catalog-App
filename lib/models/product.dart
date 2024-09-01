import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  Timestamp timestamp = Timestamp.now();
  String name = '';
  String description = '';
  double price = 0.0;
  int quantity = 0;
  String? category;
  String? imageUrl;

  Product(
      {this.id,
      required this.timestamp,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.imageUrl});

  Product.empty();

  Map<String, dynamic> get toJson => {
        'timestamp': timestamp,
        'name': name,
        'description': description,
        'price': price,
        'quantity': quantity,
        'category': category,
        'imageUrl': imageUrl
      };
}
