import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
                          onPressed: showDeleteDialog,
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
        TextButton.icon(
            onPressed: replaceImage,
            label: const Text('Replace image'),
            icon: const Icon(Icons.change_circle))
      ]);

  void replaceImage() async {
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

      product.timestamp = Timestamp.now();
      if (localImage != null) {
        String imageUrl = await Storage.uploadProductImage(localImage!);
        product.imageUrl = imageUrl;
      }

      await Database.updateProduct(product);
      if (mounted) context.pop();
    }
  }

  void showDeleteDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Delete product'),
              content: const Text('Do you want to delete this product?'),
              actions: [
                TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      deleteProduct();
                    },
                    child: const Text('Delete'))
              ]);
        });
  }
}
