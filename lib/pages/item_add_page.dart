import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemAddPage extends ConsumerStatefulWidget {
  const ItemAddPage({super.key});

  @override
  ConsumerState<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends ConsumerState<ItemAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 추가')),
      body: const Center(child: Text('상품 추가 페이지')),
    );
  }
}
