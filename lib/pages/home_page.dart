import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/models/product.dart';
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
            return const Center(child: CircularProgressIndicator());
          }

          List<Product> products = Database.productsFromDocs(snapshot.data!);
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Product Catalog'), centerTitle: true),
              body: products.isEmpty
                  ? const Center(child: Text('Add Products'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          ProductCard(product: products[index])),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => context.go('/add-product'),
                  child: const Icon(Icons.add)));
        });
  }
}
