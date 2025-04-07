import 'package:encore_shopping_mall/pages/cart_list_page.dart';
import 'package:encore_shopping_mall/pages/item_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class Routes {
  static const home = '/';
  static const cart = '/cart';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const ItemListPage()),
      GoRoute(path: '/cart', builder: (context, state) => const CartListPage()),
    ],
  );
});
