import 'package:flutter/material.dart';
import 'package:product_catalog_app/custom_widgets/product_details_widget.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:product_catalog_app/widgets/loading_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final Product product = Product.empty();
  bool creating = false;

  @override
  Widget build(BuildContext context) {
    return creating
        ? const LoadingWidget(text: 'Creating Product')
        : Scaffold(
            appBar: AppBar(title: const Text('Add a new Product')),
            body: Column(children: [
              ProductDetailsWidget(product: product),
              ElevatedButton(
                  onPressed: createProduct, child: const Text('Create Product'))
            ]));
  }

  void createProduct() async {
    setState(() => creating = true);
    await Database.addProduct(product);
    setState(() => creating = false);
  }
}
