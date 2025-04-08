import 'dart:io';

import 'package:encore_shopping_mall/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encore_shopping_mall/models/item.dart';
import 'package:encore_shopping_mall/providers/item_list_provider.dart';
import 'package:go_router/go_router.dart';

class ItemWidget extends ConsumerWidget {
  final Item item;

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.go(Routes.productDetail, extra: item);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    item.image == null
                        ? const SizedBox(width: 80, height: 80)
                        : SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.file(File(item.image!.path)),
                        ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('${item.price} 원'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}

class ItemListPage extends ConsumerWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TITLE'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // 밑줄의 높이
          child: Container(
            color: Colors.grey, // 밑줄의 색상
            height: 1.0, // 밑줄의 두께
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go(Routes.cart);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body:
          itemList.isEmpty
              ? const Center(child: Text('상품이 없습니다.'))
              : ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ItemWidget(item: itemList[index]);
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add item action
          context.go(Routes.productCreate);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
