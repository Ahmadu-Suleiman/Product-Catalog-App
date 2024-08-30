import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storage {
  static final _storageRef = FirebaseStorage.instance.ref();
  static const _uuid = Uuid();

  static Future<String> uploadProductImage(String imagePath) async {
    final imageRef = _storageRef.child("product_images/${_uuid.v1()}");
    await imageRef.putFile(File(imagePath));
    return await imageRef.getDownloadURL();
  }

// static Future<String> deleteProductImage(urlString) async {
//   return await _imagesRef.dele;
// }
}
