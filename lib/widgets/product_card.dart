import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_catalog_app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => viewDetails(context),
      child: Card(
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          child: Column(children: [
            Expanded(
                child: Image.network(product.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error))),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(children: [
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text('${product.price}',
                      maxLines: 1, overflow: TextOverflow.ellipsis)
                ]))
          ])));

  void viewDetails(BuildContext context) {
    List<Widget> info(String attribute, String value) => [
          Text('$attribute:',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
          const Divider(indent: 8, endIndent: 8)
        ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Product details'),
              content: SingleChildScrollView(
                  child: Column(children: [
                Image.network(product.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error)),
                const SizedBox(height: 20),
                ...info('Name', product.name),
                ...info('Description', product.description),
                ...info('Price', '${product.price}'),
                ...info('Quantity', '${product.quantity}'),
                ...info('Category', '${product.category}')
              ])),
              actions: <Widget>[
                TextButton(
                    child: const Text('Edit details'),
                    onPressed: () {
                      context.go('/edit-product/${product.id}');
                      Navigator.pop(context);
                    })
              ]);
        });
  }
}
