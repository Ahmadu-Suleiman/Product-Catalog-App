import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_catalog_app/custom_widgets/product_details_widget.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/firebase/storage.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:product_catalog_app/shared/utility.dart';
import 'package:product_catalog_app/widgets/loading_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  bool creating = false;
  String? localImage;
  final ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final Product product = Product.empty();

  @override
  Widget build(BuildContext context) {
    return creating
        ? const LoadingWidget(text: 'Creating Product')
        : Scaffold(
            appBar: AppBar(title: const Text('Add a new Product')),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Align(child: addImageWidget),
                  ProductDetailsWidget(product: product, formKey: formKey),
                  ElevatedButton(
                      onPressed: createProduct,
                      child: const Text('Create Product'))
                ])));
  }

  Widget get addImageWidget {
    if (localImage != null) {
      return Column(children: [
        Image(
            height: 400,
            image: FileImage(File(localImage!)),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
            fit: BoxFit.fitWidth),
        const SizedBox(height: 20),
        TextButton(onPressed: addImage, child: const Text('Replace image'))
      ]);
    } else {
      return SizedBox(
          height: 400,
          child: Center(
              child: TextButton.icon(
                  onPressed: addImage,
                  label: const Text('Add image'),
                  icon: const Icon(Icons.upload))));
    }
  }

  void addImage() async {
    String? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = file.path;
    setState(() => localImage = image);
  }

  void createProduct() async {
    if (localImage != null) {
      if (formKey.currentState!.validate()) {
        setState(() => creating = true);

        String imageUrl = await Storage.uploadProductImage(localImage!);
        product.imageUrl = imageUrl;
        await Database.addProduct(product);
        if (mounted) context.pop();
      }
    } else {
      Utility.showSnackBar(context, 'Add a product image');
    }
  }
}
