import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/models/product.dart';
import 'package:product_catalog_app/widgets/loading_widget.dart';
import 'package:product_catalog_app/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Database.productsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text('Something went wrong');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(text: 'Loading Products');
          }

          List<Product> products = Database.productsFromDocs(snapshot.data!);
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Product Catalog',
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
                              ProductCard(product: products[index]))),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => context.go('/add-product'),
                  child: const Icon(Icons.add)));
        });
  }
}
