import 'package:encore_shopping_mall/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  void removeItem(Item item) {
    state = state.where((i) => i != item).toList();
  }

  void updateItem(Item oldItem, Item newItem) {
    state = state.map((item) => item == oldItem ? newItem : item).toList();
  }

  void clearCart() {
    state = [];
  }

  void updateQuantity(String id, int quantity) {
    state =
        state
            .map(
              (item) =>
                  item.id == id ? item.copyWith(quantity: quantity) : item,
            )
            .toList();
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<Item>>(() {
  return CartNotifier();
});
