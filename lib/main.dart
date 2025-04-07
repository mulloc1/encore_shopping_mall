import 'package:encore_shopping_mall/models/item.dart';
import 'package:encore_shopping_mall/providers/item_list_provider.dart';
import 'package:encore_shopping_mall/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool initialState = false;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  void makeItemList(WidgetRef ref) {
    if (initialState) {
      return;
    }
    final itemList = ref.watch(itemListProvider);
    for (int i = 0; i < 10; i++) {
      itemList.add(
        Item(
          name: '상품 $i',
          price: 1000,
          description: '상품 $i 설명',
          image_path: 'https://via.placeholder.com/150',
          quantity: 0,
        ),
      );
    }
    initialState = true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    makeItemList(ref);

    return MaterialApp.router(routerConfig: router);
  }
}
