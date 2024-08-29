import 'package:flutter/material.dart';
import 'package:product_catalog_app/firebase/database.dart';
import 'package:product_catalog_app/product.dart';

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
            return const CircularProgressIndicator();
          }

          List<Product> products=Database.productsFromDocs(snapshot);
          return return ListView.builder(
              itemCount: items.length,itemBuilder: (context, index) =>)
        });
  }
}
