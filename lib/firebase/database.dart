import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products =
      FirebaseFirestore.instance.collection('products');
}
