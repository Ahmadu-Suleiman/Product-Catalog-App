import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class Storage {
  static final _firebaseStorage = FirebaseStorage.instance;
  static final _storageRef = _firebaseStorage.ref();
  static const _uuid = Uuid();
  static final Logger logger = Logger();

  static Future<String> uploadProductImage(String imagePath) async {
    final imageRef = _storageRef.child("product_images/${_uuid.v1()}");
    await imageRef.putFile(File(imagePath));
    return await imageRef.getDownloadURL();
  }

  static Future<void> deleteProductImage(String url) async {
    try {
      final imageRef = _firebaseStorage.refFromURL(url);
      await imageRef.delete();
    } catch (e) {
      logger.e(e);
    }
  }
}
