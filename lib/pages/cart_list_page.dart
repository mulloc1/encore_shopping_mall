import 'package:encore_shopping_mall/providers/cart_provider.dart';
import 'package:encore_shopping_mall/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encore_shopping_mall/models/item.dart';
import 'package:go_router/go_router.dart';

class CartItemWidget extends ConsumerWidget {
  final Item item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(width: 80, height: 80, color: Colors.grey),
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
    );
  }
}

class CartListPage extends ConsumerWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartList = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(Routes.home);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('TITLE'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // 밑줄의 높이
          child: Container(
            color: Colors.grey, // 밑줄의 색상
            height: 1.0, // 밑줄의 두께
          ),
        ),
      ),
      body:
          cartList.isEmpty
              ? const Center(child: Text('장바구니가 비었습니다.'))
              : ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(item: cartList[index]);
                },
              ),
    );
  }
}
