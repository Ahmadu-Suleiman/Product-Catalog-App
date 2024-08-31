import 'package:flutter/material.dart';

import '../firebase/database.dart';
import '../models/product.dart';
import '../widgets/loading_widget.dart';
import '../widgets/product_card.dart';

class FilteredProductsPage extends StatelessWidget {
  const FilteredProductsPage(
      {super.key,
      required this.priceMin,
      required this.priceMax,
      required this.category});

  final double? priceMin, priceMax;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Database.filteredProducts(priceMin, priceMax, category),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Something went wrong');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(text: 'Loading Products');
          }

          List<Product> products = Database.productsFromDocs(snapshot.data!);
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Filtered Products',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer),
              body: products.isEmpty
                  ? const Center(child: Text('Add Products'))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 8),
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              ProductCard(product: products[index]))));
        });
  }
}
