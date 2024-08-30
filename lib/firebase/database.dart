import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_catalog_app/models/product.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  static Future<DocumentReference> addProduct(Product product) async =>
      products.add(product.toJson);

  static Future<void> updateProduct(Product product) async =>
      await products.doc(product.id).delete();

  static Stream<QuerySnapshot> get productsStream => products.snapshots();

  static List<Product> productsFromDocs(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.docs;
    return documents
        .map((document) => Product(
            id: document.id,
            name: document['name'],
            description: document['description'],
            quantity: document['quantity'],
            price: document['price'],
            imageUrl: document['imageUrl']))
        .toList();
  }
}
