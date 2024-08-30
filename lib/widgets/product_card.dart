import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Column(children: [
        Flexible(
            child: Image.network(product.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error))),
        Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        Text('${product.price}', maxLines: 1, overflow: TextOverflow.ellipsis)
      ]));
}
