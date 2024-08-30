import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/firebase/storage.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:product_catalog_app/widgets/loading_widget.dart';
import 'package:product_catalog_app/widgets/product_details_widget.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.id});

  final String id;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  bool loading = true;
  String? localImage;
  final ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  late final Product product;

  Future<void> loadProduct() async =>
      product = await Database.product(widget.id);

  @override
  void initState() {
    super.initState();
    loadProduct().then((_) => setState(() => loading = false));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LoadingWidget(text: 'Loading Product');
    } else {
      return Scaffold(
          appBar: AppBar(title: const Text('Update a new Product')),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(children: [
                Align(child: addImageWidget),
                ProductDetailsWidget(product: product, formKey: formKey),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: deleteProduct,
                          child: const Text('Delete Product')),
                      ElevatedButton(
                          onPressed: updateProduct,
                          child: const Text('Update Product'))
                    ])
              ])));
    }
  }

  Widget get addImageWidget => Column(children: [
        Image(
            height: 300,
            image: localImage != null
                ? FileImage(File(localImage!))
                : NetworkImage(product.imageUrl!),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
            fit: BoxFit.fitWidth),
        TextButton(onPressed: addImage, child: const Text('Replace image'))
      ]);

  void addImage() async {
    String? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = file.path;
    setState(() => localImage = image);
  }

  void deleteProduct() async {
    setState(() => loading = true);
    await Storage.deleteProductImage(product.imageUrl!);
    await Database.deleteProduct(product);
    if (mounted) context.pop();
  }

  void updateProduct() async {
    if (formKey.currentState!.validate()) {
      setState(() => loading = true);

      if (localImage != null) {
        String imageUrl = await Storage.uploadProductImage(localImage!);
        product.imageUrl = imageUrl;
      }

      await Database.updateProduct(product);
      if (mounted) context.pop();
    }
  }
}
