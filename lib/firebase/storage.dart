import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storage {
  static final _storageRef = FirebaseStorage.instance.ref();
  static final _imagesRef = _storageRef.child("product_images");
  static const _uuid = Uuid();

  static Future<String> uploadProductImage(String imagePath) async {
    await _imagesRef.putFile(File(imagePath));
    return await _imagesRef.getDownloadURL();
  }

// static Future<String> deleteProductImage(urlString) async {
//   return await _imagesRef.dele;
// }
}
