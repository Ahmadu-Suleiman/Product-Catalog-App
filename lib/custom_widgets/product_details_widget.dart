import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget(
      {super.key, required this.product, this.create = false});

  final Product product;
  final bool create;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final Product product;
  final ImagePicker picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  Uint8List? localImage;

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerQuantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    product = widget.product;
    controllerName.text = product.name;
    controllerDescription.text = product.description;
    controllerPrice.text = '${product.price}';
    controllerQuantity.text = '${product.quantity}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Align(child: addImageWidget),
          Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                    controller: controllerName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: 'Enter product name',
                        labelText: 'Product name'),
                    validator: (value) =>
                        value!.trim().isEmpty ? 'Enter product name' : null),
                TextFormField(
                    controller: controllerDescription,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Enter a product description',
                        labelText: 'Product description'),
                    validator: (value) => value!.trim().isEmpty
                        ? 'Enter a product description'
                        : null),
                TextFormField(
                    controller: controllerPrice,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        hintText: 'Enter a product price',
                        labelText: 'Product price'),
                    validator: (value) => (value!.isEmpty ||
                            double.tryParse(value.trim()) == null)
                        ? 'Enter a valid number'
                        : null),
                TextFormField(
                    controller: controllerQuantity,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Enter a product quantity',
                        labelText: 'Product quantity'),
                    validator: (value) =>
                        (value!.isEmpty || int.tryParse(value.trim()) == null)
                            ? 'Enter a valid number'
                            : null)
              ]))
        ]));
  }

  Widget get addImageWidget {
    if (localImage != null || product.imageUrl != null) {
      return Column(children: [
        Image(
            height: 400,
            image: localImage != null
                ? MemoryImage(localImage!)
                : NetworkImage(product.imageUrl!),
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
              child: TextButton(
                  onPressed: addImage, child: const Text('Add image'))));
    }
  }

  void addImage() async {
    Uint8List? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = await file.readAsBytes();
    setState(() => localImage = image);
  }
}
