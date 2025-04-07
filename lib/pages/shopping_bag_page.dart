import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingBagPage extends ConsumerWidget {
  const ShoppingBagPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('장바구니')),
      body: const Center(child: Text('장바구니 페이지')),
    );
  }
}
