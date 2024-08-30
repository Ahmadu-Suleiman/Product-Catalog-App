import 'package:go_router/go_router.dart';
import 'package:product_catalog_app/pages/add_product_page.dart';
import 'package:product_catalog_app/pages/edit_product_page.dart';
import 'package:product_catalog_app/pages/home_page.dart';

class Routes {
  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(
              path: 'add-product',
              builder: (context, state) => const AddProductPage()),
          GoRoute(
              path: 'edit-product/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return EditProductPage(id: id);
              })
        ])
  ]);
}
