import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final formKey = GlobalKey<FormState>();
  Uint8List? localImage;

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add a new Product')),
        body: Column(children: [
          Align(child: addImageWidget),
          Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                        labelText: 'Enter a product name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Write something' : null),
                TextFormField(
                    controller: controllerDescription,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: 'Enter a product name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Write something' : null),
                TextFormField(
                    controller: controllerPrice,
                    maxLines: null,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'Enter a product name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Write something' : null)
              ]))
        ]));
  }

  Widget get addImageWidget => localImage != null
      ? Column(children: [
          Image(
              height: 400,
              image: MemoryImage(localImage!),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              fit: BoxFit.fitWidth),
          const SizedBox(height: 20),
          TextButton(onPressed: addImage, child: const Text('Replace image'))
        ])
      : SizedBox(
          height: 400,
          child: Center(
              child: TextButton(
                  onPressed: addImage, child: const Text('Add image'))));

  void addImage() async {
    Uint8List? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = await file.readAsBytes();
    setState(() => localImage = image);
  }
}
