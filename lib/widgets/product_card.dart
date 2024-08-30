import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Image.network(product.imageUrl!,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error)),
            Text(product.name),
            Text('${product.price}'),
            Text('${product.quantity}')
          ])));
}
