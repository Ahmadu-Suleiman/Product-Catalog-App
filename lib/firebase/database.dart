import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_catalog_app/models/product.dart';

class Database {
  static final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  static Future<DocumentReference> addProduct(Product product) async =>
      _products.add(product.toJson);

  static Future<void> updateProduct(Product product) async =>
      _products.doc(product.id!).update(product.toJson);

  static Future<Product> product(String id) async =>
      productFromDoc(await _products.doc(id).get());

  static Future<void> deleteProduct(Product product) async =>
      await _products.doc(product.id).delete();

  static Stream<QuerySnapshot> get productsStream =>
      _products.orderBy('timestamp', descending: true).snapshots();

  static Stream<QuerySnapshot<Object?>> filteredProductsStream(
      double? priceMin, double? priceMax, String? category) {
    Query query =
        _products.where('price', isGreaterThanOrEqualTo: priceMin ?? 0);
    if (priceMax != null) {
      query = query.where('price', isLessThanOrEqualTo: priceMax);
    }
    if (category != null) query = query.where('category', isEqualTo: category);
    return query.orderBy('timestamp', descending: true).snapshots();
  }

  static Product productFromDoc(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      return Product(
          id: snapshot.id,
          timestamp: snapshot['timestamp'],
          name: snapshot['name'],
          description: snapshot['description'],
          quantity: snapshot['quantity'],
          price: snapshot['price'],
          category: snapshot['category'],
          imageUrl: snapshot['imageUrl']);
    } else {
      return Product.empty();
    }
  }

  static List<Product> productsFromDocs(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.docs;
    return documents
        .map((document) => Product(
            id: document.id,
            timestamp: document['timestamp'],
            name: document['name'],
            description: document['description'],
            quantity: document['quantity'],
            price: document['price'],
            category: document['category'],
            imageUrl: document['imageUrl']))
        .toList();
  }
}
