import 'package:encore_shopping_mall/models/item.dart';
import 'package:encore_shopping_mall/providers/cart_provider.dart';
import 'package:encore_shopping_mall/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Item item;

  const ProductDetailPage({super.key, required this.item});

  @override
  ConsumerState<ProductDetailPage> createState() =>
  // ignore: no_logic_in_create_state
  _ProductDetailPageState(item);
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  final Item item;

  _ProductDetailPageState(this.item);

  int quantity = 1;

  /// 총 가격 계산
  int get totalPrice => item.price * quantity;

  void _increaseQuantity() {
    if (quantity < 99) {
      setState(() => quantity += 1);
    }
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() => quantity -= 1);
    }
  }

  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('구매 확인'),
            content: Text('${item.name}을 $quantity개 구매하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 구매 확인 팝업 닫기
                  _showSuccessDialog(); // 구매 완료 팝업
                  item.quantity = quantity;
                  ref.read(cartProvider.notifier).addItem(item);
                },
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: const Text('구매가 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () => context.go(Routes.home),
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go(Routes.home)),
        title: const Text('TITLE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go(Routes.cart);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(aspectRatio: 1.5, child: Text('image')),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item.price}원',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '상품 설명',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(child: Text(item.description)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.grey[300],
              child: Row(
                children: [
                  IconButton(
                    onPressed: _decreaseQuantity,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: _increaseQuantity,
                    icon: const Icon(Icons.add),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('총 가격', style: TextStyle(fontSize: 12)),
                      Text(
                        '${totalPrice}원',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _showPurchaseDialog,
                    child: const Text('구매하기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
