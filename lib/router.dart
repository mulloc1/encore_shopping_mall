import 'dart:io';

import 'package:encore_shopping_mall/models/item.dart';
import 'package:encore_shopping_mall/pages/cart_list_page.dart';
import 'package:encore_shopping_mall/pages/item_list_page.dart';
import 'package:encore_shopping_mall/pages/product_create_page.dart';
import 'package:encore_shopping_mall/pages/product_detail_page.dart';
import 'package:encore_shopping_mall/providers/item_list_provider.dart';
import 'package:encore_shopping_mall/utils/logger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class Routes {
  static const home = '/';
  static const cart = '/cart';
  static const productDetail = '/product/:item';
  static const productCreate = '/create';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const ItemListPage()),
      GoRoute(path: '/cart', builder: (context, state) => const CartListPage()),
      GoRoute(
        path: Routes.productDetail,
        builder: (context, state) {
          final item = state.extra as Item;
          return ProductDetailPage(item: item);
        },
      ),
      GoRoute(
        path: Routes.productCreate,
        builder: (context, state) => const ProductCreatePage(),
      ),
    ],
  );
});
