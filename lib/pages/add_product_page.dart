import 'package:flutter/material.dart';
import 'package:product_catalog_app/custom_widgets/product_details_widget.dart';
import 'package:product_catalog_app/models/product.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final Product product = Product.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add a new Product')),
        body: ProductDetailsWidget(product: product));
  }
}
