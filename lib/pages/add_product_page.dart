import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_catalog_app/models/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final Product product = Product.empty();
  final ImagePicker picker = ImagePicker();
  Uint8List? localImage;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      addImageWidget,
    ]);
  }

  Widget get addImageWidget => GestureDetector(
      onTap: addImage,
      child: SizedBox(
          height: 400,
          child: localImage != null
              ? Image(
                  image: MemoryImage(localImage!),
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                  fit: BoxFit.fitWidth)
              : const Center(child: Text('Add image'))));

  void addImage() async {
    Uint8List? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = await file.readAsBytes();
    setState(() => localImage = image);
  }
}
