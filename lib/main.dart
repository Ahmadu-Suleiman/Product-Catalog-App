import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_app/routes.dart';

import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Product Catalog',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown)),
        routerConfig: Routes.router);
  }
}
