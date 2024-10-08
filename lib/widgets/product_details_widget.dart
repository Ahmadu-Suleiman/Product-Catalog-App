import 'package:flutter/material.dart';
import 'package:product_catalog_app/shared/product_category.dart';

import '../models/product.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget(
      {super.key,
      this.create = false,
      required this.product,
      required this.formKey});

  final bool create;
  final Product product;
  final GlobalKey<FormState> formKey;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  late final Product product;

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

    controllerName.addListener(() => product.name = controllerName.text.trim());
    controllerDescription.addListener(
        () => product.description = controllerDescription.text.trim());
    controllerPrice.addListener(() =>
        product.price = double.tryParse(controllerPrice.text.trim()) ?? 0.0);
    controllerQuantity.addListener(() =>
        product.quantity = int.tryParse(controllerQuantity.text.trim()) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextFormField(
                  controller: controllerName,
                  textCapitalization: TextCapitalization.words,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      hintText: 'Enter product name',
                      labelText: 'Product name'),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter product name' : null),
              TextFormField(
                  controller: controllerDescription,
                  textCapitalization: TextCapitalization.sentences,
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
                  validator: (value) =>
                      (value!.isEmpty || double.tryParse(value.trim()) == null)
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
                          : null),
              DropdownButtonFormField<ProductCategory>(
                  value: ProductCategory.category(product.category),
                  items: ProductCategory.dropDownItems,
                  hint: const Text('Choose category'),
                  icon: const Icon(Icons.category),
                  onChanged: (category) =>
                      setState(() => product.category = category?.name),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value == null ? 'Please select a category' : null)
            ])));
  }
}
