import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:encore_shopping_mall/pages/item_list_page.dart';
import 'package:encore_shopping_mall/pages/item_detail_page.dart';
import 'package:encore_shopping_mall/pages/item_add_page.dart';
import 'package:encore_shopping_mall/pages/shopping_bag_page.dart';

abstract class AppRoutes {
  static const String itemList = '/items';
  static const String itemDetail = '/items/:id';
  static const String itemAdd = '/items/add';
  static const String shoppingBag = '/shopping-bag';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.itemList,
    routes: [
      GoRoute(
        path: AppRoutes.itemList,
        builder: (context, state) => const ItemListPage(),
      ),
      GoRoute(
        path: AppRoutes.itemDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ItemDetailPage(itemId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.itemAdd,
        builder: (context, state) => const ItemAddPage(),
      ),
      GoRoute(
        path: AppRoutes.shoppingBag,
        builder: (context, state) => const ShoppingBagPage(),
      ),
    ],
  );
});
