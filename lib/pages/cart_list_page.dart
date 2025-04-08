import 'dart:io';

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
    final cartNotifier = ref.read(cartProvider.notifier);

    return GestureDetector(
      onTap: () {},
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
                          Row(
                            children: [
                              Expanded(child: Text(item.name)),
                              IconButton(
                                onPressed: () {
                                  cartNotifier.removeItem(item);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 수령 증감 버튼
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        cartNotifier.updateQuantity(
                                          item.id,
                                          item.quantity - 1,
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text('${item.quantity}개'),
                                  IconButton(
                                    onPressed: () {
                                      if (item.quantity < 99) {
                                        cartNotifier.updateQuantity(
                                          item.id,
                                          item.quantity + 1,
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Text('${item.price * item.quantity} 원'),
                            ],
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

class CartListPage extends ConsumerWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartList = ref.watch(cartProvider);
    final totalPrice = cartList.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

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
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(item: cartList[index]);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('총 금액: $totalPrice 원'),
                        ElevatedButton(
                          onPressed:
                              cartList.isEmpty
                                  ? null
                                  : () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: const Text('구매 완료'),
                                            content: const Text(
                                              '장바구니의 상품을 구매했습니다.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () =>
                                                        context.go(Routes.home),
                                                child: const Text('확인'),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                          child: const Text('구매하기'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
